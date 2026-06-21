package sghcms.board.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardVO;
import sghcms.board.service.UserBoardService;

@Service("userBoardService")
public class UserBoardServiceImpl implements UserBoardService {

    @Resource(name = "userBoardDAO")
    private UserBoardDAO userBoardDAO;

    @Override
    public List<BoardVO> selectUserArticleList(BoardVO boardVO) {
        return userBoardDAO.selectUserArticleList(boardVO);
    }

    @Override
    public int selectUserArticleListCnt(BoardVO boardVO) {
        return userBoardDAO.selectUserArticleListCnt(boardVO);
    }

    @Override
    public List<BoardVO> selectAdminReplies(BoardVO boardVO) {
        return userBoardDAO.selectAdminReplies(boardVO);
    }
}
