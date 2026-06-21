package sghcms.user.web;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import sghcms.user.service.UserJoinVO;
import sghcms.user.service.impl.UserJoinDAO;

@Controller
@RequestMapping("/user")
public class UserJoinController {

    @Resource(name = "mberManageService")
    private EgovMberManageService mberManageService;

    @Resource(name = "userJoinDAO")
    private UserJoinDAO userJoinDAO;

    @GetMapping("/join.do")
    public String joinView(ModelMap model) {
        model.addAttribute("joinVO", new UserJoinVO());
        return "sghcms/user/join";
    }

    @PostMapping("/joinAction.do")
    public String join(@Valid @ModelAttribute("joinVO") UserJoinVO joinVO,
                       BindingResult bindingResult,
                       RedirectAttributes ra,
                       ModelMap model) throws Exception {

        // 비밀번호 일치 확인
        if (!bindingResult.hasFieldErrors("password") && !bindingResult.hasFieldErrors("password2")) {
            if (!joinVO.getPassword().equals(joinVO.getPassword2())) {
                bindingResult.rejectValue("password2", "mismatch", "비밀번호가 일치하지 않습니다.");
            }
        }

        // 아이디 중복 확인
        if (!bindingResult.hasFieldErrors("mberId") && userJoinDAO.existsMberId(joinVO.getMberId())) {
            bindingResult.rejectValue("mberId", "duplicate", "이미 사용 중인 아이디입니다.");
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("idAlreadyChecked", !bindingResult.hasFieldErrors("mberId"));
            return "sghcms/user/join";
        }

        MberManageVO mberVO = toMberVO(joinVO);
        mberManageService.insertMber(mberVO);

        ra.addFlashAttribute("joinSuccess", true);
        return "redirect:/user/login.do";
    }

    @GetMapping("/checkId.do")
    @ResponseBody
    public ResponseEntity<Boolean> checkId(@RequestParam String mberId) {
        boolean exists = userJoinDAO.existsMberId(mberId);
        return ResponseEntity.ok(exists);
    }

    private MberManageVO toMberVO(UserJoinVO src) {
        MberManageVO vo = new MberManageVO();
        vo.setMberId(src.getMberId());
        vo.setMberNm(src.getMberNm());
        vo.setPassword(src.getPassword());
        vo.setMberEmailAdres(src.getMberEmailAdres());
        vo.setMoblphonNo(src.getMoblphonNo());
        vo.setMberSttus("P");   // 승인(활성) 상태로 즉시 가입
        vo.setGroupId(null);
        // DB NOT NULL 필드에 빈값 설정
        vo.setAdres("");
        vo.setZip("");
        vo.setAreaNo("0");
        vo.setMiddleTelno("0");
        vo.setEndTelno("0");
        vo.setPasswordHint("");
        vo.setPasswordCnsr("");
        return vo;
    }
}
