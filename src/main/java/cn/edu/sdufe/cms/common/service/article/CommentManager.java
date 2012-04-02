package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.CommentJpaDao;
import cn.edu.sdufe.cms.common.entity.article.Comment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 评论的业务逻辑
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-25
 * Time: 下午7:20
 */
@Component
@Transactional(readOnly = true)
public class CommentManager {

    private static Logger logger = LoggerFactory.getLogger(CommentManager.class);

    private CommentJpaDao commentJpaDao;

    private HttpServletRequest request;

    /**
     * 获取编号为id的评论
     *
     * @param id
     * @return
     */
    public Comment getComment(Long id) {
        return commentJpaDao.findOne(id);
    }

    /**
     * 获取所有评论
     *
     * @return
     */
    public List<Comment> getAllComment() {
        return (List<Comment>) commentJpaDao.findAll();
    }

    /**
     * 通过文章id获得评论
     *
     * @param id
     * @return
     */
    public List<Comment> getCommentByArticleId(Long id) {
        return (List<Comment>) commentJpaDao.findByArticleId(id);
    }

    /**
     * 通过用户名查找评论
     *
     * @param username
     * @return
     */
    public List<Comment> getCommentByUsername(String username) {
        return (List<Comment>) commentJpaDao.findByUsername(username);
    }

    /**
     * 获得未审核的评论
     *
     * @return
     */
    public List<Comment> getUnverifiedComment() {
        return (List<Comment>) commentJpaDao.findByStatus(false);
    }

    /**
     * 获得编号为id的文章的评论总数
     *
     * @return
     */
    public Long getCommentCount(Long id) {
        return Long.valueOf(commentJpaDao.findByArticleId(id).size());
    }

    /**
     * 新建评论
     *
     * @param comment
     * @return
     */
    @Transactional(readOnly = false)
    public Comment save(Comment comment) {
        comment.setPostHostIp(request.getRemoteAddr());   //TODO 获得ip
        comment.setStatus(false);
        comment.setDeleted(false);
        comment.setCreateTime(new Date());
        comment.setModifyTime(new Date());
        return commentJpaDao.save(comment);
    }

    /**
     * 更新评论
     *
     * @param comment
     * @return
     */
    @Transactional(readOnly = false)
    public Comment update(Comment comment) {
        comment.setModifyTime(new Date());
        return commentJpaDao.save(comment);
    }

    /**
     * 批量改变评论的审核状态
     *
     * @param ids
     * @return
     */
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        Comment comment = null;
        for (String id : ids) {
            comment = this.getComment(Long.parseLong(id));
            comment.setStatus(false);
            this.update(comment);
        }
    }

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        Comment comment = null;
        for (String id : ids) {
            comment = this.getComment(Long.parseLong(id));
            comment.setDeleted(true);
            this.update(comment);
        }
    }

    /**
     * 改变评论的删除标志
     *
     * @param comment
     * @param deleted
     * @return
     */
    @Transactional(readOnly = false)
    public Comment delete(Comment comment, boolean deleted) {
        comment.setDeleted(!deleted);
        comment.setModifyTime(new Date());
        return (Comment) commentJpaDao.save(comment);
    }

    @Autowired
    public void setCommentJpaDao(@Qualifier("commentJpaDao") CommentJpaDao commentJpaDao) {
        this.commentJpaDao = commentJpaDao;
    }

    @Autowired(required = false)
    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }
}