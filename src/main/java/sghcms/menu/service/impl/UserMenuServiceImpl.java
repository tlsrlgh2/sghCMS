package sghcms.menu.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.menu.service.UserMenu;
import sghcms.menu.service.UserMenuService;

@Service("userMenuService")
public class UserMenuServiceImpl implements UserMenuService {

    /** 허용 메뉴 유형 화이트리스트 */
    private static final Set<String> VALID_TYPES =
            Set.of(UserMenu.TYPE_FOLDER, UserMenu.TYPE_CONTENT, UserMenu.TYPE_BOARD);

    /** URL 슬러그: 영소문자/숫자/하이픈 (경로 traversal·XSS 차단) */
    private static final Pattern URL_PATH_PATTERN = Pattern.compile("^[a-z0-9][a-z0-9-]{0,49}$");

    /** 페이지 콘텐츠 키: 영소문자/숫자/언더스코어 */
    private static final Pattern CONTENT_KEY_PATTERN = Pattern.compile("^[a-z0-9_]{1,50}$");

    /** 게시판 ID: 영문/숫자/언더스코어 (eGov BBS_ID 형식) */
    private static final Pattern BOARD_ID_PATTERN = Pattern.compile("^[A-Za-z0-9_]{1,50}$");

    @Resource(name = "userMenuDAO")
    private UserMenuDAO userMenuDAO;

    @Resource(name = "pageContentService")
    private PageContentService pageContentService;

    /** CONTENT 메뉴에 자동 부여되는 콘텐츠 키 (page key를 외부에 노출하지 않음) */
    private static String contentKeyFor(long menuId) {
        return "menu_" + menuId;
    }

    @Override
    public List<UserMenu> selectMenuList() {
        return userMenuDAO.selectMenuList();
    }

    @Override
    public UserMenu selectMenu(long menuId) {
        return userMenuDAO.selectMenu(menuId);
    }

    @Override
    @Transactional
    public long insertMenu(UserMenu menu) {
        normalize(menu);
        // CONTENT 메뉴의 연결 키는 클라이언트 입력을 무시하고 서버가 자동 부여한다.
        if (UserMenu.TYPE_CONTENT.equals(menu.getMenuType())) {
            menu.setLinkedKey(null);
        }
        validate(menu, null);
        userMenuDAO.insertMenu(menu);
        if (UserMenu.TYPE_CONTENT.equals(menu.getMenuType())) {
            menu.setLinkedKey(contentKeyFor(menu.getMenuId()));
            userMenuDAO.updateMenu(menu);
        }
        return menu.getMenuId();
    }

    @Override
    @Transactional
    public void updateMenu(UserMenu menu) {
        if (menu.getMenuId() == null) {
            throw new IllegalArgumentException("수정할 메뉴 ID가 없습니다.");
        }
        UserMenu existing = userMenuDAO.selectMenu(menu.getMenuId());
        if (existing == null) {
            throw new IllegalArgumentException("존재하지 않는 메뉴입니다.");
        }
        normalize(menu);
        // CONTENT 메뉴는 연결 키를 서버가 고정 부여(menu_{id})한다.
        if (UserMenu.TYPE_CONTENT.equals(menu.getMenuType())) {
            menu.setLinkedKey(contentKeyFor(menu.getMenuId()));
        }
        validate(menu, menu.getMenuId());
        userMenuDAO.updateMenu(menu);

        // CONTENT → 다른 유형으로 전환되면 소유 콘텐츠를 정리한다.
        if (UserMenu.TYPE_CONTENT.equals(existing.getMenuType())
                && !UserMenu.TYPE_CONTENT.equals(menu.getMenuType())
                && existing.getLinkedKey() != null) {
            pageContentService.deletePageContent(existing.getLinkedKey());
        }
    }

    @Override
    @Transactional
    public void deleteMenu(long menuId) {
        if (userMenuDAO.countChildren(menuId) > 0) {
            throw new IllegalStateException("하위 메뉴가 있어 삭제할 수 없습니다. 하위 메뉴를 먼저 정리하세요.");
        }
        UserMenu menu = userMenuDAO.selectMenu(menuId);
        userMenuDAO.deleteMenu(menuId);
        // CONTENT 메뉴는 소유 콘텐츠도 함께 삭제한다.
        if (menu != null && UserMenu.TYPE_CONTENT.equals(menu.getMenuType()) && menu.getLinkedKey() != null) {
            pageContentService.deletePageContent(menu.getLinkedKey());
        }
    }

    @Override
    public List<UserMenu> selectMenuTree(boolean visibleOnly) {
        List<UserMenu> rows = visibleOnly
                ? userMenuDAO.selectVisibleMenuList()
                : userMenuDAO.selectMenuList();
        return buildTree(rows);
    }

    @Override
    public Optional<UserMenu> findVisibleByUrlPath(String urlPath) {
        if (urlPath == null || !URL_PATH_PATTERN.matcher(urlPath).matches()) {
            return Optional.empty();
        }
        return Optional.ofNullable(userMenuDAO.selectVisibleByUrlPath(urlPath));
    }

    @Override
    public Optional<UserMenu> findVisibleBoardByBbsId(String bbsId) {
        if (bbsId == null || !BOARD_ID_PATTERN.matcher(bbsId).matches()) {
            return Optional.empty();
        }
        return userMenuDAO.selectVisibleMenuList().stream()
                .filter(menu -> UserMenu.TYPE_BOARD.equals(menu.getMenuType()))
                .filter(menu -> bbsId.equals(menu.getLinkedKey()))
                .findFirst();
    }

    /* ===================== 내부 검증/정규화 ===================== */

    private void normalize(UserMenu menu) {
        menu.setMenuNm(trimToNull(menu.getMenuNm()));
        menu.setMenuType(trimToNull(menu.getMenuType()));
        menu.setUrlPath(trimToNull(menu.getUrlPath()));
        menu.setLinkedKey(trimToNull(menu.getLinkedKey()));
        if (menu.getUpperId() == null) {
            menu.setUpperId(0L);
        }
        menu.setUseAt("N".equals(menu.getUseAt()) ? "N" : "Y");

        // 폴더는 URL/연결을 가지지 않는다.
        if (UserMenu.TYPE_FOLDER.equals(menu.getMenuType())) {
            menu.setUrlPath(null);
            menu.setLinkedKey(null);
        }
    }

    private void validate(UserMenu menu, Long selfId) {
        if (menu.getMenuNm() == null || menu.getMenuNm().length() > 50) {
            throw new IllegalArgumentException("메뉴 이름은 1~50자여야 합니다.");
        }
        if (!VALID_TYPES.contains(menu.getMenuType())) {
            throw new IllegalArgumentException("허용되지 않은 메뉴 유형입니다.");
        }

        // 자기 자신을 상위로 지정 금지
        if (selfId != null && selfId.equals(menu.getUpperId())) {
            throw new IllegalArgumentException("자기 자신을 상위 메뉴로 지정할 수 없습니다.");
        }
        // 순환 참조 방지
        if (selfId != null) {
            assertNoCycle(selfId, menu.getUpperId());
        }

        if (!UserMenu.TYPE_FOLDER.equals(menu.getMenuType())) {
            validateUrlPath(menu, selfId);
            validateLinkedKey(menu);
        }
    }

    private void validateUrlPath(UserMenu menu, Long selfId) {
        String urlPath = menu.getUrlPath();
        if (urlPath == null) {
            throw new IllegalArgumentException("콘텐츠/게시판 메뉴는 URL 경로가 필요합니다.");
        }
        if (!URL_PATH_PATTERN.matcher(urlPath).matches()) {
            throw new IllegalArgumentException("URL 경로는 영소문자·숫자·하이픈만 사용할 수 있습니다.");
        }
        UserMenu probe = new UserMenu();
        probe.setUrlPath(urlPath);
        probe.setMenuId(selfId); // 수정 시 자기 자신 제외
        if (userMenuDAO.countByUrlPath(probe) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 URL 경로입니다: " + urlPath);
        }
    }

    private void validateLinkedKey(UserMenu menu) {
        String linkedKey = menu.getLinkedKey();
        if (linkedKey == null) {
            // 메뉴 먼저 생성 후 연결 허용: 연결 전이면 통과
            return;
        }
        if (UserMenu.TYPE_CONTENT.equals(menu.getMenuType())) {
            if (!CONTENT_KEY_PATTERN.matcher(linkedKey).matches()) {
                throw new IllegalArgumentException("콘텐츠 키 형식이 올바르지 않습니다.");
            }
        } else if (UserMenu.TYPE_BOARD.equals(menu.getMenuType())) {
            if (!BOARD_ID_PATTERN.matcher(linkedKey).matches()) {
                throw new IllegalArgumentException("게시판 ID 형식이 올바르지 않습니다.");
            }
        }
    }

    private void assertNoCycle(long selfId, Long upperId) {
        long guard = 0;
        Long cursor = upperId;
        while (cursor != null && cursor != 0L) {
            if (cursor == selfId) {
                throw new IllegalArgumentException("상위 메뉴 설정이 순환됩니다.");
            }
            if (++guard > 100) {
                throw new IllegalStateException("메뉴 계층 구조가 비정상적입니다.");
            }
            UserMenu parent = userMenuDAO.selectMenu(cursor);
            cursor = parent == null ? null : parent.getUpperId();
        }
    }

    private List<UserMenu> buildTree(List<UserMenu> rows) {
        Map<Long, UserMenu> byId = new LinkedHashMap<>();
        for (UserMenu menu : rows) {
            byId.put(menu.getMenuId(), menu);
        }
        List<UserMenu> roots = new ArrayList<>();
        for (UserMenu menu : rows) {
            Long upperId = menu.getUpperId();
            UserMenu parent = (upperId == null || upperId == 0L) ? null : byId.get(upperId);
            if (parent != null) {
                parent.addChild(menu);
            } else {
                roots.add(menu);
            }
        }
        roots.sort((a, b) -> {
            int cmp = Integer.compare(a.getSortOrdr(), b.getSortOrdr());
            return cmp != 0 ? cmp : Long.compare(a.getMenuId(), b.getMenuId());
        });
        roots.forEach(UserMenu::sortChildren);
        return roots;
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
