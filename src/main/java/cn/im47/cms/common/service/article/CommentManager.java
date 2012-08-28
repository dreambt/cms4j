package cn.im47.cms.common.service.article;

import cn.im47.cms.common.entity.article.Comment;
import cn.im47.cms.common.service.GenericManager;

import java.util.List;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-12
 * Time: 下午3:36
 */
public interface CommentManager extends GenericManager<Comment, Long> {

    /**
     * 获取所有评论
     *
     * @return
     */
    List<Comment> getAll();

    long count();

    /**
     * 获得编号为id的文章的评论总数
     *
     * @param articleId
     * @return
     */
    long count(Long articleId);

    /**
     * 更新评论
     *
     * @param id
     * @param column
     * @return
     */
    long updateBool(Long id, String column);

    /**
     * 批量改变评论的审核状态
     *
     * @param ids
     * @return
     */
    void batchAudit(String[] ids);

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    void batchDelete(String[] ids);

    long deleteByTask();

}
