package sghcms.menu.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * 사용자(프론트) 페이지 메뉴 VO.
 *
 * <p>MENU_TYPE 에 따라 LINKED_KEY 의 의미가 달라진다.
 * <ul>
 *   <li>FOLDER  : 하위 메뉴를 묶는 그룹. urlPath/linkedKey 사용하지 않음</li>
 *   <li>CONTENT : linkedKey = SGH_PAGE_CONTENT.PAGE_KEY</li>
 *   <li>BOARD   : linkedKey = COMTNBBSMASTER.BBS_ID</li>
 * </ul>
 */
public class UserMenu {

    /** 메뉴 유형 상수 */
    public static final String TYPE_FOLDER = "FOLDER";
    public static final String TYPE_CONTENT = "CONTENT";
    public static final String TYPE_BOARD = "BOARD";

    private Long menuId;
    private String menuNm;
    private String menuType;
    private String urlPath;
    private String linkedKey;
    private Long upperId = 0L;
    private int sortOrdr;
    private String useAt = "Y";
    private Date frstRegistPnttm;
    private String frstRegisterId;
    private Date lastUpdtPnttm;
    private String lastUpdusrId;

    /** 트리 구성을 위한 자식 목록(영속 대상 아님) */
    private final List<UserMenu> children = new ArrayList<>();

    public Long getMenuId() { return menuId; }
    public void setMenuId(Long menuId) { this.menuId = menuId; }

    public String getMenuNm() { return menuNm; }
    public void setMenuNm(String menuNm) { this.menuNm = menuNm; }

    public String getMenuType() { return menuType; }
    public void setMenuType(String menuType) { this.menuType = menuType; }

    public String getUrlPath() { return urlPath; }
    public void setUrlPath(String urlPath) { this.urlPath = urlPath; }

    public String getLinkedKey() { return linkedKey; }
    public void setLinkedKey(String linkedKey) { this.linkedKey = linkedKey; }

    public Long getUpperId() { return upperId; }
    public void setUpperId(Long upperId) { this.upperId = upperId; }

    public int getSortOrdr() { return sortOrdr; }
    public void setSortOrdr(int sortOrdr) { this.sortOrdr = sortOrdr; }

    public String getUseAt() { return useAt; }
    public void setUseAt(String useAt) { this.useAt = useAt; }

    public Date getFrstRegistPnttm() { return frstRegistPnttm; }
    public void setFrstRegistPnttm(Date frstRegistPnttm) { this.frstRegistPnttm = frstRegistPnttm; }

    public String getFrstRegisterId() { return frstRegisterId; }
    public void setFrstRegisterId(String frstRegisterId) { this.frstRegisterId = frstRegisterId; }

    public Date getLastUpdtPnttm() { return lastUpdtPnttm; }
    public void setLastUpdtPnttm(Date lastUpdtPnttm) { this.lastUpdtPnttm = lastUpdtPnttm; }

    public String getLastUpdusrId() { return lastUpdusrId; }
    public void setLastUpdusrId(String lastUpdusrId) { this.lastUpdusrId = lastUpdusrId; }

    public boolean isFolder() { return TYPE_FOLDER.equals(menuType); }

    public boolean isVisible() { return "Y".equals(useAt); }

    public List<UserMenu> getChildren() { return Collections.unmodifiableList(children); }

    public void addChild(UserMenu child) { children.add(child); }

    public void sortChildren() {
        children.sort(Comparator.comparingInt(UserMenu::getSortOrdr)
                .thenComparing(menu -> menu.getMenuId() == null ? 0L : menu.getMenuId()));
        children.forEach(UserMenu::sortChildren);
    }
}
