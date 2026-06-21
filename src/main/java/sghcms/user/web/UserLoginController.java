package sghcms.user.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserLoginController {

    @GetMapping("/user/login.do")
    public String loginView(
            @RequestParam(name = "error", required = false) String error,
            ModelMap model) {

        if ("true".equals(error)) {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return "sghcms/user/login";
    }
}
