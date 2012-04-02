package cn.edu.sdufe.cms.schedule;

import cn.edu.sdufe.cms.common.service.account.UserManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 被Spring的Quartz MethodInvokingJobDetailFactoryBean定时执行的普通Spring Bean.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-26
 * Time: 上午11:06
 */
public class QuartzJob {

    private static Logger logger = LoggerFactory.getLogger(QuartzJob.class);

    @Autowired
    private UserManager userManager;

    //private ArticleManager articleManager;

    /**
     * 定时打印当前用户数到日志.
     */
    public void execute() {
        // 查询当前系统用户数
        Long userCount = userManager.getUserCount();
        logger.info("There are {} user in database, printed by quartz local job.", userCount);

        // 删除标记为deleted的记录
        //int count = articleManager.deleteArticle();
        //logger.info("There are {} article delete, printed by quartz local job.", count);

        // 生成文章关键词
        //count = articleManager.genKeyword();
        //logger.info("为 {} 篇文章生成关键词.", count);
    }

}