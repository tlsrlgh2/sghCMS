package sghcms.menu.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sghcms.menu.service.UserMenuService;

/**
 * 사용자(프론트) 페이지 요청에 동적 메뉴 트리(userMenuTree)를 주입한다.
 * 헤더 GNB가 DB 기반 메뉴를 렌더링할 수 있게 한다.
 */
public class UserMenuInterceptor implements HandlerInterceptor {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserMenuInterceptor.class);

    private UserMenuService userMenuService;

    public void setUserMenuService(UserMenuService userMenuService) {
        this.userMenuService = userMenuService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!isUserPage(request)) {
            return true;
        }
        try {
            request.setAttribute("userMenuTree", userMenuService.selectMenuTree(true));
        } catch (Exception e) {
            LOGGER.warn("사용자 메뉴 트리 조회에 실패했습니다. 정적 메뉴로 폴백합니다.", e);
            request.setAttribute("userMenuTree", List.of());
        }
        return true;
    }

    /** 사용자 레이아웃이 적용되는 경로(/, /user/*)만 대상으로 한다. */
    private boolean isUserPage(HttpServletRequest request) {
        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());
        return path.equals("/") || path.startsWith("/user/");
    }
}
