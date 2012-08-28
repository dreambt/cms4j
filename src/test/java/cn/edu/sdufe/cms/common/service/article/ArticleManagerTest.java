package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.data.ArticleData;
import cn.edu.sdufe.cms.data.ShiroUserData;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;
import org.springside.modules.test.support.ShiroTestHelper;

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

    @Before
    public void setUp() throws Exception {
        ShiroDbRealm.ShiroUser user = ShiroUserData.getRandomUser();
        ShiroTestHelper.mockSubject(user);
    }

    @Test
    public void testSave() throws Exception {
        Article article = ArticleData.getRandomArticle();
        assertEquals(1, articleManager.save(article));
    }

    @Test
    public void testDeleteByTask() throws Exception {
        int num = articleManager.deleteByTask();
        assertEquals(1, num);
    }

}
