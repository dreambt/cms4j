package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.account.UserManager;
import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArchiveManagerImpl;
import cn.edu.sdufe.cms.common.service.article.ArticleManagerImpl;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 文章控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-3-18
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/article")
public class ArticleController {

    private ArticleManagerImpl articleManager;
    private CategoryManager categoryManager;
    private UserManager userManager;
    private ArchiveManager archiveManager;

    /**
     * 获取编号为id的文章正文
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "content/{id}", method = RequestMethod.GET)
    public String contextOfArticle(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Article article = articleManager.getForView(id);
        if (null == article || null == SecurityUtils.getSubject().getPrincipal() && (!article.isStatus() || article.isDeleted())) {
            redirectAttributes.addFlashAttribute("error", "不存在编号为 " + id + " 的文章.");
            return "redirect:/error/404";
        }

        //article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        model.addAttribute("article", article);
        model.addAttribute("archives", archiveManager.getTopTen());
        model.addAttribute("newArticles", articleManager.getNewTop(10));
        return "article/content";
    }

    /**
     * 获取编号为id的文章正文
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "content/full/{id}", method = RequestMethod.GET)
    public String fullOfArticle(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Article article = articleManager.getForView(id);
        if (null == article) {
            redirectAttributes.addFlashAttribute("message", "不存在编号为 " + id + " 的文章");
            return "redirect:/error/404";
        }

        //article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        model.addAttribute("article", article);
        return "article/fullwidth";
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
        model.addAttribute("articles", articleManager.getAll());
        model.addAttribute("total", articleManager.count());
        return "dashboard/article/listAll";
    }

    /**
     * 后台获取所有文章列表
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    @RequiresPermissions("article:list")
    @RequestMapping(value = "listAll/ajax")
    @ResponseBody
    public List<Article> ajaxAllArticle(@RequestParam("offset") int offset, @RequestParam("limit") int limit, String sort, String direction) {
        if (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(direction)) {
            return articleManager.getAll(offset, limit, sort, direction);
        } else {
            return articleManager.getAll(offset, limit);
        }
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
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 110));
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
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 12));//文章列表(首页显示)
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTopTen());//边栏归档日志
        model.addAttribute("newArticles", articleManager.getNewTop(10));//边栏最新文章
        model.addAttribute("total", articleManager.count(id));
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
        return articleManager.getByCategoryId(id, offset, limit);
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
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 6));
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTopTen());
        model.addAttribute("newArticles", articleManager.getNewTop(10));
        model.addAttribute("total", articleManager.count(id));
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
    @RequestMapping(value = "digest/ajax/{id}")
    @ResponseBody
    public List<Article> ajaxDigestOfArticle(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getByCategoryId(id, offset, limit);
    }

    /**
     * 获得公告
     *
     * @return
     */
    @RequestMapping(value = "listPost")
    public String listPost() {
        return "redirect:/article/list/1";
    }

    /**
     * 显示首页资讯
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "listInfo", method = RequestMethod.GET)
    public String listInfo(Model model) {
        // TODO 应该用fatherCategoryId的 , 不然，下次增加新分类后没法查询完整数据
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        model.addAttribute("articles", articleManager.getByCategoryIds(ids, 0, 12));//文章列表
        model.addAttribute("category", categoryManager.get(18L));//获取分类信息
        model.addAttribute("archives", archiveManager.getTopTen());//边栏归档日志
        model.addAttribute("newArticles", articleManager.getNewTop(10));//边栏最新文章
        model.addAttribute("total", articleManager.count(ids));
        model.addAttribute("url", "listInfo");
        return "article/list";
    }

    /**
     * 显示首页资讯
     *
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "listInfo/ajax")
    @ResponseBody
    public List<Article> ajaxListInfo(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        return articleManager.getByCategoryIds(ids, offset, limit);
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
        article.setUser(userManager.get(shiroUser.getId()));

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

        // 保存
        if (articleManager.save(article) <= 0) {
            redirectAttributes.addFlashAttribute("error", "创建文章失败");
            return "redirect:/article/create";
        } else {
            redirectAttributes.addFlashAttribute("info", "创建文章成功");
            return "redirect:/article/listAll";
        }
    }

    @RequiresPermissions("article:edit")
    @RequestMapping(value = "batchAudit", method = RequestMethod.GET)
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

    @RequiresPermissions("article:save")
    @RequestMapping(value = "batchDelete", method = RequestMethod.GET)
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
    @RequestMapping(value = "top/{id}", method = RequestMethod.GET)
    public String topArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.top(id)) {
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
    @RequestMapping(value = "allow/{id}", method = RequestMethod.GET)
    public String allowArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.allowComment(id)) {
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
    @RequestMapping(value = "audit/{id}", method = RequestMethod.GET)
    public String auditArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.audit(id)) {
            redirectAttributes.addFlashAttribute("info", "操作文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 失败.");
        }
        return "redirect:/article/listAll";
    }

    /**
     * 标记删除编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("article:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String deleteArticle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (articleManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "操作文章 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作文章 " + id + " 成功.");
        }
        return "redirect:/article/listAll";
    }

    @Autowired
    public void setArticleManager(ArticleManagerImpl articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

    @Autowired
    public void setUserManager(UserManager userManager) {
        this.userManager = userManager;
    }

    @Autowired
    public void setArchiveManager(ArchiveManagerImpl archiveManager) {
        this.archiveManager = archiveManager;
    }

}
