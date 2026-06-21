package sghcms.user.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import jakarta.annotation.Resource;
import sghcms.user.service.UserMypageService;
import sghcms.user.service.UserMypageVO;

@Service("userMypageService")
public class UserMypageServiceImpl extends EgovAbstractServiceImpl implements UserMypageService {

    @Resource(name = "userMypageDAO")
    private UserMypageDAO userMypageDAO;

    @Override
    public UserMypageVO getMberInfo(String mberId) {
        return userMypageDAO.selectMberInfo(mberId);
    }

    @Override
    public void updateMberInfo(UserMypageVO vo) {
        userMypageDAO.updateMberInfo(vo);
    }

    @Override
    public boolean changePassword(String mberId, String currentPw, String newPw) throws Exception {
        String storedPw = userMypageDAO.selectMberPassword(mberId);
        String encCurrentPw = EgovFileScrty.encryptPassword(currentPw, EgovStringUtil.isNullToString(mberId));
        if (!encCurrentPw.equals(storedPw)) {
            return false;
        }
        String encNewPw = EgovFileScrty.encryptPassword(newPw, EgovStringUtil.isNullToString(mberId));
        userMypageDAO.updateMberPassword(mberId, encNewPw);
        return true;
    }
}
