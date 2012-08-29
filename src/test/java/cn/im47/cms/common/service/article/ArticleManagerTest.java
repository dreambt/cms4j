package cn.im47.cms.common.service.article;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.security.ShiroDbRealm;
import cn.im47.cms.common.data.ArticleData;
import cn.im47.cms.common.data.ShiroUserData;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.security.shiro.ShiroTestUtils;
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

    @Before
    public void setUp() throws Exception {
        ShiroDbRealm.ShiroUser user = ShiroUserData.getRandomUser();
        ShiroTestUtils.mockSubject(user);
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
