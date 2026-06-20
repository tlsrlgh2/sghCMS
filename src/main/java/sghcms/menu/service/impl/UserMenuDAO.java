package sghcms.menu.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import sghcms.menu.service.UserMenu;

@Repository("userMenuDAO")
public class UserMenuDAO extends EgovComAbstractDAO {

    public List<UserMenu> selectMenuList() {
        return selectList("UserMenu.selectMenuList", null);
    }

    public List<UserMenu> selectVisibleMenuList() {
        return selectList("UserMenu.selectVisibleMenuList", null);
    }

    public UserMenu selectMenu(long menuId) {
        return selectOne("UserMenu.selectMenu", menuId);
    }

    public UserMenu selectVisibleByUrlPath(String urlPath) {
        return selectOne("UserMenu.selectVisibleByUrlPath", urlPath);
    }

    public int countByUrlPath(UserMenu menu) {
        return selectOne("UserMenu.countByUrlPath", menu);
    }

    public int countChildren(long menuId) {
        return selectOne("UserMenu.countChildren", menuId);
    }

    public void insertMenu(UserMenu menu) {
        insert("UserMenu.insertMenu", menu);
    }

    public void updateMenu(UserMenu menu) {
        update("UserMenu.updateMenu", menu);
    }

    public void deleteMenu(long menuId) {
        delete("UserMenu.deleteMenu", menuId);
    }
}
