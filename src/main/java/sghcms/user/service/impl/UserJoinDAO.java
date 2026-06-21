package sghcms.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("userJoinDAO")
public class UserJoinDAO extends EgovComAbstractDAO {

    public boolean existsMberId(String mberId) {
        Integer cnt = (Integer) selectOne("userJoinDAO.countByMberId", mberId);
        return cnt != null && cnt > 0;
    }

    public void insertDefaultUserAuthority(String mberId) {
        insert("userJoinDAO.insertDefaultUserAuthority", mberId);
    }

    public String findEmailByMberInfo(String mberId, String mberNm, String email) {
        Map<String, String> param = new HashMap<>();
        param.put("mberId", mberId);
        param.put("mberNm", mberNm);
        param.put("email", email);
        return (String) selectOne("userJoinDAO.findEmailByMberInfo", param);
    }

    public void updateMberPassword(String mberId, String encPassword) {
        Map<String, String> param = new HashMap<>();
        param.put("mberId", mberId);
        param.put("password", encPassword);
        update("userJoinDAO.updateMberPassword", param);
    }
}
