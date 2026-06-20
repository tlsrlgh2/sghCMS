package sghcms.admin.web;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.LoginVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import sghcms.admin.service.AdminMenu;
import sghcms.admin.service.AdminMenuService;

@Controller
@RequestMapping("/admin/cms")
public class AdminCmsController {

    private static final String CURRENT_MENU_SESSION_KEY = "currentAdminMenuNo";

    @Resource(name = "adminMenuService")
    private AdminMenuService adminMenuService;

    @GetMapping("/open.do")
    public String openMenu(@RequestParam("menuNo") int menuNo, HttpServletRequest request) throws Exception {
        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        Optional<AdminMenu> accessibleMenu = adminMenuService.findAccessibleMenu(loginVO, menuNo);

        if (accessibleMenu.isEmpty() || accessibleMenu.get().isFolder()) {
            return "redirect:/admin/dashboard.do";
        }

        String targetUrl = accessibleMenu.get().getUrl();
        boolean isSghAdminContent = targetUrl.startsWith("/admin/content/");
        if (!targetUrl.startsWith("/") || !targetUrl.endsWith(".do")
                || (targetUrl.startsWith("/admin/") && !isSghAdminContent)) {
            throw new IllegalArgumentException("허용되지 않은 관리자 메뉴 URL입니다.");
        }

        request.getSession().setAttribute(CURRENT_MENU_SESSION_KEY, menuNo);
        return "forward:" + targetUrl;
    }
}
