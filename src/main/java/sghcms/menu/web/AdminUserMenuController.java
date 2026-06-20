package sghcms.menu.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import sghcms.cmm.HtmlTagFilterDecoder;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;
import sghcms.menu.service.UserMenu;
import sghcms.menu.service.UserMenuService;

/**
 * 관리자 - 사용자 메뉴관리.
 * 사용자(프론트) 페이지 메뉴를 등록하고 콘텐츠/게시판과 연결한다.
 */
@Controller
@RequestMapping("/admin/content/userMenu")
public class AdminUserMenuController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminUserMenuController.class);

    @Resource(name = "userMenuService")
    private UserMenuService userMenuService;

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    @Resource(name = "EgovBBSMasterService")
    private EgovBBSMasterService bbsMasterService;

    @GetMapping("/list.do")
    public String list(@RequestParam(name = "editId", required = false) Long editId, ModelMap model) {
        model.addAttribute("menuList", userMenuService.selectMenuList());
        model.addAttribute("boardList", loadBoardList());

        if (editId != null) {
            UserMenu editMenu = userMenuService.selectMenu(editId);
            model.addAttribute("editMenu", editMenu);
        }
        return "admin/content/userMenu/list";
    }

    @PostMapping("/save.do")
    public String save(@ModelAttribute UserMenu menu, HttpServletRequest request,
                       RedirectAttributes redirectAttributes) {
        String actorId = currentUserId(request);
        try {
            if (menu.getMenuId() == null) {
                menu.setFrstRegisterId(actorId);
                menu.setLastUpdusrId(actorId);
                userMenuService.insertMenu(menu);
                redirectAttributes.addFlashAttribute("message", "메뉴가 등록되었습니다.");
            } else {
                menu.setLastUpdusrId(actorId);
                userMenuService.updateMenu(menu);
                redirectAttributes.addFlashAttribute("message", "메뉴가 수정되었습니다.");
            }
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/admin/content/userMenu/list.do";
    }

    @PostMapping("/delete.do")
    public String delete(@RequestParam("menuId") long menuId, RedirectAttributes redirectAttributes) {
        try {
            userMenuService.deleteMenu(menuId);
            redirectAttributes.addFlashAttribute("message", "메뉴가 삭제되었습니다.");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/admin/content/userMenu/list.do";
    }

    /**
     * CONTENT 메뉴에 종속된 콘텐츠 편집 화면.
     * 콘텐츠 키는 메뉴에서 서버가 도출하며 클라이언트로부터 받지 않는다.
     */
    @GetMapping("/contentEdit.do")
    public String contentEdit(@RequestParam("menuId") long menuId,
                              @RequestParam(name = "saved", required = false) String saved,
                              ModelMap model) {
        UserMenu menu = userMenuService.selectMenu(menuId);
        if (menu == null || !UserMenu.TYPE_CONTENT.equals(menu.getMenuType()) || menu.getLinkedKey() == null) {
            return "redirect:/admin/content/userMenu/list.do";
        }
        PageContentVO content = pageContentService.selectPageContent(menu.getLinkedKey());
        if (content == null) {
            content = new PageContentVO();
            content.setPageKey(menu.getLinkedKey());
            content.setPageTitle(menu.getMenuNm());
            content.setContentHtml("");
        }
        model.addAttribute("menu", menu);
        model.addAttribute("content", content);
        model.addAttribute("saved", "true".equals(saved));
        return "admin/content/userMenu/contentEdit";
    }

    @PostMapping("/contentSave.do")
    public String contentSave(@RequestParam("menuId") long menuId,
                              @RequestParam(name = "contentHtml", required = false) String contentHtml,
                              HttpServletRequest request, RedirectAttributes redirectAttributes) {
        UserMenu menu = userMenuService.selectMenu(menuId);
        if (menu == null || !UserMenu.TYPE_CONTENT.equals(menu.getMenuType()) || menu.getLinkedKey() == null) {
            return "redirect:/admin/content/userMenu/list.do";
        }
        // 키·제목은 메뉴에서 서버가 결정한다(클라이언트 입력 신뢰하지 않음).
        // 본문은 HTMLTagFilter 인코딩을 원복한 뒤 서비스에서 OWASP 새니타이즈된다.
        PageContentVO vo = new PageContentVO();
        vo.setPageKey(menu.getLinkedKey());
        vo.setPageTitle(menu.getMenuNm());
        vo.setContentHtml(HtmlTagFilterDecoder.decode(contentHtml == null ? "" : contentHtml));
        vo.setUpdusr(currentUserId(request));
        pageContentService.savePageContent(vo);

        redirectAttributes.addFlashAttribute("message", "콘텐츠가 저장되었습니다.");
        redirectAttributes.addFlashAttribute("messageType", "success");
        return "redirect:/admin/content/userMenu/contentEdit.do?menuId=" + menuId + "&saved=true";
    }

    private String currentUserId(HttpServletRequest request) {
        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        return loginVO == null ? null : loginVO.getId();
    }

    /**
     * 게시판 연결용 목록을 조회한다. 게시판 모듈 오류가 메뉴 관리 화면을 막지 않도록 방어적으로 처리한다.
     */
    @SuppressWarnings("unchecked")
    private List<BoardMasterVO> loadBoardList() {
        try {
            BoardMasterVO searchVO = new BoardMasterVO();
            searchVO.setFirstIndex(0);
            searchVO.setLastIndex(1000);
            searchVO.setRecordCountPerPage(1000);
            searchVO.setPageIndex(1);
            searchVO.setPageUnit(1000);
            searchVO.setPageSize(10);
            Map<String, Object> result = bbsMasterService.selectBBSMasterInfs(searchVO);
            Object resultList = result.get("resultList");
            if (resultList instanceof List<?> list) {
                return (List<BoardMasterVO>) list;
            }
        } catch (Exception e) {
            LOGGER.warn("게시판 목록 조회에 실패했습니다. 게시판 연결은 직접 입력으로 진행됩니다.", e);
        }
        return new ArrayList<>();
    }
}
