package cn.im47.cms.common.service.article.impl;

import cn.im47.cms.common.dao.article.CommentMapper;
import cn.im47.cms.common.entity.article.Comment;
import cn.im47.cms.common.service.article.CommentManager;
import cn.im47.cms.memcached.MemcachedObjectType;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.cache.memcached.SpyMemcachedClient;
import org.springside.modules.mapper.JsonMapper;

import java.util.Arrays;
import java.util.List;

/**
 * 评论的业务逻辑
 * User: pengfei.dongpf@gmail.com, baitao.jibt@gmail.com
 * Date: 12-3-25
 * Time: 下午7:20
 */
@Component
@Transactional(readOnly = true)
public class CommentManagerImpl implements CommentManager {

    private static final Logger logger = LoggerFactory.getLogger(CommentManager.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private CommentMapper commentMapper;

    /**
     * 获取编号为id的评论
     *
     * @param id
     * @return
     */
    public Comment get(Long id) {
        Comment comment = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.COMMENT.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            comment = commentMapper.get(id);
            jsonString = jsonMapper.toJson(comment);
            spyMemcachedClient.set(key, MemcachedObjectType.COMMENT.getExpiredTime(), jsonString);
        } else {
            comment = jsonMapper.fromJson(jsonString, Comment.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取评论 #{} 用时：{}ms. key: " + key, id, end - start);
        return comment;
    }

    @Override
    public List<Comment> getAll() {
        List<Comment> commentList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.COMMENT.getPrefix() + "all";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            commentList = commentMapper.getAll();
            jsonString = jsonMapper.toJson(commentList);
            spyMemcachedClient.set(key, MemcachedObjectType.COMMENT.getExpiredTime(), jsonString);
        } else {
            commentList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Comment.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取所有评论用时：{}ms. key: " + key, end - start);
        return commentList;
    }

    @Deprecated
    @Override
    public long count() {
        long num = 0;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.COMMENT.getPrefix() + "count";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = commentMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.COMMENT.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取评论数用时：{}ms. key: " + key, end - start);
        return num;
    }

    @Deprecated
    @Override
    public long count(Long articleId) {
        long num = 0;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.COMMENT.getPrefix() + "count:" + articleId;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = commentMapper.countByArticleId(articleId);
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.COMMENT.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取文章 {} 的评论数用时：{}ms. key: " + key, articleId, end - start);
        return num;
    }

    @Transactional(readOnly = false)
    public long save(Comment comment) {
        logger.info("保存评论 comment={}", comment.toString());
        return commentMapper.save(comment);
    }

    @Deprecated
    @Override
    @Transactional(readOnly = false)
    public long update(Comment object) {
        return 0;
    }

    @Override
    @Transactional(readOnly = false)
    public long updateBool(Long id, String column) {
        logger.info("保存评论 #{} 的 {} 属性.", id, column);
        return commentMapper.updateBool(id, column);
    }

    @Override
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        logger.info("批量更新评论 #{}.", Arrays.toString(ids));
        for (String id : ids) {
            commentMapper.updateBool(Long.parseLong(id), "status");
        }
    }

    @Override
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        logger.info("批量删除评论 #{}.", Arrays.toString(ids));
        for (String id : ids) {
            commentMapper.updateBool(Long.parseLong(id), "deleted");
        }
    }

    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除评论 #{}.", id);
        return commentMapper.delete(id);
    }

    @Transactional(readOnly = false)
    public long deleteByTask() {
        logger.info("任务删除评论.");
        return commentMapper.deleteByTask();
    }

    @Autowired
    public void setCommentMapper(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

}
