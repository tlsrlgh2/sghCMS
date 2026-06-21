package sghcms.board.web;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import sghcms.board.service.BoardConfigService;
import sghcms.board.service.BoardConfigVO;
import egovframework.com.cop.bbs.service.BoardMaster;

/**
 * eGov 게시판 마스터 화면에 사용자 설정(USER_WRITE_AT, OWN_POST_ONLY_AT)을 연동하는 인터셉터.
 *
 * <ul>
 *   <li>GET /cop/bbs/updateBBSMasterView.do : 수정 폼에 현재 설정값을 모델에 주입</li>
 *   <li>POST /cop/bbs/insertBBSMaster.do    : 등록 후 모델에서 bbsId 추출 → 설정 저장</li>
 *   <li>POST /cop/bbs/updateBBSMaster.do    : 수정 후 request param의 bbsId → 설정 저장</li>
 * </ul>
 */
public class BoardConfigInterceptor implements HandlerInterceptor {

    private BoardConfigService boardConfigService;

    public void setBoardConfigService(BoardConfigService boardConfigService) {
        this.boardConfigService = boardConfigService;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) {

        String uri = request.getRequestURI();
        String method = request.getMethod();

        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/cop/bbs/updateBBSMasterView.do")) {
            // 수정 폼: 현재 설정값 모델 주입 (JSP에서 selected 처리에 사용)
            String bbsId = request.getParameter("bbsId");
            if (bbsId != null && !bbsId.isEmpty() && modelAndView != null) {
                BoardConfigVO config = boardConfigService.selectBoardConfig(bbsId);
                if (config == null) {
                    config = new BoardConfigVO();
                    config.setBbsId(bbsId);
                }
                modelAndView.addObject("boardConfig", config);
            }
            return;
        }

        if ("POST".equalsIgnoreCase(method)) {
            String userWriteAt   = defaultN(request.getParameter("userWriteAt"));
            String ownPostOnlyAt = defaultN(request.getParameter("ownPostOnlyAt"));

            if (uri.endsWith("/cop/bbs/insertBBSMaster.do") && modelAndView != null) {
                // 등록: eGov 서비스가 생성한 bbsId를 모델의 boardMasterVO에서 추출
                Object bm = modelAndView.getModel().get("boardMasterVO");
                if (bm instanceof BoardMaster master && master.getBbsId() != null
                        && !master.getBbsId().isEmpty()) {
                    saveConfig(master.getBbsId(), userWriteAt, ownPostOnlyAt);
                }

            } else if (uri.endsWith("/cop/bbs/updateBBSMaster.do")) {
                // 수정: request param의 bbsId 사용
                String bbsId = request.getParameter("bbsId");
                if (bbsId != null && !bbsId.isEmpty()) {
                    saveConfig(bbsId, userWriteAt, ownPostOnlyAt);
                }
            }
        }
    }

    private void saveConfig(String bbsId, String userWriteAt, String ownPostOnlyAt) {
        BoardConfigVO config = new BoardConfigVO();
        config.setBbsId(bbsId);
        config.setUserWriteAt(userWriteAt);
        config.setOwnPostOnlyAt(ownPostOnlyAt);
        boardConfigService.updateBoardConfig(config);
    }

    private String defaultN(String value) {
        return "Y".equals(value) ? "Y" : "N";
    }
}
