package sghcms.user.service;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class UserJoinVO {

    @NotBlank(message = "아이디를 입력해 주세요.")
    @Size(min = 4, max = 20, message = "아이디는 4~20자로 입력해 주세요.")
    @Pattern(regexp = "^[a-zA-Z0-9_]+$", message = "아이디는 영문, 숫자, 밑줄(_)만 사용 가능합니다.")
    private String mberId;

    @NotBlank(message = "이름을 입력해 주세요.")
    @Size(max = 50, message = "이름은 50자 이내로 입력해 주세요.")
    private String mberNm;

    @NotBlank(message = "비밀번호를 입력해 주세요.")
    @Size(min = 8, max = 20, message = "비밀번호는 8~20자로 입력해 주세요.")
    private String password;

    @NotBlank(message = "비밀번호 확인을 입력해 주세요.")
    private String password2;

    @NotBlank(message = "이메일을 입력해 주세요.")
    @Email(message = "올바른 이메일 형식으로 입력해 주세요.")
    @Size(max = 50, message = "이메일은 50자 이내로 입력해 주세요.")
    private String mberEmailAdres;

    @NotBlank(message = "휴대폰 번호를 입력해 주세요.")
    @Size(max = 15, message = "휴대폰 번호는 15자 이내로 입력해 주세요.")
    private String moblphonNo;

    public String getMberId()            { return mberId; }
    public void   setMberId(String v)    { this.mberId = v; }

    public String getMberNm()            { return mberNm; }
    public void   setMberNm(String v)    { this.mberNm = v; }

    public String getPassword()          { return password; }
    public void   setPassword(String v)  { this.password = v; }

    public String getPassword2()         { return password2; }
    public void   setPassword2(String v) { this.password2 = v; }

    public String getMberEmailAdres()          { return mberEmailAdres; }
    public void   setMberEmailAdres(String v)  { this.mberEmailAdres = v; }

    public String getMoblphonNo()         { return moblphonNo; }
    public void   setMoblphonNo(String v) { this.moblphonNo = v; }
}
