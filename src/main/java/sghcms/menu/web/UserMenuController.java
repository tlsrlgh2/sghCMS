package sghcms.menu.web;

import java.util.Optional;
import java.util.regex.Pattern;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.util.UriUtils;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;
import sghcms.menu.service.UserMenu;
import sghcms.menu.service.UserMenuService;

/**
 * 사용자(프론트) 동적 메뉴 라우팅.
 * <p>관리자가 등록한 메뉴의 URL_PATH 로 접근하면 유형에 따라 분기한다.
 * <ul>
 *   <li>CONTENT : 연결된 페이지 콘텐츠를 렌더링</li>
 *   <li>BOARD   : 연결된 eGov 게시판 목록으로 이동</li>
 * </ul>
 */
@Controller
public class UserMenuController {

    /** 게시판 ID 화이트리스트(리다이렉트 인젝션 차단) */
    private static final Pattern BOARD_ID_PATTERN = Pattern.compile("^[A-Za-z0-9_]{1,50}$");

    @Resource(name = "userMenuService")
    private UserMenuService userMenuService;

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    @GetMapping("/user/page/{urlPath}.do")
    public String route(@PathVariable("urlPath") String urlPath, ModelMap model) {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleByUrlPath(urlPath);
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }
        UserMenu menu = menuOpt.get();

        if (UserMenu.TYPE_BOARD.equals(menu.getMenuType())) {
            return resolveBoard(menu);
        }
        if (UserMenu.TYPE_CONTENT.equals(menu.getMenuType())) {
            return resolveContent(menu, model);
        }
        // 폴더 등 직접 진입 대상이 아니면 메인으로
        return "redirect:/user/main.do";
    }

    private String resolveBoard(UserMenu menu) {
        String bbsId = menu.getLinkedKey();
        if (bbsId == null || !BOARD_ID_PATTERN.matcher(bbsId).matches()) {
            return "redirect:/user/main.do";
        }
        // 화이트리스트 통과한 값만 URL 인코딩하여 전달.
        // eGov 관리자 게시판(/cop/bbs/*)이 아닌 사용자 레이아웃 게시판으로 라우팅한다.
        String encoded = UriUtils.encodeQueryParam(bbsId, "UTF-8");
        return "redirect:/user/board/list.do?bbsId=" + encoded;
    }

    private String resolveContent(UserMenu menu, ModelMap model) {
        PageContentVO content = null;
        if (menu.getLinkedKey() != null) {
            content = pageContentService.selectPageContent(menu.getLinkedKey());
        }
        if (content == null) {
            content = new PageContentVO();
            content.setPageTitle(menu.getMenuNm());
            content.setContentHtml("<p>준비 중인 페이지입니다.</p>");
        }
        model.addAttribute("menu", menu);
        model.addAttribute("content", content);
        return "sghcms/user/page/content";
    }
}
