package sghcms.admin.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.com.cmm.LoginVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sghcms.admin.service.AdminMenuService;

public class AdminMenuInterceptor implements HandlerInterceptor {

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminMenuInterceptor.class);
    static final String CURRENT_MENU_SESSION_KEY = "currentAdminMenuNo";
    private static final String[] ADMIN_PATH_PREFIXES = {
            "/admin/",
            "/cop/bbs/",
            "/uss/umt/",
            "/uss/ion/bnr/",
            "/uss/ion/pwm/",
            "/uss/olh/faq/",
            "/uss/olh/qna/",
            "/uss/ion/sit/",
            "/uss/sam/stp/",
            "/sym/mnu/",
            "/sym/prm/",
            "/sym/ccm/",
            "/sec/",
            "/uat/uap/",
            "/sts/",
            "/sym/log/"
    };

    private AdminMenuService adminMenuService;

    public void setAdminMenuService(AdminMenuService adminMenuService) {
        this.adminMenuService = adminMenuService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!isAdminPage(request)) {
            return true;
        }

        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        try {
            request.setAttribute("adminMenuTree", adminMenuService.selectAdminMenuTree(loginVO));
        } catch (Exception e) {
            LOGGER.error("관리자 메뉴 조회에 실패했습니다.", e);
            request.setAttribute("adminMenuTree", List.of());
        }

        String menuNo = request.getParameter("menuNo");
        if (menuNo != null && menuNo.matches("\\d+")) {
            int currentMenuNo = Integer.parseInt(menuNo);
            request.getSession().setAttribute(CURRENT_MENU_SESSION_KEY, currentMenuNo);
            request.setAttribute(CURRENT_MENU_SESSION_KEY, currentMenuNo);
        } else {
            request.setAttribute(CURRENT_MENU_SESSION_KEY,
                    request.getSession().getAttribute(CURRENT_MENU_SESSION_KEY));
        }
        return true;
    }

    private boolean isAdminPage(HttpServletRequest request) {
        String contextPath = request.getContextPath();
        String requestPath = request.getRequestURI().substring(contextPath.length());
        for (String pathPrefix : ADMIN_PATH_PREFIXES) {
            if (requestPath.startsWith(pathPrefix)) {
                return true;
            }
        }
        return false;
    }
}
