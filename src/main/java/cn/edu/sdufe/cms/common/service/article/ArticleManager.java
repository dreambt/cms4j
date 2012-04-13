package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.utilities.analyzer.ArticleKeyword;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.Validate;
import org.apache.ibatis.session.RowBounds;
import org.apache.shiro.SecurityUtils;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.beanvalidator.BeanValidators;
import org.springside.modules.utils.Encodes;

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

    private static Logger logger = LoggerFactory.getLogger(ArticleManager.class);

    private static final int KEYWORD_NUM = 10;

    private ArticleDao articleDao = null;

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
            Article article1 = new Article();
            article1.setId(article.getId());
            article1.setViews(article.getViews() + 1);
            articleDao.update(article1);

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
    public List<Article> getAll(int offset, int limit) {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("Direction", "DESC");
        parameters.put("Sort", "id");
        return articleDao.search(parameters, new RowBounds(offset, limit));
    }

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    public List<Article> getTopTen() {
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
        return articleDao.findTitleByCategoryId(categoryId, new RowBounds(offset, limit));
    }

    /**
     * 通过分类categoryId查找文章列表
     *
     * @param categoryId
     * @return
     */
    public List<Article> getListByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.findByCategoryId(categoryId, new RowBounds(offset, limit));
    }

    /**
     * 通过分类categoryId查找文章摘要
     *
     * @param categoryId
     * @return
     */
    public List<Article> getDigestByCategoryId(Long categoryId, int offset, int limit) {
        return articleDao.findDigestByCategoryId(categoryId, new RowBounds(offset, limit));
    }

    /**
     * 保存文章
     *
     * @param article
     * @return
     */
    @Transactional(readOnly = false)
    public int save(Article article) {
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

            // 文章作者
            ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
            User user = new User();
            user.setId(shiroUser.getId());
            article.setUser(user);

            // 文章正文进行HTML编码
            article.setMessage(Encodes.escapeHtml(article.getMessage()));

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
            article = articleDao.findOne(Long.parseLong(id));
            article.setStatus(false);
            this.update(article);
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
            article = articleDao.findOne(Long.parseLong(id));
            article.setDeleted(true);
            this.update(article);
        }
    }

    /**
     * 更新文章
     *
     * @param article
     */
    @Transactional(readOnly = false)
    public int update(Article article) {
        return articleDao.update(article);
    }

    /**
     * 任务删除文章
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() {
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

}