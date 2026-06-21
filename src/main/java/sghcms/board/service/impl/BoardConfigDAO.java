package sghcms.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import sghcms.board.service.BoardConfigVO;

@Repository("boardConfigDAO")
public class BoardConfigDAO extends EgovComAbstractDAO {

    public List<BoardConfigVO> selectBoardConfigList() {
        return selectList("BoardConfig.selectBoardConfigList", new BoardConfigVO());
    }

    public BoardConfigVO selectBoardConfig(String bbsId) {
        BoardConfigVO param = new BoardConfigVO();
        param.setBbsId(bbsId);
        return selectOne("BoardConfig.selectBoardConfig", param);
    }

    public void updateBoardConfig(BoardConfigVO vo) {
        update("BoardConfig.updateBoardConfig", vo);
    }
}
