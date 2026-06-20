CREATE TABLE IF NOT EXISTS SGH_PAGE_CONTENT (
    PAGE_KEY     VARCHAR(30)  NOT NULL COMMENT '페이지 식별 키 (about_intro 등)',
    PAGE_TITLE   VARCHAR(100) NOT NULL COMMENT '관리자 표시용 제목',
    CONTENT_HTML MEDIUMTEXT   NOT NULL COMMENT 'CKEditor로 작성한 HTML 본문',
    UPDDE        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                       ON UPDATE CURRENT_TIMESTAMP
                                       COMMENT '최종 수정일시',
    UPDUSR       VARCHAR(20)  NULL     COMMENT '최종 수정자 ID',
    PRIMARY KEY (PAGE_KEY)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='정적 페이지 HTML 콘텐츠';
