package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.article.ArticleManagerImpl;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.utils.Encodes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 文章更新控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-3-25
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/article/")
public class ArticleDetailController {

    private ArticleManagerImpl articleManagerImpl;
    private CategoryManager categoryManager;

    /**
     * 编辑文章
     *
     * @param article
     * @param model
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = {"edit/{id}"})
    public String editArticle(@Valid @ModelAttribute("article") Article article, Model model, RedirectAttributes redirectAttributes) {
        // 编辑不存在的文章，给出提示
        if (null == article) {
            redirectAttributes.addFlashAttribute("error", "文章不存在.");
            return "redirect:/article/listAll";
        }

        // 反解析，否则编辑器会显示HTML代码
        article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        // 获取所有分类
        model.addAttribute("categories", categoryManager.getAllowPublishCategory());
        return "dashboard/article/edit";
    }

    /**
     * 保存文章
     *
     * @param article
     * @return
     */
    @RequiresPermissions("article:save")
    @RequestMapping(value = "save/{id}")
    public String saveArticle(@Valid @ModelAttribute("article") Article article, BindingResult bindingResult, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (null == article) {
            redirectAttributes.addFlashAttribute("error", "该文章不存在，请刷新重试.");
            return "redirect:/article/listAll";
        }

        //是否置顶
        if (null == request.getParameter("top")) {
            article.setTop(false);
        } else {
            article.setTop(true);
        }

        //是否允许评论
        if (null == request.getParameter("allowComment")) {
            article.setAllowComment(false);
        } else {
            article.setAllowComment(true);
        }

        if (bindingResult.hasErrors() || articleManagerImpl.update(article) <= 0) {
            redirectAttributes.addFlashAttribute("error", "保存文章失败.");
            return "redirect:/article/listAll";
        } else {
            redirectAttributes.addFlashAttribute("info", "保存文章成功.");
            return "redirect:/article/listAll";
        }
    }

    @ModelAttribute("article")
    public Article getArticle(@PathVariable("id") Long id) {
        return articleManagerImpl.get(id);
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManagerImpl articleManagerImpl) {
        this.articleManagerImpl = articleManagerImpl;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

}