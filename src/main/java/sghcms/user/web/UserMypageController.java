package sghcms.user.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.LoginVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import sghcms.user.service.UserMypageService;
import sghcms.user.service.UserMypageVO;
import sghcms.user.service.UserPasswordChangeVO;

@Controller
@RequestMapping("/user")
public class UserMypageController {

    @Resource(name = "userMypageService")
    private UserMypageService userMypageService;

    @GetMapping("/mypage.do")
    public String mypageView(HttpSession session, ModelMap model) {
        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        if (loginVO == null) {
            return "redirect:/user/login.do";
        }
        model.addAttribute("mberInfo", userMypageService.getMberInfo(loginVO.getId()));
        model.addAttribute("passwordChangeVO", new UserPasswordChangeVO());
        return "sghcms/user/mypage";
    }

    @PostMapping("/mypageBasicUpdate.do")
    public String updateBasicInfo(
            @Valid @ModelAttribute("mberInfo") UserMypageVO vo,
            BindingResult bindingResult,
            HttpSession session,
            RedirectAttributes ra,
            ModelMap model) {

        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        if (loginVO == null) {
            return "redirect:/user/login.do";
        }
        vo.setMberId(loginVO.getId());

        if (bindingResult.hasErrors()) {
            model.addAttribute("passwordChangeVO", new UserPasswordChangeVO());
            model.addAttribute("activeTab", "basic");
            return "sghcms/user/mypage";
        }

        userMypageService.updateMberInfo(vo);

        loginVO.setName(vo.getMberNm());
        loginVO.setEmail(vo.getMberEmailAdres());
        session.setAttribute("loginVO", loginVO);

        ra.addFlashAttribute("basicSuccess", "기본 정보가 수정되었습니다.");
        return "redirect:/user/mypage.do";
    }

    @PostMapping("/mypagePasswordUpdate.do")
    public String updatePassword(
            @Valid @ModelAttribute("passwordChangeVO") UserPasswordChangeVO vo,
            BindingResult bindingResult,
            HttpSession session,
            RedirectAttributes ra,
            ModelMap model) throws Exception {

        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        if (loginVO == null) {
            return "redirect:/user/login.do";
        }

        if (!bindingResult.hasFieldErrors("newPassword") && !bindingResult.hasFieldErrors("newPassword2")) {
            if (!vo.getNewPassword().equals(vo.getNewPassword2())) {
                bindingResult.rejectValue("newPassword2", "mismatch", "새 비밀번호가 일치하지 않습니다.");
            }
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("mberInfo", userMypageService.getMberInfo(loginVO.getId()));
            model.addAttribute("activeTab", "password");
            return "sghcms/user/mypage";
        }

        boolean changed = userMypageService.changePassword(loginVO.getId(), vo.getCurrentPassword(), vo.getNewPassword());
        if (!changed) {
            model.addAttribute("mberInfo", userMypageService.getMberInfo(loginVO.getId()));
            model.addAttribute("passwordChangeVO", vo);
            model.addAttribute("currentPwError", "현재 비밀번호가 올바르지 않습니다.");
            model.addAttribute("activeTab", "password");
            return "sghcms/user/mypage";
        }

        ra.addFlashAttribute("passwordSuccess", "비밀번호가 변경되었습니다.");
        return "redirect:/user/mypage.do";
    }
}
