package sghcms.user.service;

public interface UserMypageService {
    UserMypageVO getMberInfo(String mberId);
    void updateMberInfo(UserMypageVO vo);
    boolean changePassword(String mberId, String currentPw, String newPw) throws Exception;
}
