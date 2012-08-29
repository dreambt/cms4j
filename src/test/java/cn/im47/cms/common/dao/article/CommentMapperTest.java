package cn.im47.cms.common.dao.article;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * CommentDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午6:53
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
public class CommentMapperTest extends SpringTransactionalTestCase {

    private static Logger logger = LoggerFactory.getLogger(CommentMapperTest.class);

    @Autowired
    private CommentMapper commentMapper;

    @Before
    public void setUp() throws Exception {
        DataFixtures.executeScript(dataSource, "/data/import-data.sql");
    }

    @Test
    public void testGetCount() throws Exception {
        Long count = commentMapper.count();
        logger.info("Comment count: {}", count);
        Assert.assertTrue(count > 0);
    }

}
