package sghcms.user.web;

import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;

@Controller
@RequestMapping("/user/support")
public class UserSupportController {

    private static final Set<String> VALID_KEYS = Set.of("policy", "job", "counsel");

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    @GetMapping("/{pageKey}.do")
    public String support(@PathVariable("pageKey") String pageKey, ModelMap model) {
        if (!VALID_KEYS.contains(pageKey)) {
            return "redirect:/user/support/policy.do";
        }
        PageContentVO content = pageContentService.selectPageContent("support_" + pageKey);
        if (content == null) {
            content = new PageContentVO();
            content.setContentHtml("<p>준비 중인 페이지입니다.</p>");
        }
        model.addAttribute("content", content);
        model.addAttribute("currentPageKey", pageKey);
        return "sghcms/user/support/" + pageKey;
    }
}
