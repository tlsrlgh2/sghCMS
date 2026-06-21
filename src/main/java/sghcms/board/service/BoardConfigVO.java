package sghcms.board.service;

/**
 * 게시판 사용자 설정 VO.
 * COMTNBBSMASTER 확장 컬럼(USER_WRITE_AT, OWN_POST_ONLY_AT)을 담는다.
 */
public class BoardConfigVO {

    /** 게시판 아이디 */
    private String bbsId = "";

    /** 게시판 명 (목록 표시용) */
    private String bbsNm = "";

    /** 사용자 작성 허용 여부 (Y/N) */
    private String userWriteAt = "N";

    /** 본인 글만 수정·상세 접근 허용 여부 (Y/N) */
    private String ownPostOnlyAt = "N";

    public String getBbsId() { return bbsId; }
    public void setBbsId(String bbsId) { this.bbsId = bbsId; }

    public String getBbsNm() { return bbsNm; }
    public void setBbsNm(String bbsNm) { this.bbsNm = bbsNm; }

    public String getUserWriteAt() { return userWriteAt; }
    public void setUserWriteAt(String userWriteAt) { this.userWriteAt = userWriteAt; }

    public String getOwnPostOnlyAt() { return ownPostOnlyAt; }
    public void setOwnPostOnlyAt(String ownPostOnlyAt) { this.ownPostOnlyAt = ownPostOnlyAt; }
}
