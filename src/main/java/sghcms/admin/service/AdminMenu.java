package sghcms.admin.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Collections;
import java.util.List;

public class AdminMenu {

    private final int menuNo;
    private final int upperMenuNo;
    private final int menuOrder;
    private final String menuName;
    private final String url;
    private final List<AdminMenu> children = new ArrayList<>();

    public AdminMenu(int menuNo, int upperMenuNo, int menuOrder, String menuName, String url) {
        this.menuNo = menuNo;
        this.upperMenuNo = upperMenuNo;
        this.menuOrder = menuOrder;
        this.menuName = menuName;
        this.url = url;
    }

    public int getMenuNo() {
        return menuNo;
    }

    public int getUpperMenuNo() {
        return upperMenuNo;
    }

    public int getMenuOrder() {
        return menuOrder;
    }

    public String getMenuName() {
        return menuName;
    }

    public String getUrl() {
        return url;
    }

    public boolean isFolder() {
        return url == null || url.isBlank() || "dir".equals(url);
    }

    public List<AdminMenu> getChildren() {
        return Collections.unmodifiableList(children);
    }

    public void addChild(AdminMenu child) {
        children.add(child);
    }

    public void sortChildren() {
        children.sort(Comparator.comparingInt(AdminMenu::getMenuOrder)
                .thenComparingInt(AdminMenu::getMenuNo));
        children.forEach(AdminMenu::sortChildren);
    }
}
