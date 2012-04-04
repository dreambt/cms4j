package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.dao.article.ArticleJpaDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.utilities.analyzer.ArticleKeyword;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.Validate;
import org.apache.ibatis.session.RowBounds;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.beanvalidator.BeanValidators;
import org.springside.modules.orm.jpa.Jpas;

import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.util.Date;
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

    private static Logger logger = LoggerFactory.getLogger(ArticleManager.class);

    private static final int KEYWORD_NUM = 10;

    private ArticleDao articleDao = null;

    private ArticleJpaDao articleJpaDao = null;

    private CategoryDao categoryDao = null;

    private Validator validator = null;

    /**
     * 通过id获取文章
     *
     * @param id
     * @return
     */
    public Article getArticle(Long id) {
        Article article = articleJpaDao.findOne(id);

        // 记录文章访问次数
        article.setViews(article.getViews() + 1);

        //Dao不取相关连接表中的内容，比如评论
        //return articleDao.getArticle(id);
        return updateArticle(article);
    }

    /**
     * 获取分类categoryId下面的文章数量
     *
     * @param categoryId 分类编号
     * @return
     */
    public Long getCount(Long categoryId) {
        return articleDao.count(categoryId);
    }

    /**
     * 使用默认的排序方式返回所有文章
     *
     * @return
     */
    public List<Article> getAllArticle(int offset, int limit) {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("Direction", "DESC");
        parameters.put("Sort", "id");
        return articleDao.getAll(parameters, new RowBounds(offset, limit));
    }

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    public List<Article> getTopTenArticle() {
        return articleDao.getTopTen();
    }

    /**
     * 加载Lazy属性
     *
     * @return
     */
    @Deprecated
    public List<Article> getAllArticleInitialized() {
        List<Article> result = (List<Article>) articleJpaDao.findAll();
        for (Article article : result) {
            Jpas.initLazyProperty(article.getCommentList());
        }
        return result;
    }

    /**
     * 按照parameters搜索用户
     *
     * @param parameters
     * @return
     */
    @Deprecated
    public List<Article> searchArticle(Map<String, Object> parameters) {
        return articleDao.search(parameters);
    }

    /**
     * 通过分类categoryId查找文章
     *
     * @param categoryId
     * @return
     */
    public List<Article> getArticleListByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.getListByCategoryId(categoryId, new RowBounds(offset, limit));
    }

    /**
     * 通过分类categoryId查找文章
     *
     * @param categoryId
     * @return
     */
    public List<Article> getArticleDigestByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.getDigestByCategoryId(categoryId, new RowBounds(offset, limit));
    }

    /**
     * 通过用户userId查找文章
     *
     * @param userId
     * @return
     */
    @Deprecated
    public List<Article> getArticleByUserId(Long userId) {
        return (List<Article>) articleJpaDao.findByUserId(userId);
    }

    /**
     * 保存文章
     *
     * @param article
     * @return
     */
    @Transactional(readOnly = false)
    public Article saveArticle(Article article) {
        try {
            // 生成默认摘要
            String str = Jsoup.parse(article.getMessage()).text();
            if (str.length() > 150) {
                article.setDigest(str.substring(0, 150));
            } else {
                article.setDigest(str);
            }

            // 关键词由任务生成
            article.setKeyword("");

            // 文章分类
            Category category = categoryDao.get(article.getCategoryId());
            article.setCategory(category);
            article.setCategoryName(category.getCategoryName());

            //使用Hibernate Validator校验请求参数
            Validate.notNull(article, "文章参数为空");
            BeanValidators.validateWithException(validator, article);

            return articleJpaDao.save(article);
        } catch (ConstraintViolationException cve) {
            logger.warn("操作员{}尝试发表文章, 缺少相关字段.", cve.getConstraintViolations().toString());
            return null;
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
            article = articleDao.get(Long.parseLong(id));
            article.setStatus(false);
            this.updateArticle(article);
        }
    }

    /**
     * 批量改变文章的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        Article article = null;
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            article = articleDao.get(Long.parseLong(id));
            article.setDeleted(true);
            this.updateArticle(article);
        }
    }

    /**
     * 更新文章
     *
     * @param article
     */
    @Transactional(readOnly = false)
    public Article updateArticle(Article article) {
        return articleJpaDao.save(article);
    }

    /**
     * 任务删除文章
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int deleteArticle() {
        List<Long> list = articleDao.getDeletedId();
        int count = list.size();
        while (list.size() > 0) {
            try {
                articleJpaDao.delete((Long) list.remove(0));
                Thread.sleep(5000);// 每次都要休息一会儿
            } catch (InterruptedException e) {
                logger.info("在批量删除文章时发生异常.");
            }
        }
        return count;
    }

    @Autowired
    public void setValidator(@Qualifier("validator") Validator validator) {
        this.validator = validator;
    }

    @Autowired(required = false)
    public void setCategoryDao(@Qualifier("categoryDao") CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

    @Autowired
    public void setArticleDao(@Qualifier("articleDao") ArticleDao articleDao) {
        this.articleDao = articleDao;
    }

    @Autowired
    public void setArticleJpaDao(@Qualifier("articleJpaDao") ArticleJpaDao articleJpaDao) {
        this.articleJpaDao = articleJpaDao;
    }
}