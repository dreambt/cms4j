package cn.edu.sdufe.cms.schedule;

import cn.edu.sdufe.cms.common.service.account.UserManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CommentManager;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 被Spring的Quartz MethodInvokingJobDetailFactoryBean定时执行的普通Spring Bean.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-26
 * Time: 上午11:06
 */
public class DataCleanJob {

    private static Logger logger = LoggerFactory.getLogger(DataCleanJob.class);

    @Autowired
    private UserManager userManager;

    @Autowired
    private ArticleManager articleManager;

    @Autowired
    private CommentManager commentManager;

    @Autowired
    private ImageManager imageManager;

    /**
     * 定时打印当前用户数到日志.
     */
    public void execute() {
        // 查询当前系统用户数
        Long userCount = userManager.getCount();
        logger.info("######### There are {} user in database. #########", userCount);

        // 删除标记为deleted的记录
        logger.info("######### There are {} article was deleted. #########", articleManager.delete());
        logger.info("######### There are {} comment was deleted. #########", commentManager.delete());
        //logger.info("######### There are {} archive was deleted.", count);
        logger.info("######### There are {} image was deleted. #########", imageManager.delete());

        // 生成文章关键词
        //count = articleManager.genKeyword();
        //logger.info("为 {} 篇文章生成关键词.", count);
    }

}