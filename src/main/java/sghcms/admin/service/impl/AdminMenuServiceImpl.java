package sghcms.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import jakarta.annotation.Resource;
import sghcms.admin.service.AdminMenu;
import sghcms.admin.service.AdminMenuService;

@Service("adminMenuService")
public class AdminMenuServiceImpl implements AdminMenuService {

    private static final int CMS_ROOT_MENU_NO = 90000000;

    @Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

    @Override
    public List<AdminMenu> selectAdminMenuTree(LoginVO loginVO) throws Exception {
        if (loginVO == null || loginVO.getUniqId() == null || loginVO.getUniqId().isBlank()) {
            return List.of();
        }

        MenuManageVO searchVO = new MenuManageVO();
        searchVO.setTmpUniqId(loginVO.getUniqId());

        List<?> menuRows = menuManageService.selectMainMenuLeft(searchVO);
        Map<Integer, AdminMenu> menuMap = new HashMap<>();

        for (Object row : menuRows) {
            if (!(row instanceof EgovMap menuRow)) {
                continue;
            }

            int menuNo = intValue(menuRow.get("menuNo"));
            menuMap.put(menuNo, new AdminMenu(
                    menuNo,
                    intValue(menuRow.get("upperMenuId")),
                    intValue(menuRow.get("menuOrdr")),
                    stringValue(menuRow.get("menuNm")),
                    stringValue(menuRow.get("chkUrl"))));
        }

        AdminMenu rootMenu = menuMap.get(CMS_ROOT_MENU_NO);
        if (rootMenu == null) {
            return List.of();
        }

        for (AdminMenu menu : menuMap.values()) {
            AdminMenu parent = menuMap.get(menu.getUpperMenuNo());
            if (parent != null && menu.getMenuNo() != CMS_ROOT_MENU_NO) {
                parent.addChild(menu);
            }
        }

        rootMenu.sortChildren();
        return rootMenu.getChildren();
    }

    @Override
    public Optional<AdminMenu> findAccessibleMenu(LoginVO loginVO, int menuNo) throws Exception {
        for (AdminMenu menu : selectAdminMenuTree(loginVO)) {
            Optional<AdminMenu> foundMenu = findMenu(menu, menuNo);
            if (foundMenu.isPresent()) {
                return foundMenu;
            }
        }
        return Optional.empty();
    }

    private Optional<AdminMenu> findMenu(AdminMenu menu, int menuNo) {
        if (menu.getMenuNo() == menuNo) {
            return Optional.of(menu);
        }
        for (AdminMenu child : menu.getChildren()) {
            Optional<AdminMenu> foundMenu = findMenu(child, menuNo);
            if (foundMenu.isPresent()) {
                return foundMenu;
            }
        }
        return Optional.empty();
    }

    private int intValue(Object value) {
        return value instanceof Number number ? number.intValue() : Integer.parseInt(String.valueOf(value));
    }

    private String stringValue(Object value) {
        return value == null ? "" : String.valueOf(value);
    }
}
