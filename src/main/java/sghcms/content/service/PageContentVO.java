package sghcms.content.service;

import java.util.Date;

public class PageContentVO {

    private String pageKey;
    private String pageTitle;
    private String contentHtml;
    private Date updde;
    private String updusr;

    public String getPageKey() { return pageKey; }
    public void setPageKey(String pageKey) { this.pageKey = pageKey; }

    public String getPageTitle() { return pageTitle; }
    public void setPageTitle(String pageTitle) { this.pageTitle = pageTitle; }

    public String getContentHtml() { return contentHtml; }
    public void setContentHtml(String contentHtml) { this.contentHtml = contentHtml; }

    public Date getUpdde() { return updde; }
    public void setUpdde(Date updde) { this.updde = updde; }

    public String getUpdusr() { return updusr; }
    public void setUpdusr(String updusr) { this.updusr = updusr; }
}
