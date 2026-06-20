package sghcms.menu.service;

import java.util.List;
import java.util.Optional;

/**
 * 사용자 페이지 메뉴 관리 서비스.
 */
public interface UserMenuService {

    /** 관리자용 전체 메뉴 목록(정렬됨) */
    List<UserMenu> selectMenuList();

    /** 단건 조회 */
    UserMenu selectMenu(long menuId);

    /** 메뉴 등록. 검증 통과 시 생성된 menuId를 반환 */
    long insertMenu(UserMenu menu);

    /** 메뉴 수정 */
    void updateMenu(UserMenu menu);

    /** 메뉴 삭제(자식이 있으면 예외) */
    void deleteMenu(long menuId);

    /**
     * 사용자 GNB용 메뉴 트리.
     * @param visibleOnly true면 USE_AT='Y'만 포함
     */
    List<UserMenu> selectMenuTree(boolean visibleOnly);

    /** 노출 중인 메뉴를 URL 경로로 조회(라우팅용) */
    Optional<UserMenu> findVisibleByUrlPath(String urlPath);

    /**
     * 노출 중인 BOARD 메뉴를 연결된 게시판ID로 조회(사용자 게시판 공개 검증용).
     * 메뉴에 연결되어 노출 중인 게시판만 사용자 페이지에 공개한다.
     */
    Optional<UserMenu> findVisibleBoardByBbsId(String bbsId);
}
