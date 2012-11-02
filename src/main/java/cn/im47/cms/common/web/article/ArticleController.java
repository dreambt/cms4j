package cn.im47.cms.common.web.article;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.service.account.UserManager;
import cn.im47.cms.common.service.article.ArchiveManager;
import cn.im47.cms.common.service.article.impl.ArchiveManagerImpl;
import cn.im47.cms.common.service.article.impl.ArticleManagerImpl;
import cn.im47.cms.common.service.category.CategoryManager;
import cn.im47.cms.common.vo.ResponseMessage;
import cn.im47.cms.security.ShiroDbRealm;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.utils.Encodes;

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

    @RequestMapping(value = "content/{id}", method = RequestMethod.GET)
    public String contextOfArticle(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Article article = articleManager.getForView(id);
        if (null == article || null == SecurityUtils.getSubject().getPrincipal() && (!article.isStatus() || article.isDeleted())) {
            redirectAttributes.addFlashAttribute("error", "不存在编号为 " + id + " 的文章.");
            return "redirect:/error/404";
        }

        //article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        model.addAttribute("article", article);
        model.addAttribute("archives", archiveManager.getTop(8));
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "article/content";
    }

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

    @RequiresPermissions("article:list")
    @RequestMapping(value = {"listAll", ""}, method = RequestMethod.GET)
    public String listAllArticle(Model model) {
        model.addAttribute("articles", articleManager.getAll());
        model.addAttribute("total", articleManager.count());
        return "dashboard/article/listAll";
    }

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

    @RequestMapping(value = "listByCategory/{id}", method = RequestMethod.GET)
    public String listArticleByCategory(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 110));
        return "dashboard/article/listAll";
    }

    @RequestMapping(value = "list/{id}", method = RequestMethod.GET)
    public String listOfArticle(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 12));//文章列表(首页显示)
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTop(8));//边栏归档日志
        model.addAttribute("newArticles", articleManager.getNewTop(8));//边栏最新文章
        model.addAttribute("total", articleManager.count(id));
        return "article/list";
    }

    @RequestMapping(value = "list/ajax/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Article> ajaxListOfArticle(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getByCategoryId(id, offset, limit);
    }

    @RequestMapping(value = "digest/{id}", method = RequestMethod.GET)
    public String digestOfArticle(@PathVariable("id") Long id, Model model) {
        model.addAttribute("articles", articleManager.getByCategoryId(id, 0, 6));
        model.addAttribute("category", categoryManager.get(id));//获取分类信息
        model.addAttribute("archives", archiveManager.getTop(8));
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        model.addAttribute("total", articleManager.count(id));
        return "article/digest";
    }

    @RequestMapping(value = "digest/ajax/{id}")
    @ResponseBody
    public List<Article> ajaxDigestOfArticle(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getByCategoryId(id, offset, limit);
    }

    @RequestMapping(value = "listPost")
    public String listPost() {
        return "redirect:/article/list/1";
    }

    @RequestMapping(value = "listInfo", method = RequestMethod.GET)
    public String listInfo(Model model) {
        // TODO 应该用fatherCategoryId的 , 不然，下次增加新分类后没法查询完整数据
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        model.addAttribute("articles", articleManager.getByCategoryIds(ids, 0, 12));//文章列表
        model.addAttribute("category", categoryManager.get(18L));//获取分类信息
        model.addAttribute("archives", archiveManager.getTop(8));//边栏归档日志
        model.addAttribute("newArticles", articleManager.getNewTop(8));//边栏最新文章
        model.addAttribute("total", articleManager.count(ids));
        model.addAttribute("url", "listInfo");
        return "article/list";
    }

    @RequestMapping(value = "listInfo/ajax")
    @ResponseBody
    public List<Article> ajaxListInfo(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        return articleManager.getByCategoryIds(ids, offset, limit);
    }

    @RequiresPermissions("article:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        // 不用报错，Neither BindingResult nor plain target object for bean name 'article' available as request attribute
        model.addAttribute("article", new Article());
        model.addAttribute("action", "create");
        return "dashboard/article/edit";
    }

    @RequiresPermissions("article:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(Article article, HttpServletRequest request, RedirectAttributes redirectAttributes) {
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

    @RequiresPermissions("article:update")
    @RequestMapping(value = {"update/{id}"}, method = RequestMethod.GET)
    public String updateForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Article article = articleManager.get(id);

        // 编辑不存在的文章，给出提示
        if (null == article) {
            redirectAttributes.addFlashAttribute("error", "文章不存在.");
            return "redirect:/article/listAll";
        }

        // 反解析，否则编辑器会显示HTML代码
        article.setMessage(Encodes.unescapeHtml(article.getMessage()));

        // 获取所有分类
        model.addAttribute("categories", categoryManager.getAllowPublishCategory());
        model.addAttribute("article", article);
        model.addAttribute("action", "update");
        return "dashboard/article/edit";
    }

    @RequiresPermissions("article:save")
    @RequestMapping(value = "batchAudit", method = RequestMethod.POST)
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
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
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

    @RequiresPermissions("article:save")
    @RequestMapping(value = "top/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage topArticle(@PathVariable("id") Long id) {
        if (articleManager.top(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("置顶文章 " + id + " 置顶失败.");
        }
    }

    @RequiresPermissions("article:save")
    @RequestMapping(value = "allow/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage allowArticle(@PathVariable("id") Long id) {
        if (articleManager.allowComment(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("允许评论文章 " + id + " 失败.");
        }
    }

    @RequiresPermissions("article:save")
    @RequestMapping(value = "audit/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage auditArticle(@PathVariable("id") Long id) {
        if (articleManager.audit(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("审核文章 " + id + " 失败.");
        }
    }

    @RequiresPermissions("article:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage deleteArticle(@PathVariable("id") Long id) {
        if (articleManager.delete(id) > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("删除文章 " + id + " 失败.");
        }
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
