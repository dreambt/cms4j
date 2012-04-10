package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.CommentDao;
import cn.edu.sdufe.cms.common.entity.article.Comment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

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

    private CommentDao commentDao;

    /**
     * 获取编号为id的评论
     *
     * @param id
     * @return
     */
    public Comment get(Long id) {
        return commentDao.findOne(id);
    }

    /**
     * 获取所有评论
     *
     * @return
     */
    public List<Comment> getAll() {
        return (List<Comment>) commentDao.findAll();
    }

    /**
     * 通过文章id获得评论
     *
     * @param id
     * @return
     */
    public List<Comment> getByArticleId(Long id) {
        return commentDao.findByArticleId(id);
    }

    /**
     * 通过用户名查找评论
     *
     * @param username
     * @return
     */
    public List<Comment> getByUsername(String username) {
        return commentDao.findByUsername(username);
    }

    /**
     * 获得未审核的评论
     *
     * @return
     */
    public List<Comment> getUnverifiedComment() {
        return commentDao.findByStatus(false);
    }

    /**
     * 获得编号为id的文章的评论总数
     *
     * @return
     */
    public Long count(Long id) {
        return commentDao.count(id);
    }

    /**
     * 新建评论
     *
     * @param comment
     * @return
     */
    @Transactional(readOnly = false)
    public Comment save(Comment comment) {
        comment.setStatus(false);
        comment.setDeleted(false);
        return this.update(comment);
    }

    /**
     * 更新评论
     *
     * @param comment
     * @return
     */
    @Transactional(readOnly = false)
    public Comment update(Comment comment) {
        comment.setLastModifiedDate(null);
        return commentDao.save(comment);
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
            comment = this.get(Long.parseLong(id));
            comment.setStatus(true);
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
            comment = this.get(Long.parseLong(id));
            comment.setDeleted(true);
            this.update(comment);
        }
    }

    /**
     * 任务删除评论
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() {
        List<Long> commentList = commentDao.getDeletedId();
        int count = commentList.size();
        while (commentList.size() > 0) {
            try {
                commentDao.delete(commentList.remove(0));
            } catch (Exception e) {
                logger.info("在批量删除评论时发生异常.");
            }
        }
        return count;
    }

    @Autowired
    public void setCommentDao(@Qualifier("commentDao") CommentDao commentDao) {
        this.commentDao = commentDao;
    }

}