package cn.edu.sdufe.cms.schedule;

import cn.edu.sdufe.cms.common.dao.account.UserMapper;
import cn.edu.sdufe.cms.common.dao.article.CommentMapper;
import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 被Spring的Quartz MethodInvokingJobDetailFactoryBean定时执行的普通Spring Bean.<p />
 * 将业务逻辑写在这里是因为方法级别的权限检查，导致不能调用业务逻辑层
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-26
 * Time: 上午11:06
 */
@Component
public class QuartzJob {

    private static final Logger logger = LoggerFactory.getLogger(QuartzJob.class);

    private UserMapper userMapper;
    public ArticleManager articleManager;
    private CommentMapper commentMapper;
    private ArchiveManager archiveManager;

    /**
     * 定时打印当前用户数到日志.
     */
    public void execute() {
        // 查询当前系统用户数
        logger.info("######### There are {} user in database. #########", userMapper.count());

        // 归档
        archiveManager.updateLastMonth();
        logger.info("######### Archive was ready. #########");

        // 删除标记为deleted的记录
        logger.info("######### There are {} article was deleted. #########", articleManager.deleteByTask());
        logger.info("######### There are {} comment was deleted. #########", commentMapper.deleteByTask());
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setCommentMapper(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

    @Autowired
    public void setArchiveManager(ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }

}
