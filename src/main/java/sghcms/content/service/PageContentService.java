package sghcms.content.service;

import java.util.List;

public interface PageContentService {
    PageContentVO selectPageContent(String pageKey);
    List<PageContentVO> selectAllPageContents();
    void savePageContent(PageContentVO vo);
    void deletePageContent(String pageKey);
}
