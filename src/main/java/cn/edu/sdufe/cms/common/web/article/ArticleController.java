package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.service.account.UserManager;
import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.utils.Encodes;

import javax.servlet.http.HttpServletRequest;
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

    private LinkManager linkManager;

    /**
     * 获取编号为id的文章正文
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "content/{id}", method = RequestMethod.GET)
    public String contextOfArticle(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Article article = articleManager.findForView(id);
        //article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        if (null == article) {
            redirectAttributes.addFlashAttribute("message", "不存在编号为 " + id + " 的文章");
            return "redirect:/error/404";
        }

        model.addAttribute("article", article);
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("archives", archiveManager.getTopTen());
        model.addAttribute("newArticles", articleManager.getTopTen());
        model.addAttribute("links", linkManager.getAllLink());
        return "article/content";
    }

    /**
     * 后台获取所有文章列表
     *
     * @param model
     * @return
     */
    @RequiresPermissions("article:list")
    @RequestMapping(value = {"listAll", ""})
    public String listAllArticle(Model model) {
        model.addAttribute("articles", articleManager.getAll(0, ARTICLE_NUM));
        return "dashboard/article/listAll";
    }

    /**
     * 后台获取所有文章列表
     *
     * @param offset
     * @param limit
     * @return
     */
    @RequiresPermissions("article:list")
    @RequestMapping(value = "listAll/ajax")
    @ResponseBody
    public List<Article> ajaxAllArticle(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getAll(offset, limit);
    }


    /**
     * 获取菜单编号为id的所有文章列表
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "listByCategory/{id}", method = RequestMethod.GET)
    public String listArticleByCategory(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getListByCategoryId(id, 0, 110));
        return "dashboard/article/listAll";
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
        Long total = articleManager.count(id).longValue();
        int limit = 10;
        Long pageCount = 1L;
        if (total % limit == 0) {
            pageCount = total / limit;
        } else {
            pageCount = total / limit + 1;
        }
        model.addAttribute("articles", articleManager.getListByCategoryId(id, 0, limit));//文章列表
        model.addAttribute("categories", categoryManager.getNavCategory());//导航菜单
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTopTen());//边栏归档日志
        model.addAttribute("newArticles", articleManager.getTopTen());//边栏最新文章
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("links", linkManager.getAllLink());//页脚友情链接
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
        return articleManager.getListByCategoryId(id, offset, limit);
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
        Long total = articleManager.count(id).longValue();
        int limit = 6;
        Long pageCount = 1L;
        if (total % limit == 0) {
            pageCount = total / limit;
        } else {
            pageCount = total / limit + 1;
        }
        model.addAttribute("articles", articleManager.getDigestByCategoryId(id, 0, limit));
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("archives", archiveManager.getTopTen());
        model.addAttribute("newArticles", articleManager.getTopTen());
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("links", linkManager.getAllLink());
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
        List<Article> articleList = articleManager.getDigestByCategoryId(id, offset, limit);
        return articleList;
    }

    /**
     * 获得公告
     *
     * @return
     */
    @RequestMapping(value = "listPost")
    public String listPost() {
        Long id = new Long(1L);
        return "redirect:/article/list/" + id;
    }

    /**
     * 发表新文章
     *
     * @param model
     * @return
     */
    @RequiresPermissions("article:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createArticle(Model model) {
        // 不用报错，Neither BindingResult nor plain target object for bean name 'article' available as request attribute
        model.addAttribute("article", new Article());
        List<Category> categories = categoryManager.getAllowPublishCategory();
        model.addAttribute("categories", categories);
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
    public String save(Article article, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 获取用户登录信息
        ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();

        // 文章作者
        User user = userManager.get(shiroUser.getId());
        article.setUser(user);

        // 保存
        if (articleManager.save(article, request) <= 0) {
            redirectAttributes.addFlashAttribute("error", "创建文章失败");
            return "redirect:/article/create";
        } else {
            redirectAttributes.addFlashAttribute("info", "创建文章成功");
            return "redirect:/article/listAll";
        }
    }

    @RequiresPermissions("article:edit")
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

    /**
     * 置顶编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:edit")
    @RequestMapping(value = "top/{id}")
    public String topArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.update(id, "top") > 0) {
            redirectAttributes.addFlashAttribute("info", "操作文章" + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
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
    public String allowArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.update(id, "allow_comment") > 0) {
            redirectAttributes.addFlashAttribute("info", "操作文章" + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
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
    public String auditArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.update(id, "status") > 0) {
            redirectAttributes.addFlashAttribute("info", "操作文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
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
    public String deleteArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.update(id, "deleted") > 0) {
            redirectAttributes.addFlashAttribute("info", "操作文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 成功.");
        }
        return "redirect:/article/listAll";
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

    @Autowired
    public void setLinkManager(@Qualifier("linkManager") LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}