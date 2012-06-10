package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.article.Article;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 文章Dao
 * User: baitao.jibt@gmail.com
 * Date: 12-3-20
 * Time: 下午18:34
 */
public interface ArticleMapper extends GenericDao<Article, Long> {

    /**
     * 获得所有文章
     *
     * @return
     */
    List<Article> getAll(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    List<Article> getTopTen();

    /**
     * 获取分类ids的文章标题
     *
     * @return
     */
    List<Article> getTitleByCategoryIds(Long[] ids);

    /**
     * 获取分类id的文章列表
     *
     * @param categoryId
     * @param offset
     * @param limit
     * @return
     */
    List<Article> getByCategoryId(@Param("categoryId") Long categoryId, @Param("offset") int offset, @Param("limit") int limit);

    /**
     * 根据归档编号获得文章
     *
     * @param archiveId
     * @param offset
     * @param limit
     * @return
     */
    List<Article> getByArchiveId(@Param("archiveId") Long archiveId, @Param("offset") int offset, @Param("limit") int limit);

    /**
     * 根据归档编号获得文章编号
     *
     * @param startDate
     * @param endDate
     * @return
     */
    List<Long> getIdByMonth(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    /**
     * 获得指定月份的所有文章
     *
     * @return
     */
    List<Article> getByMonth(Date month);

    /**
     * 获取删除标记为真的文章
     *
     * @return
     */
    List<Article> getDeleted();

    /**
     * 获取categoryId分类下文章数量
     *
     * @param categoryId
     * @return
     */
    Long countByCategoryId(Long categoryId);

    /**
     * 更新文章views字段
     *
     * @param id
     * @return
     */
    int updateViews(Long id);

    int deleteByTask();

}