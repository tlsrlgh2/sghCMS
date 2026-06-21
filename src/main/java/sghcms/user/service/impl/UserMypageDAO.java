package sghcms.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import sghcms.user.service.UserMypageVO;

@Repository("userMypageDAO")
public class UserMypageDAO extends EgovComAbstractDAO {

    public UserMypageVO selectMberInfo(String mberId) {
        return (UserMypageVO) selectOne("userMypageDAO.selectMberInfo", mberId);
    }

    public void updateMberInfo(UserMypageVO vo) {
        update("userMypageDAO.updateMberInfo", vo);
    }

    public String selectMberPassword(String mberId) {
        return (String) selectOne("userMypageDAO.selectMberPassword", mberId);
    }

    public void updateMberPassword(String mberId, String encPassword) {
        Map<String, String> param = new HashMap<>();
        param.put("mberId", mberId);
        param.put("password", encPassword);
        update("userMypageDAO.updateMberPassword", param);
    }
}
