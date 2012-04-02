package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * 评论 JPA DAO
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-25
 * Time: 下午6:12
 */
public interface CommentJpaDao extends PagingAndSortingRepository<Comment, Long> {

    /**
     * 通过文章id查找评论
     *
     * @param id
     * @return
     */
    List<Comment> findByArticleId(Long id);

    /**
     * 通过用户名查找评论
     *
     * @param userName
     * @return
     */
    List<Comment> findByUsername(String userName);

    /**
     * 通过评论是否审核查找评论
     *
     * @param status
     * @return
     */
    List<Comment> findByStatus(boolean status);

    /**
     * 通过是否标记为删除查找评论
     *
     * @param deleted
     * @return
     */
    List<Comment> findByDeleted(boolean deleted);

}
