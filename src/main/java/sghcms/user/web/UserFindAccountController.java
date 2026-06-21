package sghcms.user.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.ems.service.EgovSndngMailRegistService;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import jakarta.annotation.Resource;
import sghcms.user.service.impl.UserJoinDAO;

@Controller
@RequestMapping("/user")
public class UserFindAccountController {

    @Resource(name = "loginService")
    private EgovLoginService loginService;

    @Resource(name = "userJoinDAO")
    private UserJoinDAO userJoinDAO;

    @Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;

    @GetMapping("/findAccount.do")
    public String findAccountView() {
        return "sghcms/user/find-account";
    }

    @PostMapping("/findId.do")
    public String findId(@RequestParam String mberNm,
                         @RequestParam String mberEmailAdres,
                         ModelMap model) throws Exception {

        LoginVO param = new LoginVO();
        param.setName(mberNm.replaceAll(" ", ""));
        param.setEmail(mberEmailAdres);
        param.setUserSe("GNR");

        LoginVO result = loginService.searchId(param);

        if (result != null && result.getId() != null && !result.getId().isEmpty()) {
            model.addAttribute("foundId", result.getId());
        } else {
            model.addAttribute("errorMsg", "일치하는 회원 정보를 찾을 수 없습니다.");
        }
        model.addAttribute("mode", "id");
        return "sghcms/user/find-account";
    }

    @PostMapping("/findPw.do")
    public String findPw(@RequestParam String mberId,
                         @RequestParam String mberNm,
                         @RequestParam String mberEmailAdres,
                         ModelMap model) throws Exception {

        String foundEmail = userJoinDAO.findEmailByMberInfo(
                mberId.trim(), mberNm.replaceAll(" ", ""), mberEmailAdres.trim());

        if (foundEmail == null || foundEmail.isEmpty()) {
            model.addAttribute("errorMsg", "일치하는 회원 정보를 찾을 수 없습니다.");
            model.addAttribute("mode", "pw");
            return "sghcms/user/find-account";
        }

        // 임시 비밀번호 생성 (영+영+숫+영+영+숫+영+영 = 8자리)
        StringBuilder newPw = new StringBuilder();
        for (int i = 1; i <= 8; i++) {
            if (i % 3 != 0) {
                newPw.append(EgovStringUtil.getRandomStr('a', 'z'));
            } else {
                newPw.append(EgovNumberUtil.getRandomNum(0, 9));
            }
        }
        String newPwStr = newPw.toString();

        // 암호화 후 DB 업데이트
        String encPw = EgovFileScrty.encryptPassword(newPwStr, mberId.trim());
        userJoinDAO.updateMberPassword(mberId.trim(), encPw);

        // 이메일 발송 (메일 서버 미설정 시 예외 무시)
        try {
            SndngMailVO mail = new SndngMailVO();
            mail.setDsptchPerson("webmaster");
            mail.setRecptnPerson(foundEmail);
            mail.setSj("[SGH청년공간] 임시 비밀번호를 발송했습니다.");
            mail.setEmailCn("고객님의 임시 비밀번호는 " + newPwStr + " 입니다.\n로그인 후 반드시 비밀번호를 변경해 주세요.");
            mail.setAtchFileId("");
            sndngMailRegistService.insertSndngMail(mail);
        } catch (Exception ignored) {
        }

        model.addAttribute("pwSuccess", true);
        model.addAttribute("mode", "pw");
        return "sghcms/user/find-account";
    }
}
