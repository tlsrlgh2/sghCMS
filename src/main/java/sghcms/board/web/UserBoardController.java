package sghcms.board.web;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovArticleService;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import jakarta.annotation.Resource;
import sghcms.menu.service.UserMenu;
import sghcms.menu.service.UserMenuService;

/**
 * 사용자(프론트) 게시판.
 *
 * <p>관리자가 등록한 BOARD 유형 사용자 메뉴에 연결된 eGov 게시판을
 * 사용자 레이아웃(SiteMesh {@code /user/*})으로 렌더링한다.
 * eGov 기본 게시판(/cop/bbs/*)은 관리자 레이아웃·로그인 게이트가 걸려 있어
 * 사용자 페이지에 노출하기에 부적합하므로 별도 화면으로 분리한다.</p>
 *
 * <p>보안: 노출 중인 BOARD 메뉴에 연결된 게시판만 공개한다(임의 게시판 노출 차단).
 * 비밀글은 사용자 화면에서 노출하지 않는다.</p>
 */
@Controller
@RequestMapping("/user/board")
public class UserBoardController {

    @Resource(name = "EgovArticleService")
    private EgovArticleService articleService;

    @Resource(name = "EgovBBSMasterService")
    private EgovBBSMasterService bbsMasterService;

    @Resource(name = "userMenuService")
    private UserMenuService userMenuService;

    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;

    /** 게시물 목록 */
    @GetMapping("/list.do")
    public String list(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }

        BoardMasterVO masterParam = new BoardMasterVO();
        masterParam.setBbsId(boardVO.getBbsId());
        masterParam.setUniqId("");
        BoardMasterVO master = bbsMasterService.selectBBSMasterInf(masterParam);

        int pageIndex = boardVO.getPageIndex() == null ? 1 : boardVO.getPageIndex();
        int pageUnit = propertyService.getInt("pageUnit");
        int pageSize = propertyService.getInt("pageSize");
        boardVO.setPageIndex(pageIndex);
        boardVO.setPageUnit(pageUnit);
        boardVO.setPageSize(pageSize);

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(pageIndex);
        paginationInfo.setRecordCountPerPage(pageUnit);
        paginationInfo.setPageSize(pageSize);

        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = articleService.selectArticleList(boardVO);
        int totCnt = Integer.parseInt((String) map.get("resultCnt"));
        paginationInfo.setTotalRecordCount(totCnt);

        List<BoardVO> noticeList = articleService.selectNoticeArticleList(boardVO);

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("resultCnt", map.get("resultCnt"));
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("searchVO", boardVO);
        return "sghcms/user/board/list";
    }

    /** 게시물 상세 */
    @GetMapping("/view.do")
    public String view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty() || boardVO.getNttId() == null) {
            return "redirect:/user/main.do";
        }

        BoardVO detail = articleService.selectArticleDetail(boardVO);
        // 게시물이 없거나 비밀글이면 목록으로 되돌린다(사용자 화면 비노출).
        if (detail == null || detail.getNttId() == null || "Y".equals(detail.getSecretAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        BoardMasterVO masterParam = new BoardMasterVO();
        masterParam.setBbsId(boardVO.getBbsId());
        BoardMasterVO master = bbsMasterService.selectBBSMasterInf(masterParam);

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("result", detail);
        model.addAttribute("searchVO", boardVO);
        return "sghcms/user/board/view";
    }
}
