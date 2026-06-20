package sghcms.content.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import sghcms.content.service.PageContentVO;

@Repository("pageContentDAO")
public class PageContentDAO extends EgovComAbstractDAO {

    public PageContentVO selectPageContent(String pageKey) {
        return selectOne("PageContent.selectContent", pageKey);
    }

    public List<PageContentVO> selectAllPageContents() {
        return selectList("PageContent.selectAllContents", null);
    }

    public void savePageContent(PageContentVO vo) {
        insert("PageContent.saveContent", vo);
    }
}
