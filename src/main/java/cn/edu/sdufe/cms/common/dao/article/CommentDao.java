package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

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
    /*@Cacheable(value = "commentRecent")
    public List<Comment> getRecentComment() {
        return (List<Comment>)getSqlSession().selectList("Article.getCommentRecent");
    }*/

    /**
     * 获取评论数量
     *
     * @return
     */
    @Cacheable(value = "commentCount")
    public Long count() {
        return (Long) getSqlSession().selectOne("Article.getCount");
    }

    /**
     * 获取编号为id的文章的评论数量
     *
     * @return
     */
    public Long count(Long id) {
        return (Long) getSqlSession().selectOne("Article.getCountByArticleId", id);
    }

    /**
     * 搜索评论
     *
     * @param parameters
     * @return
     */
    public Comment search(Map<String, Object> parameters) {
        return (Comment) getSqlSession().selectOne("Article.searchComment", parameters);
    }

}