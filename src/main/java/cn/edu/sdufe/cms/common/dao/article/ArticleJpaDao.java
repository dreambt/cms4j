package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Date;
import java.util.List;

/**
 * 文章 JPA Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午3:55
 */
public interface ArticleJpaDao extends PagingAndSortingRepository<Article, Long> {

    /**
     * 通过作者userId查找文章
     *
     * @param userId
     * @return
     */
    Article findByUserId(Long userId);

    /**
     * 查找置顶文章
     *
     * @param top
     * @return
     */
    Article findByTop(boolean top);

    /**
     * 查找满足审核状态的文章
     *
     * @param status
     * @return
     */
    Article findByStatus(boolean status);

    /**
     * 获得某一时间段的所有文章
     *
     * @param start
     * @param end
     * @return
     */
    List<Article> findByCreateTimeBetween(Date start, Date end);

}