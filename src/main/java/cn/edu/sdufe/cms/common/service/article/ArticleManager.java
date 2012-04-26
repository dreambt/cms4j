package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveDao;
import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.utilities.analyzer.ArticleKeyword;
import cn.edu.sdufe.cms.utilities.thumb.ImageThumb;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.Validate;
import org.apache.shiro.SecurityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.beanvalidator.BeanValidators;
import org.springside.modules.utils.Encodes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.util.List;
import java.util.Map;

/**
 * 文章的业务逻辑
 * User: FlyFive
 * Date: 12-3-19
 * Time: 下午2:08
 */
@Component
@Transactional(readOnly = true)
public class ArticleManager {

    private static final Logger logger = LoggerFactory.getLogger(ArticleManager.class);

    private static final int KEYWORD_NUM = 10;

    private ArticleDao articleDao = null;

    private ArchiveDao archiveDao;

    private ArchiveManager archiveManager;

    private Validator validator = null;

    /**
     * 通过id获取文章
     *
     * @param id
     * @return
     */
    public Article findOne(Long id) {
        return articleDao.findOne(id);
    }

    /**
     * 通过id获取文章用于显示，带浏览次数统计
     *
     * @param id
     * @return
     */
    @Transactional(readOnly = false)
    public Article findForView(Long id) {
        Article article = articleDao.findOne(id);

        // 判断文章是否为空
        if (null != article) {
            // 记录文章访问次数
            articleDao.update(id);

            article.setMessage(Encodes.unescapeHtml(article.getMessage()));
        }

        return article;
    }

    /**
     * 获取分类categoryId下面的文章数量
     *
     * @param categoryId 分类编号
     * @return
     */
    public Long count(Long categoryId) {
        return articleDao.count(categoryId);
    }

    /**
     * 使用默认的排序方式返回所有文章
     *
     * @return
     */
    public List<Article> findAll(int offset, int limit) {
        return articleDao.findAll(offset, limit);
    }

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    public List<Article> findTopTen() {
        return articleDao.findTopTen();
    }

    /**
     * 按照parameters搜索用户
     *
     * @param parameters
     * @return
     */
    public List<Article> search(Map<String, Object> parameters) {
        parameters.put("Direction", "DESC");
        parameters.put("Sort", "id");
        return articleDao.search(parameters);
    }

    /**
     * 通过分类categoryId查找文章标题
     *
     * @param categoryId
     * @return
     */
    public List<Article> getTitleByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.findTitleByCategoryId(categoryId, offset, limit);
    }

    /**
     * 获得社会资讯下的最新文章
     *
     * @return
     */
    public List<Article> getInfo() {
        Long[] ids = {19L, 20L, 21L, 22L};
        return articleDao.findTitleByCategoryId(ids);
    }

    /**
     * 获得成果显示
     *
     * @return
     */
    public List<Article> getResult() {
        Long[] ids = {17L, 25L};
        return articleDao.findTitleByCategoryId(ids);
    }

    /**
     * 通过分类categoryId查找文章列表
     *
     * @param categoryId
     * @return
     */
    public List<Article> getListByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.findByCategoryId(categoryId, offset, limit);
    }

    /**
     * 通过分类categoryId查找文章摘要
     *
     * @param categoryId
     * @return
     */
    public List<Article> getDigestByCategoryId(Long categoryId, int offset, int limit) {

        return articleDao.findByCategoryId(categoryId, offset, limit);
    }

    /**
     * 保存文章
     *
     * @param article
     * @return
     */
    @Transactional(readOnly = false)
    public int save(Article article, HttpServletRequest request) {
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

        try {
            // 生成默认摘要
            String str = Jsoup.parse(article.getMessage()).text();
            if (str.length() > 150) {
                article.setDigest(str.substring(0, 150));
            } else {
                article.setDigest(str);
            }

            //文章中的首个图片
            article.setImageName(this.getImageFromMessage(article.getMessage()));

            //项目路径
            // TODO 迁移服务器需要修改
            String path = System.getProperty("user.dir") + "\\src\\main\\webapp\\static\\uploads\\";
            ImageThumb imageThumb = new ImageThumb();
            try {
                imageThumb.saveImageAsJpg(path + "article\\article-big\\" + article.getImageName(), path + "article\\news-thumb\\" + article.getImageName(), 274, 157);
                imageThumb.saveImageAsJpg(path + "article\\article-big\\" + article.getImageName(), path + "article\\digest-thumb\\" + article.getImageName(), 134, 134);
            } catch (Exception e) {
                logger.error("Thumb Image: ", e.getMessage());
            }

            // 关键词由任务生成
            article.setKeyword("");

            // 文章作者
            ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
            article.setUser(new User(shiroUser.getId()));

            // 进行HTML编码, 否则前台可能破页
            article.setMessage(Encodes.escapeHtml(article.getMessage()));
            article.setDigest(Encodes.escapeHtml(article.getDigest()));

            //使用Hibernate Validator校验请求参数
            Validate.notNull(article, "文章参数为空");
            BeanValidators.validateWithException(validator, article);

            return articleDao.save(article);
        } catch (ConstraintViolationException cve) {
            logger.warn("操作员{}尝试发表文章, 缺少相关字段.", cve.getConstraintViolations().toString());
            return 0;
        }
    }

    /**
     * 从正文html代码中获得图片路径
     *
     * @param message
     * @return
     */
    public String getImageFromMessage(String message) {
        Document document = Jsoup.parse(message);
        Elements imgs = document.getElementsByTag("img");
        if (null == imgs || imgs.size() == 0) {
            return "";
        } else {
            Element img = imgs.first();
            String srcString = img.attr("src");
            String imgName = srcString.substring(srcString.lastIndexOf("/") + 1, srcString.length());
            return imgName;
        }
    }

    /**
     * 生成关键词
     *
     * @param article
     * @param num     关键词个数
     */
    public void genKeyword(Article article, int num) {
        ArticleKeyword articleKeyword = new ArticleKeyword();
        String keyword = articleKeyword.getArticleKeyword(article.getSubject(), article.getMessage(), num);
        article.setKeyword(keyword);
        logger.info("为文章 {} 生成关键词：{}", article.getId(), keyword);
    }

    /**
     * 批量生成关键词
     */
    public int genKeyword() {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("keyword", " ");
        parameters.put("Direction", "ASC");
        parameters.put("Sort", "id");
        List<Article> articleList = articleDao.search(parameters);
        for (Article article : articleList) {
            genKeyword(article, KEYWORD_NUM);
        }
        return articleList.size();
    }

    /**
     * 批量审核文章
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        Article article = null;
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            articleDao.update(Long.parseLong(id), "status");
        }
    }

    /**
     * 批量改变文章的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            articleDao.update(Long.parseLong(id), "deleted");
        }
    }

    /**
     * 更新文章
     *
     * @param article
     */
    @Transactional(readOnly = false)
    public int update(Article article, HttpServletRequest request) {
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

        try {
            // 生成默认摘要
            String str = Jsoup.parse(article.getMessage()).text();
            if (str.length() > 150) {
                article.setDigest(str.substring(0, 150));
            } else {
                article.setDigest(str);
            }

            //文章中的首个图片
            article.setImageName(this.getImageFromMessage(article.getMessage()));
            //项目路径// TODO 迁移服务器需要修改
            String path = System.getProperty("user.dir") + "\\src\\main\\webapp\\static\\uploads\\";
            ImageThumb imageThumb = new ImageThumb();
            try {
                imageThumb.saveImageAsJpg(path + "article\\article-big\\" + article.getImageName(), path + "article\\news-thumb\\" + article.getImageName(), 274, 157);
                imageThumb.saveImageAsJpg(path + "article\\article-big\\" + article.getImageName(), path + "article\\digest-thumb\\" + article.getImageName(), 134, 134);

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            // 关键词由任务生成
            article.setKeyword("");

            // 进行HTML编码, 否则前台可能破页
            article.setMessage(Encodes.escapeHtml(article.getMessage()));
            article.setDigest(Encodes.escapeHtml(article.getDigest()));

            //使用Hibernate Validator校验请求参数
            Validate.notNull(article, "文章参数为空");
            BeanValidators.validateWithException(validator, article);

            return articleDao.update(article);
        } catch (ConstraintViolationException cve) {
            logger.warn("操作员{}尝试发表文章, 缺少相关字段.", cve.getConstraintViolations().toString());
            return 0;
        }
    }

    /**
     * 更新文章
     *
     * @param id
     * @param column
     */
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        return articleDao.update(id, column);
    }

    /**
     * 任务删除文章
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() {
        List<Long> ids = articleDao.findDeletedArticle();
        if(null == ids) {
            return 0;
        }
        archiveDao.deleteAAByArticleId(ids);
        archiveManager.batchUpdate();
        return articleDao.delete();
    }

    @Autowired
    public void setValidator(@Qualifier("validator") Validator validator) {
        this.validator = validator;
    }

    @Autowired
    public void setArticleDao(@Qualifier("articleDao") ArticleDao articleDao) {
        this.articleDao = articleDao;
    }

    @Autowired
    public void setArchiveDao(ArchiveDao archiveDao) {
        this.archiveDao = archiveDao;
    }

    @Autowired
    public void setArchiveManager(ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }
}