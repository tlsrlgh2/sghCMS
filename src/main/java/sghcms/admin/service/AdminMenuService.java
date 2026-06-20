package sghcms.admin.service;

import java.util.List;

import egovframework.com.cmm.LoginVO;

public interface AdminMenuService {

    List<AdminMenu> selectAdminMenuTree(LoginVO loginVO) throws Exception;
}
