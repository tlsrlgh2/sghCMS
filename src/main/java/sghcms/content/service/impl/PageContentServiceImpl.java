package sghcms.content.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import sghcms.content.service.PageContentService;
import sghcms.content.service.PageContentVO;

@Service("pageContentService")
public class PageContentServiceImpl implements PageContentService {

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
        pageContentDAO.savePageContent(vo);
    }
}
