package sghcms.user.service;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class UserPasswordChangeVO {

    @NotBlank(message = "현재 비밀번호를 입력해 주세요.")
    private String currentPassword;

    @NotBlank(message = "새 비밀번호를 입력해 주세요.")
    @Size(min = 8, max = 20, message = "새 비밀번호는 8~20자로 입력해 주세요.")
    private String newPassword;

    @NotBlank(message = "새 비밀번호 확인을 입력해 주세요.")
    private String newPassword2;

    public String getCurrentPassword()         { return currentPassword; }
    public void   setCurrentPassword(String v) { this.currentPassword = v; }

    public String getNewPassword()             { return newPassword; }
    public void   setNewPassword(String v)     { this.newPassword = v; }

    public String getNewPassword2()            { return newPassword2; }
    public void   setNewPassword2(String v)    { this.newPassword2 = v; }
}
