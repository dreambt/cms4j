package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 评论Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:37
 */
@Component
public class CommentDao extends SqlSessionDaoSupport {

    /**
     * 获得最近10条评论
     *
     * @return
     */
    @Cacheable(value = "commentRecent")
    public List<Comment> getRecentComment() {
        return getSqlSession().selectList("Comment.getCommentRecent");
    }

    /**
     * 获取评论数量
     *
     * @return
     */
    @Cacheable(value = "commentCount")
    public Long count() {
        return (Long) getSqlSession().selectOne("Comment.getCount");
    }

    /**
     * 获取标记为删除的评论id
     *
     * @return
     */
    public List<Long> getDeletedId() {
        return getSqlSession().selectList("Comment.getDeletedCommentId");
    }

    /**
     * 获取编号为id的文章的评论数量
     *
     * @return
     */
    public Long count(Long id) {
        return (Long) getSqlSession().selectOne("Comment.getCountByArticleId", id);
    }

    /**
     * 搜索评论
     *
     * @param parameters
     * @return
     */
    public List<Comment> search(Map<String, Object> parameters) {
        return getSqlSession().selectOne("Comment.searchComment", parameters);
    }

}