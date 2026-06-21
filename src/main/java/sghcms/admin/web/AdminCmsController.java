package sghcms.admin.web;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import sghcms.admin.service.AdminMenu;

@Controller
@RequestMapping("/admin/cms")
public class AdminCmsController {

    @GetMapping("/open.do")
    public String openMenu(@RequestParam("menuNo") int menuNo, HttpServletRequest request) {
        @SuppressWarnings("unchecked")
        List<AdminMenu> menuTree = (List<AdminMenu>) request.getAttribute("adminMenuTree");

        Optional<AdminMenu> accessibleMenu = findInTree(
                menuTree != null ? menuTree : List.of(), menuNo);

        if (accessibleMenu.isEmpty() || accessibleMenu.get().isFolder()) {
            return "redirect:/admin/dashboard.do";
        }

        String targetUrl = accessibleMenu.get().getUrl();
        if (!isAllowedMenuUrl(targetUrl)) {
            return "redirect:/admin/dashboard.do";
        }

        request.getSession().setAttribute(AdminMenuInterceptor.CURRENT_MENU_SESSION_KEY, menuNo);
        return "forward:" + targetUrl;
    }

    private boolean isAllowedMenuUrl(String url) {
        if (!url.startsWith("/") || !url.endsWith(".do")) {
            return false;
        }
        return true;
    }

    private Optional<AdminMenu> findInTree(List<AdminMenu> tree, int menuNo) {
        for (AdminMenu menu : tree) {
            Optional<AdminMenu> found = findMenu(menu, menuNo);
            if (found.isPresent()) {
                return found;
            }
        }
        return Optional.empty();
    }

    private Optional<AdminMenu> findMenu(AdminMenu menu, int menuNo) {
        if (menu.getMenuNo() == menuNo) {
            return Optional.of(menu);
        }
        for (AdminMenu child : menu.getChildren()) {
            Optional<AdminMenu> found = findMenu(child, menuNo);
            if (found.isPresent()) {
                return found;
            }
        }
        return Optional.empty();
    }
}
