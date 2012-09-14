package cn.im47.cms.common.web.article;

import cn.im47.cms.common.entity.article.Archive;
import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.service.article.ArchiveManager;
import cn.im47.cms.common.service.article.ArticleManager;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 归类功能
 * <p/>
 * User: pengfei.dongpf@gmail.com, baitao.jibt@gmail.com
 * Date: 12-4-2
 * Time: 上午11:43
 */
@Controller
@RequestMapping(value = "/archive")
public class ArchiveController {

    private ArchiveManager archiveManager;
    private ArticleManager articleManager;

    // TODO
    @RequestMapping(value = "list")
    public String articleListOfArchive(Model model) {
        model.addAttribute("archives", archiveManager.getTopTen());
        model.addAttribute("newArticles", articleManager.getNewTop(10));
        return "article/archives";
    }

    @RequestMapping(value = "list/{id}")
    public String articleListByArchiveId(Model model, @PathVariable("id") Long id) {
        Archive archive = archiveManager.get(id);
        model.addAttribute("articles", articleManager.getByArchiveId(id, 0, 12));//文章列表
        model.addAttribute("archive", archive);
        model.addAttribute("archives", archiveManager.getTopTen());//边栏归档日志
        model.addAttribute("newArticles", articleManager.getNewTop(10));//边栏最新文章
        model.addAttribute("total", Long.valueOf(archive.getArticleList().size()));
        return "article/list";
    }

    @RequestMapping(value = "list/ajax/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Article> ajaxListOfArticleByArchive(@PathVariable("id") Long id, @RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return articleManager.getByArchiveId(id, offset, limit);
    }

    @RequestMapping(value = "save/{dateTime}", method = RequestMethod.GET)
    public String saveArchiveByMonth(@PathVariable("dateTime") String dateTime) {
        DateTimeFormatter pattern = DateTimeFormat.forPattern("yyyyMM");
        DateTime time = DateTime.parse(dateTime, pattern);
        archiveManager.updateByMonth(time);
        return "redirect:/archive/list";
    }

    @Autowired
    public void setArchiveManager(ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

}
