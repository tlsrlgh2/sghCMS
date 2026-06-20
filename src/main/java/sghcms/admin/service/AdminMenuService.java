package sghcms.admin.service;

import java.util.List;
import java.util.Optional;

import egovframework.com.cmm.LoginVO;

public interface AdminMenuService {

    List<AdminMenu> selectAdminMenuTree(LoginVO loginVO) throws Exception;

    Optional<AdminMenu> findAccessibleMenu(LoginVO loginVO, int menuNo) throws Exception;
}
