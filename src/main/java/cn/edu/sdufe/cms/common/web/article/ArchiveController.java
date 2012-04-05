package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 归类功能
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

    /**
     * 显示所有归类信息
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String articleListOfArchive(Model model) {
        model.addAttribute("archives", archiveManager.getAllArchive());
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("newArticles",articleManager.getTopTen());
        return "article/archives";
    }

    @RequestMapping(value = "list/{id}")
    public String articleListByArchiveId(Model model, @PathVariable("id") Long id) {
        model.addAttribute("archives", archiveManager.getAllArchive());
        model.addAttribute("archive", archiveManager.getArchiveByArchiveId(id));
        model.addAttribute("articles", archiveManager.getArchiveByArchiveId(id).getArticleList());
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("newArticles",articleManager.getTopTen());
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
}
