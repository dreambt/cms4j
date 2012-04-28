package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 归类功能
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 上午11:43
 */
@Controller
@RequestMapping(value = "/archive")
public class ArchiveController {

    private ArchiveManager archiveManager;

    private CategoryManager categoryManager;

    private ArticleManager articleManager;

    private LinkManager linkManager;

    /**
     * 显示所有归类
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String articleListOfArchive(Model model) {
        model.addAttribute("archives", archiveManager.getAll());
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("newArticles", articleManager.findTopTen());
        return "article/archives";
    }

    /**
     * 显示编号为id的归类
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list/{id}")
    public String articleListByArchiveId(Model model, @PathVariable("id") Long id) {
        Long total = articleManager.count(id);
        int limit = 10;
        Long pageCount = 1L;
        if (total % limit == 0) {
            pageCount = total / limit;
        } else {
            pageCount = total / limit + 1;
        }
        model.addAttribute("articles", articleManager.findArticleByArchiveId(id, 0, 10));//文章列表
        model.addAttribute("categories", categoryManager.getNavCategory());//导航菜单
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTopTen());//边栏归档日志
        model.addAttribute("newArticles", articleManager.findTopTen());//边栏最新文章
        model.addAttribute("archive", archiveManager.getByArchiveId(id));
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("links", linkManager.getAllLink());//页脚友情链接

        return "article/list";
    }

    @Autowired
    public void setArchiveManager(@Qualifier("archiveManager") ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

    @Autowired
    public void setArticleManager(@Qualifier("articleManager") ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setLinkManager(LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}