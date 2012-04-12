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
     * @param id
     * @param model
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = {"edit/{id}"})
    public String editArticle(@PathVariable("id") Long id, Model model) {
        // 不用报错，Neither BindingResult nor plain target object for bean name 'article' available as request attribute
        //model.addAttribute("article", articleManager.getArticle(id));
        if(null == articleManager.get(id)) {
            model.addAttribute("error", "该文章不存在，请刷新重试");
            return "dashboard/article/listAll";
        }
        // 获取所有分类
        model.addAttribute("categories", categoryManager.getAllowPublishCategory());
        return "dashboard/article/edit";
    }

    /**
     * 保存文章
     *
     * @param model
     * @return
     */
    @RequiresPermissions("article:save")
    @RequestMapping(value = "save/{id}")
    public String saveArticle(@PathVariable("id") Long id, @Valid @ModelAttribute("article") Article article, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        if(null == articleManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该文章不存在，请刷新重试");
            return "redirect:/article/listAll";
        }
        if (bindingResult.hasErrors() || null == articleManager.save(article)) {
            redirectAttributes.addFlashAttribute("error", "保存文章失败");
            return "redirect:/article/listAll";
        } else {
            redirectAttributes.addFlashAttribute("message", "保存文章成功");
            return "redirect:/article/listAll";
        }
    }

    /**
     * 置顶编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = "top/{id}")
    public String topArticle(@PathVariable("id") Long id, @ModelAttribute("article") Article article, RedirectAttributes redirectAttributes) {
        if(null == articleManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该文章不存在，请刷新重试");
            return "redirect:/article/listAll";
        }
        article.setTop(!article.isTop());

        if (article.isTop()) {
            if (null == articleManager.update(article)) {
                redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
            }
            redirectAttributes.addFlashAttribute("info", "置顶文章 " + id + " 成功.");
        } else {
            if (null == articleManager.update(article)) {
                redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
            }
            redirectAttributes.addFlashAttribute("info", "取消置顶文章 " + id + " 成功.");
        }
        return "redirect:/article/listAll";
    }

    /**
     * 修改编号为id的文章是否允许评论
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = "allow/{id}")
    public String allowArticle(@PathVariable("id") Long id, @ModelAttribute("article") Article article, RedirectAttributes redirectAttributes) {
        if(null == articleManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该文章不存在，请刷新重试");
            return "redirect:/article/listAll";
        }
        article.setAllowComment(!article.isAllowComment());
        if (null == articleManager.update(article)) {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
            return "redirect:/article/listAll";
        }

        if (article.isAllowComment()) {
            redirectAttributes.addFlashAttribute("info", "允许评论文章 " + id + " .");
        } else {
            redirectAttributes.addFlashAttribute("info", "不允许评论文章 " + id + " .");
        }
        return "redirect:/article/listAll";
    }

    /**
     * 审核编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = "audit/{id}")
    public String auditArticle(@PathVariable("id") Long id, @ModelAttribute("article") Article article, RedirectAttributes redirectAttributes) {
        if(null == articleManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该文章不存在，请刷新重试");
            return "redirect:/article/listAll";
        }
        article.setStatus(!article.isStatus());
        if (null == articleManager.update(article)) {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
            return "redirect:/article/listAll";
        }

        if (article.isStatus()) {
            redirectAttributes.addFlashAttribute("info", "审核文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "反审核文章 " + id + " 成功.");
        }
        return "redirect:/article/listAll";
    }

    /**
     * 删除编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:delete")
    @RequestMapping(value = "delete/{id}")
    public String deleteArticle(@PathVariable("id") Long id, @ModelAttribute("article") Article article, RedirectAttributes redirectAttributes) {
        if(null == articleManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该文章已经不存在，请刷新查看");
            return "redirect:/article/listAll";
        }
        article.setDeleted(!article.isDeleted());
        if (null == articleManager.update(article)) {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
            return "redirect:/article/listAll";
        }

        if (article.isDeleted()) {
            redirectAttributes.addFlashAttribute("info", "删除文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "恢复文章 " + id + " 成功.");
        }
        return "redirect:/article/listAll";
    }

    @ModelAttribute("article")
    public Article getArticle(@PathVariable("id") Long id) {
        return articleManager.get(id);
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