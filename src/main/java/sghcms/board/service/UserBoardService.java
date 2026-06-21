package sghcms.board.service;

import java.util.List;

import egovframework.com.cop.bbs.service.BoardVO;

public interface UserBoardService {

    List<BoardVO> selectUserArticleList(BoardVO boardVO);

    int selectUserArticleListCnt(BoardVO boardVO);

    List<BoardVO> selectAdminReplies(BoardVO boardVO);
}
