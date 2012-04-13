package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * 文章更新控制器
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-25
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/article/")
public class ArticleDetailController {

    private ArticleManager articleManager;

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
        if(null == article){
            redirectAttributes.addFlashAttribute("error", "文章不存在");
            return "redirect:/article/listAll";
        }

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
    public String saveArticle(@Valid @ModelAttribute("article") Article article, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || articleManager.save(article) > 0) {
            redirectAttributes.addFlashAttribute("error", "保存文章失败");
            return "redirect:/article/edit/" + article.getId();
        } else {
            redirectAttributes.addFlashAttribute("message", "保存文章成功");
            return "redirect:/article/listAll";
        }
    }

    @ModelAttribute("article")
    public Article getArticle(@PathVariable("id") Long id) {
        return articleManager.findOne(id);
    }

    @Autowired
    public void setArticleManager(@Qualifier("articleManager") ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

}