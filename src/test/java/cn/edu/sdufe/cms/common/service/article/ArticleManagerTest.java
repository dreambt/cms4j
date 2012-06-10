package cn.edu.sdufe.cms.common.service.article;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

import static junit.framework.Assert.assertEquals;

/**
 * 文章 Manager 的测试类
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-3
 * Time: 上午9:11
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class ArticleManagerTest extends SpringTransactionalTestCase {

    @Autowired
    private ArticleManager articleManager;

    @Test
    public void testDeleteByTask() throws Exception {
        int num = articleManager.deleteByTask();
        assertEquals(1, num);
    }

}
