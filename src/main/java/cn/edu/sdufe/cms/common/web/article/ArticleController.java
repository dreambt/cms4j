package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.account.UserManager;
import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 文章控制器
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-18
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/article")
public class ArticleController {

    private static final int ARTICLE_NUM = 75;

    private ArticleManager articleManager;

    private CategoryManager categoryManager;

    private UserManager userManager;
    
    private ArchiveManager archiveManager;

    /**
     * 后台获取所有文章列表
     *
     * @param model
     * @return
     */
    @RequiresPermissions("article:listAll")
    @RequestMapping(value = {"listAll", ""})
    public String listAllArticle(Model model) {
        model.addAttribute("articles", articleManager.getAllArticle(0, ARTICLE_NUM));
        return "dashboard/article/listAll";
    }

    /**
     * 后台获取所有文章列表
     *
     * @param offset
     * @param limit
     * @return
     */
    @RequiresPermissions("article:listAll")
    @RequestMapping(value = "listAll/ajax")
    @ResponseBody
    public List<Article> ajaxAllArticle(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getAllArticle(offset, limit);
    }

    /**
     * 获取菜单编号为id的所有文章列表
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "list/{id}", method = RequestMethod.GET)
    public String listOfArticle(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getArticleListByCategoryId(id, 0, 10));
        model.addAttribute("category", categoryManager.getCategory(id));
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("archives",archiveManager.getTopTenArchive());
        model.addAttribute("newArticles",articleManager.getTopTenArticle());
        model.addAttribute("total", articleManager.getCount(id));
        return "article/list";
    }

    /**
     * 获取菜单编号为id的所有文章列表
     *
     * @param id
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "list/ajax/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Article> ajaxListOfArticle(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getArticleListByCategoryId(id, offset, limit);
    }

    /**
     * 获取菜单编号为id的所有文章摘要
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "digest/{id}", method = RequestMethod.GET)
    public String digestOfArticle(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getArticleDigestByCategoryId(id, 0, 10));
        model.addAttribute("category", categoryManager.getCategory(id));
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("archives",archiveManager.getTopTenArchive());
        model.addAttribute("newArticles",articleManager.getTopTenArticle());
        model.addAttribute("total", articleManager.getCount(id));
        return "article/digest";
    }

    /**
     * 获取菜单编号为id的所有文章摘要
     *
     * @param id
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "digest/ajax/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Article> ajaxDigestOfArticle(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getArticleDigestByCategoryId(id, offset, limit);
    }

    /**
     * 发表新文章
     *
     * @param model
     * @return
     */
    @RequiresPermissions("article:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String editArticle(Model model) {
        // 不用报错，Neither BindingResult nor plain target object for bean name 'article' available as request attribute
        model.addAttribute("article", new Article());
        model.addAttribute("categories", categoryManager.getAllowPublishCategory());
        return "dashboard/article/edit";
    }

    /**
     * 保存新文章
     *
     * @param article
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("article:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Article article, RedirectAttributes redirectAttributes) {
        // 获取用户登录信息
        ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
        article.setAuthor(shiroUser.getName());

        // 文章作者
        User user = userManager.getUser(shiroUser.getId());
        article.setUser(user);

        article.setCreateTime(new Date());

        // 保存
        if (null == articleManager.saveArticle(article)) {
            redirectAttributes.addFlashAttribute("error", "创建文章失败");
            return "redirect:/article/create";
        } else {
            redirectAttributes.addFlashAttribute("info", "创建文章成功");
            return "redirect:/article/listAll";
        }
    }

    @RequiresPermissions("article:audit")
    @RequestMapping(value = "auditAll")
    public String batchAuditArticle(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要审核的文章.");
            return "redirect:/article/listAll";
        } else {
            articleManager.batchAudit(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量审核文章成功.");
            return "redirect:/article/listAll";
        }
    }

    @RequiresPermissions("article:delete")
    @RequestMapping(value = "deleteAll")
    public String batchDeleteArticle(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的文章.");
            return "redirect:/article/listAll";
        } else {
            articleManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除文章成功.");
            return "redirect:/article/listAll";
        }
    }

    @Autowired
    public void setArticleManager(@Qualifier("articleManager") ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

    @Autowired
    public void setUserManager(@Qualifier("userManager") UserManager userManager) {
        this.userManager = userManager;
    }
    @Autowired
    public void setArchiveManager(@Qualifier("archiveManager") ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }
}