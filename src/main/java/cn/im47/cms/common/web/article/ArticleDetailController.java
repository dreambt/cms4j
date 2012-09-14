package cn.im47.cms.common.web.article;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.service.article.ArticleManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    private ArticleManager articleManager;

    @RequiresPermissions("article:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("article") Article article, BindingResult bindingResult,
                         HttpServletRequest request, RedirectAttributes redirectAttributes) {
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

        if (bindingResult.hasErrors() || articleManager.update(article) <= 0) {
            redirectAttributes.addFlashAttribute("error", "保存文章失败.");
            return "redirect:/article/listAll";
        } else {
            redirectAttributes.addFlashAttribute("info", "保存文章成功.");
            return "redirect:/article/listAll";
        }
    }

    @ModelAttribute("article")
    public Article getArticle(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return articleManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setArticleManager(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

}
