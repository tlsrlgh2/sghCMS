package sghcms.user.web;

import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/user")
public class UserMainController {

    @Resource(name = "egovPopupManageService")
    private EgovPopupManageService popupManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @GetMapping("/main.do")
    public String main(ModelMap model) throws Exception {
        model.addAttribute("mainPopups", popupManageService.selectPopupMainList(new PopupManageVO()));
        return "sghcms/user/main";
    }

    @GetMapping("/popup/image.do")
    public void popupImage(@RequestParam("popupId") String popupId, HttpServletResponse response) throws Exception {
        PopupManageVO search = new PopupManageVO();
        search.setPopupId(popupId);
        PopupManageVO popup = popupManageService.selectPopup(search);
        if (popup == null || popup.getImageFileId() == null || popup.getImageFileId().isBlank()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        FileVO fileSearch = new FileVO();
        fileSearch.setAtchFileId(popup.getImageFileId());
        fileSearch.setFileSn("0");
        FileVO file = fileMngService.selectFileInf(fileSearch);
        if (file == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Path imagePath = resolveStorePath(file);
        if (imagePath == null || !Files.isRegularFile(imagePath)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        MediaType mediaType = MediaTypeFactory.getMediaType(file.getOrignlFileNm())
                .orElse(MediaType.APPLICATION_OCTET_STREAM);
        response.setContentType(mediaType.toString());
        response.setContentLengthLong(Files.size(imagePath));
        response.setHeader("Cache-Control", "public, max-age=3600");
        Files.copy(imagePath, response.getOutputStream());
    }

    /**
     * DB에 저장된 경로가 fileStorePath 내부인지 검증 후 Path를 반환한다.
     * 경로 이탈이 감지되면 null을 반환한다.
     */
    private Path resolveStorePath(FileVO file) {
        try {
            Path storePath = Path.of(Globals.fileStorePath).toAbsolutePath().normalize();
            Path imagePath = Path.of(file.getFileStreCours(), file.getStreFileNm())
                    .toAbsolutePath().normalize();
            if (!imagePath.startsWith(storePath)) {
                return null;
            }
            return imagePath;
        } catch (Exception e) {
            return null;
        }
    }
}
