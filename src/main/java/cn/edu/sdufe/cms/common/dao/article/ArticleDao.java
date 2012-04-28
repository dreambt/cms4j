package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import com.google.common.collect.Maps;
import org.mybatis.spring.support.SqlSessionDaoSupport;
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
    public List<Article> findTopTen() {
        return getSqlSession().selectList("Article.getTopTenArticle");
    }

    /**
     * 获取分类id的文章标题
     *
     * @param categoryId
     * @param offset
     * @param limit
     * @return
     */
    public List<Article> findTitleByCategoryId(Long categoryId, int offset, int limit) {
        Map parameters = Maps.newHashMap();
        parameters.put("categoryId", categoryId);
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        return getSqlSession().selectList("Article.getTitleByCategoryId", parameters);
    }

    /**
     * 获取分类ids的文章标题
     *
     * @return
     */
    public List<Article> findTitleByCategoryId(Long[] ids) {
        return getSqlSession().selectList("Article.getTitleByCategoryIds", ids);
    }

    /**
     * 获取分类id的文章列表
     *
     * @param categoryId
     * @param offset
     * @param limit
     * @return
     */
    public List<Article> findByCategoryId(Long categoryId, int offset, int limit) {
        Map parameters = Maps.newHashMap();
        parameters.put("categoryId", categoryId);
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        return getSqlSession().selectList("Article.findByCategoryId", parameters);
    }

    /**
     * 获取编号为id的文章
     *
     * @param id
     * @return
     */
    public Article findOne(Long id) {
        return getSqlSession().selectOne("Article.getArticle", id);
    }

    /**
     * 获取所有文章
     *
     * @return
     */
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
    public List<Article> findByMonth(Date month) {
        return getSqlSession().selectList("Article.getMonthArticle", month);
    }

    /**
     * 获取所有文章数量
     *
     * @return
     */
    public Long count() {
        return getSqlSession().selectOne("Article.getArticleCount");
    }

    /**
     * 获取删除标记为真的文章
     * @return
     */
    public List<Long> findDeletedArticle() {
            return getSqlSession().selectList("Article.getDeletedArticle");
    }

    /**
     * 获取categoryId分类下文章数量
     *
     * @param categoryId
     * @return
     */
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
    public int update(Article article) {
        return getSqlSession().update("Article.updateArticle", article);
    }

    /**
     * 更新文章Bool字段
     *
     * @param id
     * @param column
     * @return
     */
    public int update(Long id, String column) {
        Map parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Article.updateArticleBool", parameters);
    }

    /**
     * 更新文章views字段
     *
     * @param id
     * @return
     */
    public int update(Long id) {
        return getSqlSession().update("Article.updateArticleViews", id);
    }

    /**
     * 搜索文章
     *
     * @param parameters
     * @return
     */
    public List<Article> search(Map<String, Object> parameters) {
        return this.search(parameters, 0, 10);
    }

    /**
     * 搜索文章
     *
     * @param parameters
     * @return
     */
    public List<Article> search(Map<String, Object> parameters, int offset, int limit) {
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        return getSqlSession().selectList("Article.searchArticle", parameters);
    }

}