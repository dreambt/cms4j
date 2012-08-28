package cn.im47.cms.common.dao.article;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.article.Comment;

import java.util.List;

/**
 * 评论Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:37
 */
public interface CommentMapper extends GenericDao<Comment, Long> {

    List<Comment> getAll();

    /**
     * 获得最近10条评论
     *
     * @return
     */
    List<Comment> getRecentComment();

    /**
     * 获取编号为id的文章的评论数量
     *
     * @param articleId
     * @return
     */
    Long countByArticleId(Long articleId);

    int deleteByTask();

}