package sghcms.content.service.impl;

import java.util.List;

import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;

@Service("pageContentService")
public class PageContentServiceImpl implements PageContentService {

    private static final PolicyFactory CONTENT_POLICY = Sanitizers.FORMATTING
            .and(Sanitizers.LINKS)
            .and(Sanitizers.IMAGES)
            .and(Sanitizers.TABLES)
            .and(Sanitizers.BLOCKS)
            .and(Sanitizers.STYLES);

    @Resource(name = "pageContentDAO")
    private PageContentDAO pageContentDAO;

    @Override
    public PageContentVO selectPageContent(String pageKey) {
        return pageContentDAO.selectPageContent(pageKey);
    }

    @Override
    public List<PageContentVO> selectAllPageContents() {
        return pageContentDAO.selectAllPageContents();
    }

    @Override
    public void savePageContent(PageContentVO vo) {
        vo.setContentHtml(CONTENT_POLICY.sanitize(vo.getContentHtml()));
        pageContentDAO.savePageContent(vo);
    }
}
