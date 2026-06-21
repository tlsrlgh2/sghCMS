package sghcms.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.cop.bbs.service.BoardVO;

@Repository("userBoardDAO")
public class UserBoardDAO extends EgovComAbstractDAO {

    public List<BoardVO> selectUserArticleList(BoardVO boardVO) {
        return selectList("UserBoard.selectUserArticleList", boardVO);
    }

    public int selectUserArticleListCnt(BoardVO boardVO) {
        return selectOne("UserBoard.selectUserArticleListCnt", boardVO);
    }

    public List<BoardVO> selectAdminReplies(BoardVO boardVO) {
        return selectList("UserBoard.selectAdminReplies", boardVO);
    }
}
