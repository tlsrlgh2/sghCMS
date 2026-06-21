package sghcms.board.web;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovArticleService;
import egovframework.com.cop.bbs.service.EgovBBSMasterService;
import jakarta.annotation.Resource;
import sghcms.board.service.BoardConfigService;
import sghcms.board.service.BoardConfigVO;
import sghcms.board.service.UserBoardService;
import sghcms.cmm.HtmlTagFilterDecoder;
import sghcms.menu.service.UserMenu;
import sghcms.menu.service.UserMenuService;

/**
 * 사용자(프론트) 게시판.
 *
 * <p>관리자가 등록한 BOARD 유형 사용자 메뉴에 연결된 eGov 게시판을
 * 사용자 레이아웃(SiteMesh {@code /user/*})으로 렌더링한다.</p>
 *
 * <p>게시판별 사용자 설정(USER_WRITE_AT, OWN_POST_ONLY_AT)을 읽어
 * 코드 수정 없이 동작을 제어한다.</p>
 *
 * <p>보안: 노출 중인 BOARD 메뉴에 연결된 게시판만 공개한다(임의 게시판 노출 차단).
 * 비밀글은 사용자 화면에서 노출하지 않는다.</p>
 */
@Controller
@RequestMapping("/user/board")
public class UserBoardController {

    private static final PolicyFactory CONTENT_POLICY = Sanitizers.FORMATTING
            .and(Sanitizers.LINKS)
            .and(Sanitizers.IMAGES)
            .and(Sanitizers.TABLES)
            .and(Sanitizers.BLOCKS)
            .and(Sanitizers.STYLES);

    @Resource(name = "EgovArticleService")
    private EgovArticleService articleService;

    @Resource(name = "EgovBBSMasterService")
    private EgovBBSMasterService bbsMasterService;

    @Resource(name = "userMenuService")
    private UserMenuService userMenuService;

    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;

    @Resource(name = "boardConfigService")
    private BoardConfigService boardConfigService;

    @Resource(name = "userBoardService")
    private UserBoardService userBoardService;

    private LoginVO currentUser() {
        return (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    }

    // -------------------------------------------------------------------------
    // 열람
    // -------------------------------------------------------------------------

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

        List<BoardVO> resultList = userBoardService.selectUserArticleList(boardVO);
        int totCnt = userBoardService.selectUserArticleListCnt(boardVO);
        paginationInfo.setTotalRecordCount(totCnt);

        List<BoardVO> noticeList = articleService.selectNoticeArticleList(boardVO);
        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", Integer.toString(totCnt));
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("searchVO", boardVO);
        model.addAttribute("boardConfig", boardConfig);
        model.addAttribute("isAuthenticated", isAuthenticated);
        return "sghcms/user/board/list";
    }

    /** 게시물 상세 */
    @GetMapping("/view.do")
    public String view(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty() || boardVO.getNttId() == null) {
            return "redirect:/user/main.do";
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        BoardVO detail = articleService.selectArticleDetail(boardVO);

        if (detail == null || detail.getNttId() == null || "Y".equals(detail.getSecretAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        // 본인 글만 접근 설정인 경우 — 비로그인 또는 타인이면 목록으로 차단
        if (boardConfig != null && "Y".equals(boardConfig.getOwnPostOnlyAt())) {
            LoginVO loginUser = currentUser();
            if (loginUser == null || !loginUser.getUniqId().equals(detail.getFrstRegisterId())) {
                return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
            }
        }

        BoardMasterVO masterParam = new BoardMasterVO();
        masterParam.setBbsId(boardVO.getBbsId());
        BoardMasterVO master = bbsMasterService.selectBBSMasterInf(masterParam);

        String contentHtml = CONTENT_POLICY.sanitize(HtmlTagFilterDecoder.decode(detail.getNttCn()));

        // 관리자 답글 조회 (목록에서는 숨기고 상세에서만 노출)
        List<BoardVO> adminReplies = userBoardService.selectAdminReplies(boardVO);
        for (BoardVO reply : adminReplies) {
            reply.setNttCn(CONTENT_POLICY.sanitize(HtmlTagFilterDecoder.decode(reply.getNttCn())));
        }

        // 현재 로그인 사용자가 작성자인지 여부를 JSP에 전달
        LoginVO loginUser = currentUser();
        boolean isOwner = loginUser != null && loginUser.getUniqId().equals(detail.getFrstRegisterId());

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("result", detail);
        model.addAttribute("contentHtml", contentHtml);
        model.addAttribute("adminReplies", adminReplies);
        model.addAttribute("searchVO", boardVO);
        model.addAttribute("boardConfig", boardConfig);
        model.addAttribute("isOwner", isOwner);
        return "sghcms/user/board/view";
    }

    // -------------------------------------------------------------------------
    // 작성 (userWriteAt = Y 게시판만)
    // -------------------------------------------------------------------------

    /** 글쓰기 폼 */
    @GetMapping("/write.do")
    public String write(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        if (boardConfig == null || !"Y".equals(boardConfig.getUserWriteAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        if (!EgovUserDetailsHelper.isAuthenticated()) {
            return "redirect:/user/login.do";
        }

        BoardMasterVO masterParam = new BoardMasterVO();
        masterParam.setBbsId(boardVO.getBbsId());
        masterParam.setUniqId("");
        BoardMasterVO master = bbsMasterService.selectBBSMasterInf(masterParam);

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("searchVO", boardVO);
        model.addAttribute("boardConfig", boardConfig);
        model.addAttribute("articleVO", new BoardVO());
        return "sghcms/user/board/write";
    }

    /** 글쓰기 저장 */
    @PostMapping("/writeSave.do")
    public String writeSave(final MultipartHttpServletRequest multiRequest,
            @ModelAttribute("searchVO") BoardVO boardVO,
            @ModelAttribute("articleVO") BoardVO board,
            ModelMap model) throws Exception {

        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        if (boardConfig == null || !"Y".equals(boardConfig.getUserWriteAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        LoginVO user = currentUser();
        if (user == null) {
            return "redirect:/user/login.do";
        }

        board.setBbsId(boardVO.getBbsId());
        board.setFrstRegisterId(user.getUniqId());
        board.setNtcrId(user.getUniqId());
        board.setNtcrNm(user.getName());

        List<MultipartFile> files = multiRequest.getFiles("file_1");
        articleService.insertArticleAndFiles(board, files);

        return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
    }

    // -------------------------------------------------------------------------
    // 수정 (ownPostOnlyAt = Y 이면 본인 글만)
    // -------------------------------------------------------------------------

    /** 수정 폼 */
    @GetMapping("/modify.do")
    public String modify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty() || boardVO.getNttId() == null) {
            return "redirect:/user/main.do";
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        if (boardConfig == null || !"Y".equals(boardConfig.getUserWriteAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        LoginVO user = currentUser();
        if (user == null) {
            return "redirect:/user/login.do";
        }

        BoardVO detail = articleService.selectArticleDetail(boardVO);
        if (detail == null || detail.getNttId() == null) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        // 본인 글이 아니면 차단
        if (!user.getUniqId().equals(detail.getFrstRegisterId())) {
            return "redirect:/user/board/view.do?bbsId=" + boardVO.getBbsId() + "&nttId=" + boardVO.getNttId();
        }

        BoardMasterVO masterParam = new BoardMasterVO();
        masterParam.setBbsId(boardVO.getBbsId());
        masterParam.setUniqId("");
        BoardMasterVO master = bbsMasterService.selectBBSMasterInf(masterParam);

        model.addAttribute("menu", menuOpt.get());
        model.addAttribute("boardMasterVO", master);
        model.addAttribute("articleVO", detail);
        model.addAttribute("searchVO", boardVO);
        model.addAttribute("boardConfig", boardConfig);
        return "sghcms/user/board/modify";
    }

    /** 수정 저장 */
    @PostMapping("/modifySave.do")
    public String modifySave(final MultipartHttpServletRequest multiRequest,
            @ModelAttribute("searchVO") BoardVO boardVO,
            @ModelAttribute("articleVO") BoardVO board,
            ModelMap model) throws Exception {

        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        if (boardConfig == null || !"Y".equals(boardConfig.getUserWriteAt())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        LoginVO user = currentUser();
        if (user == null) {
            return "redirect:/user/login.do";
        }

        // 원본 작성자 재확인 (파라미터 위변조 방지)
        BoardVO original = articleService.selectArticleDetail(boardVO);
        if (original == null || !user.getUniqId().equals(original.getFrstRegisterId())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        board.setBbsId(boardVO.getBbsId());
        board.setLastUpdusrId(user.getUniqId());
        board.setNtcrNm("");
        board.setPassword("");

        String atchFileId = boardVO.getAtchFileId();
        List<MultipartFile> files = multiRequest.getFiles("file_1");
        articleService.updateArticleAndFiles(board, files, atchFileId);

        return "redirect:/user/board/view.do?bbsId=" + boardVO.getBbsId() + "&nttId=" + board.getNttId()
                + "&pageIndex=" + boardVO.getPageIndex();
    }

    // -------------------------------------------------------------------------
    // 삭제 (본인 글만)
    // -------------------------------------------------------------------------

    /** 게시물 삭제 */
    @PostMapping("/delete.do")
    public String delete(@ModelAttribute("searchVO") BoardVO boardVO,
            @ModelAttribute("articleVO") BoardVO board,
            ModelMap model) throws Exception {

        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty()) {
            return "redirect:/user/main.do";
        }

        LoginVO user = currentUser();
        if (user == null) {
            return "redirect:/user/login.do";
        }

        // 원본 작성자 재확인 (파라미터 위변조 방지)
        BoardVO original = articleService.selectArticleDetail(boardVO);
        if (original == null || !user.getUniqId().equals(original.getFrstRegisterId())) {
            return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId();
        }

        board.setBbsId(boardVO.getBbsId());
        board.setLastUpdusrId(user.getUniqId());
        articleService.deleteArticle(board);

        return "redirect:/user/board/list.do?bbsId=" + boardVO.getBbsId() + "&pageIndex=" + boardVO.getPageIndex();
    }

    // -------------------------------------------------------------------------
    // AJAX 접근 권한 확인 (ownPostOnlyAt 게시판용)
    // -------------------------------------------------------------------------

    /** 게시물 클릭 전 접근 가능 여부 확인 */
    @GetMapping("/checkAccess.do")
    @ResponseBody
    public Map<String, Object> checkAccess(@ModelAttribute BoardVO boardVO) throws Exception {
        Optional<UserMenu> menuOpt = userMenuService.findVisibleBoardByBbsId(boardVO.getBbsId());
        if (menuOpt.isEmpty() || boardVO.getNttId() == null) {
            return Map.of("canAccess", false);
        }

        BoardConfigVO boardConfig = boardConfigService.selectBoardConfig(boardVO.getBbsId());
        if (boardConfig == null || !"Y".equals(boardConfig.getOwnPostOnlyAt())) {
            return Map.of("canAccess", true);
        }

        LoginVO loginUser = currentUser();
        if (loginUser == null) {
            return Map.of("canAccess", false);
        }

        BoardVO detail = articleService.selectArticleDetail(boardVO);
        if (detail == null || detail.getNttId() == null) {
            return Map.of("canAccess", false);
        }

        return Map.of("canAccess", loginUser.getUniqId().equals(detail.getFrstRegisterId()));
    }
}
