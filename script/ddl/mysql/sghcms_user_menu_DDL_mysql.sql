-- 사용자 페이지 메뉴 관리 테이블
-- 관리자가 사용자(프론트) 메뉴를 직접 등록/관리하기 위한 전용 레지스트리.
-- MENU_TYPE 에 따라 연결 대상(LINKED_KEY)의 의미가 달라진다.
--   FOLDER  : 하위 메뉴를 묶는 그룹(드롭다운). URL_PATH/LINKED_KEY 불필요.
--   CONTENT : 페이지 콘텐츠 1건과 연결. LINKED_KEY = SGH_PAGE_CONTENT.PAGE_KEY
--   BOARD   : eGov 게시판 1건과 연결. LINKED_KEY = COMTNBBSMASTER.BBS_ID

CREATE TABLE IF NOT EXISTS SGH_USER_MENU (
    MENU_ID           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '사용자 메뉴 ID',
    MENU_NM           VARCHAR(50)  NOT NULL COMMENT '메뉴 이름',
    MENU_TYPE         VARCHAR(10)  NOT NULL COMMENT '메뉴 유형 (FOLDER/CONTENT/BOARD)',
    URL_PATH          VARCHAR(50)  NULL     COMMENT '사용자 접근 경로 슬러그 (영소문자/숫자/하이픈)',
    LINKED_KEY        VARCHAR(50)  NULL     COMMENT '연결 대상 (CONTENT=페이지키, BOARD=게시판ID)',
    UPPER_ID          BIGINT       NOT NULL DEFAULT 0 COMMENT '상위 메뉴 ID (0=최상위)',
    SORT_ORDR         INT          NOT NULL DEFAULT 0 COMMENT '정렬 순서',
    USE_AT            CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용(노출) 여부 (Y/N)',
    FRST_REGIST_PNTTM DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 등록일시',
    FRST_REGISTER_ID  VARCHAR(20)  NULL     COMMENT '최초 등록자 ID',
    LAST_UPDT_PNTTM   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                            ON UPDATE CURRENT_TIMESTAMP
                                            COMMENT '최종 수정일시',
    LAST_UPDUSR_ID    VARCHAR(20)  NULL     COMMENT '최종 수정자 ID',
    PRIMARY KEY (MENU_ID),
    -- URL_PATH 는 NULL 다중 허용(폴더/미연결). 값이 있으면 유일해야 함.
    UNIQUE KEY UK_SGH_USER_MENU_URL (URL_PATH)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자 페이지 메뉴 관리';
