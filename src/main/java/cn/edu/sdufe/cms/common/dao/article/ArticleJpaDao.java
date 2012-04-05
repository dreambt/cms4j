package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import org.springframework.data.repository.PagingAndSortingRepository;

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
     * 通过作者userId查找
     *
     * @param userId
     * @return
     */
    Article findByUserId(Long userId);

    /**
     * 通过删除标记查找
     *
     * @return
     */
    List<Article> findByDeleted(boolean deleted);

}