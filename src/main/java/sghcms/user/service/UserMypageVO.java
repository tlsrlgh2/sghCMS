package sghcms.user.service;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class UserMypageVO {

    private String mberId;

    @NotBlank(message = "이름을 입력해 주세요.")
    @Size(max = 50, message = "이름은 50자 이내로 입력해 주세요.")
    private String mberNm;

    @NotBlank(message = "이메일을 입력해 주세요.")
    @Email(message = "올바른 이메일 형식으로 입력해 주세요.")
    @Size(max = 50, message = "이메일은 50자 이내로 입력해 주세요.")
    private String mberEmailAdres;

    @Size(max = 15, message = "휴대폰 번호는 15자 이내로 입력해 주세요.")
    private String moblphonNo;

    public String getMberId()              { return mberId; }
    public void   setMberId(String v)      { this.mberId = v; }

    public String getMberNm()              { return mberNm; }
    public void   setMberNm(String v)      { this.mberNm = v; }

    public String getMberEmailAdres()      { return mberEmailAdres; }
    public void   setMberEmailAdres(String v) { this.mberEmailAdres = v; }

    public String getMoblphonNo()          { return moblphonNo; }
    public void   setMoblphonNo(String v)  { this.moblphonNo = v; }
}
