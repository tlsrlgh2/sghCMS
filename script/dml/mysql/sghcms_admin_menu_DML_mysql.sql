-- SGHCMS 관리자 CMS 필수 메뉴
-- eGovFramework 기본 메뉴/프로그램/권한 테이블을 그대로 사용한다.
-- 재실행해도 동일한 메뉴 번호와 프로그램 키를 갱신하도록 작성했다.

START TRANSACTION;

INSERT INTO COMTNPROGRMLIST
    (PROGRM_FILE_NM, PROGRM_STRE_PATH, PROGRM_KOREAN_NM, PROGRM_DC, URL)
VALUES
    ('SelectBBSMasterInfs', '/cop/bbs/', '게시판 관리', '게시판 속성 관리', '/cop/bbs/selectBBSMasterInfs.do'),
    ('EgovMberManage', '/uss/umt/', '일반회원 관리', '일반회원 관리', '/uss/umt/EgovMberManage.do'),
    ('EgovEntrprsMberManage', '/uss/umt/', '기업회원 관리', '기업회원 관리', '/uss/umt/EgovEntrprsManage.do'),
    ('EgovUserManage', '/uss/umt/', '관리자 관리', '업무사용자 관리', '/uss/umt/EgovEmplyrManage.do'),
    ('selectBannerList', '/uss/ion/bnr/', '배너 관리', '배너 관리', '/uss/ion/bnr/selectBannerList.do'),
    ('listPopup', '/uss/ion/pwm/', '팝업 관리', '팝업창 관리', '/uss/ion/pwm/listPopup.do'),
    ('FaqListInqire', '/uss/olh/faq/', 'FAQ 관리', 'FAQ 관리', '/uss/olh/faq/selectFaqList.do'),
    ('QnaAnswerListInqire', '/uss/olh/qna/', 'Q&A 답변 관리', 'Q&A 답변 관리', '/uss/olh/qna/selectQnaAnswerList.do'),
    ('SiteListInqire', '/uss/ion/sit/', '관련 사이트 관리', '사이트 관리', '/uss/ion/sit/selectSiteList.do'),
    ('StplatListInqire', '/uss/sam/stp/', '약관 관리', '약관 관리', '/uss/sam/stp/StplatListInqire.do'),
    ('EgovMenuManageSelect', '/sym/mnu/mpm/', '메뉴 관리', '메뉴 정보 관리', '/sym/mnu/mpm/EgovMenuManageSelect.do'),
    ('EgovMenuCreatManageSelect', '/sym/mnu/mcm/', '권한별 메뉴 생성', '권한별 메뉴 생성 관리', '/sym/mnu/mcm/EgovMenuCreatManageSelect.do'),
    ('EgovProgramListManageSelect', '/sym/prm/', '프로그램 관리', '프로그램 URL 관리', '/sym/prm/EgovProgramListManageSelect.do'),
    ('EgovCcmCmmnClCodeList', '/sym/ccm/ccc/', '공통분류코드', '공통분류코드 관리', '/sym/ccm/ccc/SelectCcmCmmnClCodeList.do'),
    ('EgovCcmCmmnCodeList', '/sym/ccm/cca/', '공통코드', '공통코드 관리', '/sym/ccm/cca/SelectCcmCmmnCodeList.do'),
    ('EgovCcmCmmnDetailCodeList', '/sym/ccm/cde/', '공통상세코드', '공통상세코드 관리', '/sym/ccm/cde/SelectCcmCmmnDetailCodeList.do'),
    ('EgovAuthorList', '/sec/ram/', '권한 관리', '권한 관리', '/sec/ram/EgovAuthorList.do'),
    ('EgovAuthorGroupList', '/sec/rgm/', '사용자 권한그룹', '사용자 권한그룹 관리', '/sec/rgm/EgovAuthorGroupList.do'),
    ('selectLoginPolicyList', '/uat/uap/', '로그인 정책', '로그인 정책 관리', '/uat/uap/selectLoginPolicyList.do'),
    ('selectBbsStats', '/sts/bst/', '게시물 통계', '게시물 통계', '/sts/bst/selectBbsStats.do'),
    ('selectUserStats', '/sts/ust/', '사용자 통계', '사용자 통계', '/sts/ust/selectUserStats.do'),
    ('selectConectStats', '/sts/cst/', '접속 통계', '접속 통계', '/sts/cst/selectConectStats.do'),
    ('SelectSysLogList', '/sym/log/lgm/', '시스템 로그', '시스템 로그 관리', '/sym/log/lgm/SelectSysLogList.do'),
    ('SelectWebLogList', '/sym/log/wlg/', '웹 로그', '웹 로그 관리', '/sym/log/wlg/SelectWebLogList.do'),
    ('SelectLoginLogList', '/sym/log/clg/', '로그인 로그', '로그인 로그 관리', '/sym/log/clg/SelectLoginLogList.do')
ON DUPLICATE KEY UPDATE
    PROGRM_STRE_PATH = VALUES(PROGRM_STRE_PATH),
    PROGRM_KOREAN_NM = VALUES(PROGRM_KOREAN_NM),
    PROGRM_DC = VALUES(PROGRM_DC),
    URL = VALUES(URL);

INSERT INTO COMTNMENUINFO
    (MENU_NM, PROGRM_FILE_NM, MENU_NO, UPPER_MENU_NO, MENU_ORDR, MENU_DC, RELATE_IMAGE_PATH, RELATE_IMAGE_NM)
VALUES
    ('CMS 관리', 'dir', 90000000, 0, 90, 'SGHCMS 관리자 메뉴 루트', '/', '/'),

    ('콘텐츠/게시판', 'dir', 90100000, 90000000, 1, '콘텐츠와 게시판 관리', '/', '/'),
    ('게시판 관리', 'SelectBBSMasterInfs', 90101000, 90100000, 1, '게시판 생성 및 설정', '/', '/'),

    ('회원/관리자', 'dir', 90200000, 90000000, 2, '회원과 관리자 계정 관리', '/', '/'),
    ('일반회원 관리', 'EgovMberManage', 90201000, 90200000, 1, '일반회원 관리', '/', '/'),
    ('기업회원 관리', 'EgovEntrprsMberManage', 90202000, 90200000, 2, '기업회원 관리', '/', '/'),
    ('관리자 관리', 'EgovUserManage', 90203000, 90200000, 3, '업무사용자 및 관리자 관리', '/', '/'),

    ('사이트 운영', 'dir', 90300000, 90000000, 3, '사이트 노출 콘텐츠 관리', '/', '/'),
    ('배너 관리', 'selectBannerList', 90301000, 90300000, 1, '배너 관리', '/', '/'),
    ('팝업 관리', 'listPopup', 90302000, 90300000, 2, '팝업창 관리', '/', '/'),
    ('FAQ 관리', 'FaqListInqire', 90303000, 90300000, 3, 'FAQ 관리', '/', '/'),
    ('Q&A 답변 관리', 'QnaAnswerListInqire', 90304000, 90300000, 4, 'Q&A 답변 관리', '/', '/'),
    ('관련 사이트 관리', 'SiteListInqire', 90305000, 90300000, 5, '관련 사이트 관리', '/', '/'),
    ('약관 관리', 'StplatListInqire', 90306000, 90300000, 6, '약관 관리', '/', '/'),

    ('메뉴/시스템 설정', 'dir', 90400000, 90000000, 4, '메뉴, 프로그램, 공통코드 관리', '/', '/'),
    ('메뉴 관리', 'EgovMenuManageSelect', 90401000, 90400000, 1, '메뉴 정보 관리', '/', '/'),
    ('권한별 메뉴 생성', 'EgovMenuCreatManageSelect', 90402000, 90400000, 2, '권한별 메뉴 생성', '/', '/'),
    ('프로그램 관리', 'EgovProgramListManageSelect', 90403000, 90400000, 3, '프로그램 URL 관리', '/', '/'),
    ('공통분류코드', 'EgovCcmCmmnClCodeList', 90404000, 90400000, 4, '공통분류코드 관리', '/', '/'),
    ('공통코드', 'EgovCcmCmmnCodeList', 90405000, 90400000, 5, '공통코드 관리', '/', '/'),
    ('공통상세코드', 'EgovCcmCmmnDetailCodeList', 90406000, 90400000, 6, '공통상세코드 관리', '/', '/'),

    ('권한/보안', 'dir', 90500000, 90000000, 5, '권한과 로그인 정책 관리', '/', '/'),
    ('권한 관리', 'EgovAuthorList', 90501000, 90500000, 1, '권한 관리', '/', '/'),
    ('사용자 권한그룹', 'EgovAuthorGroupList', 90502000, 90500000, 2, '사용자 권한그룹 관리', '/', '/'),
    ('로그인 정책', 'selectLoginPolicyList', 90503000, 90500000, 3, '로그인 정책 관리', '/', '/'),

    ('통계/로그', 'dir', 90600000, 90000000, 6, '운영 통계와 로그 조회', '/', '/'),
    ('게시물 통계', 'selectBbsStats', 90601000, 90600000, 1, '게시물 통계', '/', '/'),
    ('사용자 통계', 'selectUserStats', 90602000, 90600000, 2, '사용자 통계', '/', '/'),
    ('접속 통계', 'selectConectStats', 90603000, 90600000, 3, '접속 통계', '/', '/'),
    ('시스템 로그', 'SelectSysLogList', 90604000, 90600000, 4, '시스템 로그', '/', '/'),
    ('웹 로그', 'SelectWebLogList', 90605000, 90600000, 5, '웹 로그', '/', '/'),
    ('로그인 로그', 'SelectLoginLogList', 90606000, 90600000, 6, '로그인 로그', '/', '/')
ON DUPLICATE KEY UPDATE
    MENU_NM = VALUES(MENU_NM),
    PROGRM_FILE_NM = VALUES(PROGRM_FILE_NM),
    UPPER_MENU_NO = VALUES(UPPER_MENU_NO),
    MENU_ORDR = VALUES(MENU_ORDR),
    MENU_DC = VALUES(MENU_DC);

-- 페이지 콘텐츠 관리 프로그램 등록
INSERT INTO COMTNPROGRMLIST
    (PROGRM_FILE_NM, PROGRM_STRE_PATH, PROGRM_KOREAN_NM, PROGRM_DC, URL)
VALUES
    ('SghPageContentEdit', '/admin/content/pageContent/', '페이지 콘텐츠 관리',
     '청년공간 정적 페이지 HTML 콘텐츠 편집', '/admin/content/pageContent/edit.do')
ON DUPLICATE KEY UPDATE
    PROGRM_STRE_PATH = VALUES(PROGRM_STRE_PATH),
    PROGRM_KOREAN_NM = VALUES(PROGRM_KOREAN_NM),
    PROGRM_DC        = VALUES(PROGRM_DC),
    URL              = VALUES(URL);

-- 페이지 콘텐츠 관리 메뉴 등록 (90100000 "콘텐츠/게시판" 하위)
INSERT INTO COMTNMENUINFO
    (MENU_NM, PROGRM_FILE_NM, MENU_NO, UPPER_MENU_NO, MENU_ORDR, MENU_DC, RELATE_IMAGE_PATH, RELATE_IMAGE_NM)
VALUES
    ('페이지 콘텐츠 관리', 'SghPageContentEdit', 90102000, 90100000, 2,
     '청년공간 정적 페이지 HTML 편집', '/', '/')
ON DUPLICATE KEY UPDATE
    MENU_NM        = VALUES(MENU_NM),
    PROGRM_FILE_NM = VALUES(PROGRM_FILE_NM),
    UPPER_MENU_NO  = VALUES(UPPER_MENU_NO),
    MENU_ORDR      = VALUES(MENU_ORDR),
    MENU_DC        = VALUES(MENU_DC);

INSERT INTO COMTNMENUCREATDTLS (MENU_NO, AUTHOR_CODE, MAPNG_CREAT_ID)
SELECT MENU_NO, 'ROLE_ADMIN', NULL
FROM COMTNMENUINFO
WHERE MENU_NO BETWEEN 90000000 AND 90699999
ON DUPLICATE KEY UPDATE AUTHOR_CODE = VALUES(AUTHOR_CODE);

COMMIT;
