package sghcms.content.web;

import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.LoginVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import sghcms.cmm.HtmlTagFilterDecoder;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;

@Controller
@RequestMapping("/admin/content/pageContent")
public class AdminPageContentController {

    private static final Set<String> VALID_KEYS = Set.of(
            "about_intro", "about_facility", "about_org", "about_location",
            "space_guide",
            "support_policy", "support_job", "support_counsel"
    );

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    @GetMapping("/edit.do")
    public String edit(@RequestParam(name = "pageKey", defaultValue = "about_intro") String pageKey,
                       @RequestParam(name = "saved", required = false) String saved,
                       ModelMap model) {
        if (!VALID_KEYS.contains(pageKey)) {
            pageKey = "about_intro";
        }
        PageContentVO content = pageContentService.selectPageContent(pageKey);
        if (content == null) {
            content = new PageContentVO();
            content.setPageKey(pageKey);
            content.setPageTitle(getDefaultTitle(pageKey));
            content.setContentHtml("");
        }
        List<PageContentVO> allContents = pageContentService.selectAllPageContents();
        model.addAttribute("content", content);
        model.addAttribute("allContents", allContents);
        model.addAttribute("saved", "true".equals(saved));
        model.addAttribute("previewUrl", buildPreviewUrl(pageKey));
        return "admin/content/pageContent/edit";
    }

    private String buildPreviewUrl(String pageKey) {
        String[] parts = pageKey.split("_", 2);
        if (parts.length != 2) return null;
        return "/user/" + parts[0] + "/" + parts[1] + ".do";
    }

    @PostMapping("/save.do")
    public String save(@ModelAttribute PageContentVO vo, HttpServletRequest request) {
        if (!VALID_KEYS.contains(vo.getPageKey())) {
            return "redirect:/admin/content/pageContent/edit.do";
        }
        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        if (loginVO != null) {
            vo.setUpdusr(loginVO.getId());
        }
        // HTMLTagFilter 가 *.do 파라미터를 인코딩하므로 본문을 원복 후 저장(서비스에서 새니타이즈).
        vo.setContentHtml(HtmlTagFilterDecoder.decode(vo.getContentHtml()));
        pageContentService.savePageContent(vo);
        return "redirect:/admin/content/pageContent/edit.do?pageKey=" + vo.getPageKey() + "&saved=true";
    }

    private String getDefaultTitle(String pageKey) {
        return switch (pageKey) {
            case "about_intro"    -> "공간 소개";
            case "about_facility" -> "시설 안내";
            case "about_org"      -> "운영 조직";
            case "about_location" -> "오시는 길";
            case "space_guide"    -> "대관 안내";
            case "support_policy" -> "청년정책";
            case "support_job"    -> "일자리 정보";
            case "support_counsel"-> "청년 상담";
            default               -> pageKey;
        };
    }
}
