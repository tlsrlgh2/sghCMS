package sghcms.board.service;

import java.util.List;

public interface BoardConfigService {

    /** 전체 게시판 설정 목록 조회 */
    List<BoardConfigVO> selectBoardConfigList();

    /** 특정 게시판 설정 조회 */
    BoardConfigVO selectBoardConfig(String bbsId);

    /** 게시판 설정 저장 (UPDATE) */
    void updateBoardConfig(BoardConfigVO vo);
}
