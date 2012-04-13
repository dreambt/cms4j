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
        return commentDao.findAll();
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
    public int save(Comment comment) {
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
    public int update(Comment comment) {
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
        return commentDao.delete();
    }

    @Autowired
    public void setCommentDao(@Qualifier("commentDao") CommentDao commentDao) {
        this.commentDao = commentDao;
    }

}