package sghcms.board.service.impl;

import java.util.List;

import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import sghcms.board.service.BoardConfigService;
import sghcms.board.service.BoardConfigVO;

@Service("boardConfigService")
public class BoardConfigServiceImpl implements BoardConfigService {

    @Resource(name = "boardConfigDAO")
    private BoardConfigDAO boardConfigDAO;

    @Override
    public List<BoardConfigVO> selectBoardConfigList() {
        return boardConfigDAO.selectBoardConfigList();
    }

    @Override
    public BoardConfigVO selectBoardConfig(String bbsId) {
        return boardConfigDAO.selectBoardConfig(bbsId);
    }

    @Override
    public void updateBoardConfig(BoardConfigVO vo) {
        boardConfigDAO.updateBoardConfig(vo);
    }
}
