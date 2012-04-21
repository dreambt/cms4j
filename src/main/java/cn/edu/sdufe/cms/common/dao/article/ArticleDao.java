package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import com.google.common.collect.Maps;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 文章Dao
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午18:34
 */
@Component
public class ArticleDao extends SqlSessionDaoSupport {

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    @Cacheable(value = "topten")
    public List<Article> findTopTen() {
        return getSqlSession().selectList("Article.getTopTenArticle");
    }

    /**
     * 获取分类id的文章标题
     *
     * @param categoryId
     * @param rowBounds
     * @return
     */
    @Cacheable(value = "article_title")
    public List<Article> findTitleByCategoryId(Long categoryId, RowBounds rowBounds) {
        return getSqlSession().selectList("Article.getTitleByCategoryId", categoryId, rowBounds);
    }

    /**
     * 获取分类id的文章列表
     *
     * @param categoryId
     * @param rowBounds
     * @return
     */
    @Cacheable(value = "article")
    public List<Article> findByCategoryId(Long categoryId, RowBounds rowBounds) {
        return getSqlSession().selectList("Article.getArticleByCategoryId", categoryId, rowBounds);
    }

    /**
     * 获取首页显示新闻
     *
     * @return
     */
    @Cacheable(value = "news")
    public List<Article> findNews() {
        return getSqlSession().selectList("Article.getNews");
    }

    /**
     * 获取社会资讯下的最新文章
     * @return
     */
    public List<Article> getInfo() {
        return getSqlSession().selectList("Article.getInfo");
    }

    /**
     * 获取成果显示
     * @return
     */
    public List<Article> getResult() {
        return getSqlSession().selectList("Article.getResult");
    }

    /**
     * 获取分类id的文章摘要
     *
     * @param categoryId
     * @param rowBounds
     * @return
     */
    @Cacheable(value = "articleDigest")
    public List<Article> findDigestByCategoryId(Long categoryId, RowBounds rowBounds) {
        return getSqlSession().selectList("Article.getDigestByCategoryId", categoryId, rowBounds);
    }

    /**
     * 获取编号为id的文章
     *
     * @param id
     * @return
     */
    @Cacheable(value = "article", key = "#id")
    public Article findOne(Long id) {
        return getSqlSession().selectOne("Article.getArticle", id);
    }

    /**
     * 获取所有文章
     *
     * @return
     */
    @Cacheable(value = "article", key = "#id")
    public List<Article> findAll(int offset, int limit) {
        Map parameters = Maps.newHashMap();
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        return getSqlSession().selectList("Article.getAllArticle", parameters);
    }

    /**
     * 获得指定月份的所有文章
     *
     * @return
     */
    @Cacheable(value = "article")
    public List<Article> findByMonth(Date month) {
        return getSqlSession().selectList("Article.getMonthArticle", month);
    }

    /**
     * 获取所有文章数量
     *
     * @return
     */
    @Cacheable(value = "article_all_num")
    public Long count() {
        return getSqlSession().selectOne("Article.getArticleCount");
    }

    /**
     * 获取categoryId分类下文章数量
     *
     * @param categoryId
     * @return
     */
    @Cacheable(value = "article_num")
    public Long count(Long categoryId) {
        return getSqlSession().selectOne("Article.getArticleCountByCategoryId", categoryId);
    }

    /**
     * 新增文章
     *
     * @param article
     * @return
     */
    public int save(Article article) {
        return getSqlSession().insert("Article.saveArticle", article);
    }

    /**
     * 批量删除文章
     *
     * @return
     */
    public int delete() {
        return getSqlSession().delete("Article.deleteArticle");
    }

    /**
     * 更新文章
     *
     * @param article
     * @return
     */
    @CacheEvict(value = "article", key = "#article.id")
    public int update(Article article) {
        return getSqlSession().update("Article.updateArticle", article);
    }

    /**
     * 更新文章
     *
     * @param id
     * @param column
     * @return
     */
    @CacheEvict(value = "article", key = "#id")
    public int update(Long id, String column) {
        Map parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Article.updateArticleBool", parameters);
    }

    /**
     * 搜索文章
     *
     * @param parameters
     * @return
     */
    @Cacheable(value = "article")
    public List<Article> search(Map<String, Object> parameters) {
        return getSqlSession().selectList("Article.searchArticle", parameters);
    }

    /**
     * 搜索文章
     *
     * @param parameters
     * @return
     */
    @Cacheable(value = "article")
    public List<Article> search(Map<String, Object> parameters, RowBounds rowBounds) {
        return getSqlSession().selectList("Article.searchArticle", parameters, rowBounds);
    }


}