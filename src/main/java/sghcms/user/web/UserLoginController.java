package sghcms.user.web;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.utl.sim.service.EgovClntInfo;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UserLoginController {

    @Resource(name = "loginService")
    private EgovLoginService loginService;

    @GetMapping("/user/login.do")
    public String loginView(
            @RequestParam(name = "error", required = false) String error,
            ModelMap model) {

        if ("true".equals(error)) {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return "sghcms/user/login";
    }

    @PostMapping("/user/loginAction.do")
    public String loginAction(
            @RequestParam(name = "id", defaultValue = "") String id,
            @RequestParam(name = "password", defaultValue = "") String password,
            HttpServletRequest request,
            RedirectAttributes ra) {

        if (id.isBlank() || password.isBlank()) {
            ra.addFlashAttribute("loginError", "아이디와 비밀번호를 모두 입력해 주세요.");
            return "redirect:/user/login.do";
        }

        try {
            LoginVO param = new LoginVO();
            param.setId(id.trim());
            param.setPassword(password);
            param.setUserSe("GNR");

            LoginVO result = loginService.actionLogin(param);

            if (result != null && result.getId() != null && !result.getId().isEmpty()) {
                result.setIp(EgovClntInfo.getClntIP(request));
                request.getSession().setAttribute("loginVO", result);
                request.getSession().setAttribute("accessUser", "GNR" + result.getId());
                return "redirect:/user/main.do";
            } else {
                ra.addFlashAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "redirect:/user/login.do";
            }
        } catch (Exception e) {
            ra.addFlashAttribute("loginError", "로그인 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            return "redirect:/user/login.do";
        }
    }

    @GetMapping("/user/logout.do")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().setAttribute("loginVO", null);
        request.getSession().setAttribute("accessUser", null);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/user/login.do";
    }
}
