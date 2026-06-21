-- 게시판 사용자 설정 확장 컬럼
-- USER_WRITE_AT    : 사용자 작성 허용 여부 (Y/N)
-- OWN_POST_ONLY_AT : 본인 글만 수정·상세 접근 허용 여부 (Y/N)
ALTER TABLE COMTNBBSMASTER
    ADD COLUMN USER_WRITE_AT    CHAR(1) NOT NULL DEFAULT 'N' COMMENT '사용자 작성 허용 여부',
    ADD COLUMN OWN_POST_ONLY_AT CHAR(1) NOT NULL DEFAULT 'N' COMMENT '본인 글만 접근 허용 여부';
