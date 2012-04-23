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

    private static final Logger logger = LoggerFactory.getLogger(CommentManager.class);

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
        return commentDao.findAll();
    }

    /**
     * 获得评论总数
     *
     * @return
     */
    public Long count() {
        return commentDao.count();
    }

    /**
     * 获得编号为id的文章的评论总数
     *
     * @param articleId
     * @return
     */
    public Long count(Long articleId) {
        return commentDao.count(articleId);
    }

    /**
     * 新建评论
     *
     * @param comment
     * @return
     */
    @Transactional(readOnly = false)
    public int save(Comment comment) {
        logger.info("New Comment: ", comment.toString());
        return commentDao.save(comment);
    }

    /**
     * 更新评论
     *
     * @param id
     * @param column
     * @return
     */
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        logger.info("Update Comment: ", id + column);
        return commentDao.update(id, column);
    }

    /**
     * 批量改变评论的审核状态
     *
     * @param ids
     * @return
     */
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        for (String id : ids) {
            commentDao.update(Long.parseLong(id), "status");
            logger.info("Update Comment: id={}, column=status.", Long.parseLong(id));
        }
    }

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            commentDao.update(Long.parseLong(id), "deleted");
            logger.info("Update Comment: id={}, column=deleted.", Long.parseLong(id));
        }
    }

    /**
     * 任务删除评论
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() {
        return commentDao.delete();
    }

    @Autowired
    public void setCommentDao(@Qualifier("commentDao") CommentDao commentDao) {
        this.commentDao = commentDao;
    }

}