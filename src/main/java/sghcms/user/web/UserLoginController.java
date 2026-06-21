package sghcms.user.web;

import org.egovframe.rte.fdl.security.userdetails.EgovUserDetails;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.context.SecurityContextRepository;
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
import sghcms.user.service.impl.UserJoinDAO;

@Controller
public class UserLoginController {

    @Resource(name = "loginService")
    private EgovLoginService loginService;

    @Resource(name = "authenticationManager")
    private AuthenticationManager authenticationManager;

    @Resource(name = "securityContextRepository")
    private SecurityContextRepository securityContextRepository;

    @Resource(name = "userJoinDAO")
    private UserJoinDAO userJoinDAO;

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
            HttpServletResponse response,
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
                // 기존 가입 회원도 Security 권한 데이터가 누락되어 있으면 복구한다.
                userJoinDAO.insertDefaultUserAuthority(result.getId());

                Authentication authentication = authenticationManager.authenticate(
                        UsernamePasswordAuthenticationToken.unauthenticated(
                                result.getUserSe() + result.getId(), result.getUniqId()));

                // 세션 고정 공격 방지: 로그인 성공 시 세션 ID 교체
                if (request.getSession(false) != null) {
                    request.changeSessionId();
                }

                SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
                securityContext.setAuthentication(authentication);
                SecurityContextHolder.setContext(securityContext);
                securityContextRepository.saveContext(securityContext, request, response);

                LoginVO authenticatedUser = result;
                if (authentication.getPrincipal() instanceof EgovUserDetails userDetails
                        && userDetails.getEgovUserVO() instanceof LoginVO loginVO) {
                    authenticatedUser = loginVO;
                }
                authenticatedUser.setIp(EgovClntInfo.getClntIP(request));
                request.getSession().setAttribute("loginVO", authenticatedUser);
                request.getSession().setAttribute(
                        "accessUser", authenticatedUser.getUserSe() + authenticatedUser.getId());

                return "redirect:/user/main.do";
            } else {
                ra.addFlashAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "redirect:/user/login.do";
            }
        } catch (AuthenticationException e) {
            SecurityContextHolder.clearContext();
            ra.addFlashAttribute("loginError", "사용자 권한이 등록되지 않았거나 로그인이 허용되지 않은 계정입니다.");
            return "redirect:/user/login.do";
        } catch (Exception e) {
            SecurityContextHolder.clearContext();
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
