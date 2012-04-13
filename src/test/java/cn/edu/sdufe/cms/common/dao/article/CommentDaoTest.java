package cn.edu.sdufe.cms.common.dao.article;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.H2Fixtures;
import org.springside.modules.test.spring.SpringTxTestCase;

/**
 * CommentDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午6:53
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
public class CommentDaoTest extends SpringTxTestCase {

    @Autowired
    private CommentDao commentDao;

    @Before
    public void setUp() throws Exception {
        //H2Fixtures.reloadAllTable(dataSource, "/data/sample-data.xml");
    }

    @Test
    public void testGetCount() throws Exception {
        Long count = commentDao.count();

        Assert.assertTrue(count > 0);
    }

}
