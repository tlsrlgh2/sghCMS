package sghcms.user.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;

@Controller
@RequestMapping("/user/space")
public class UserSpaceController {

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    @GetMapping("/guide.do")
    public String guide(ModelMap model) {
        PageContentVO content = pageContentService.selectPageContent("space_guide");
        if (content == null) {
            content = new PageContentVO();
            content.setContentHtml("<p>준비 중인 페이지입니다.</p>");
        }
        model.addAttribute("content", content);
        model.addAttribute("currentPageKey", "guide");
        return "sghcms/user/space/guide";
    }
}
