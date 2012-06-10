package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.data.ArticleData;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * ArticleDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午6:44
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
public class ArticleMapperTest extends SpringTransactionalTestCase {

    @Autowired
    private ArticleMapper articleMapper;

    @Before
    public void setUp() throws Exception {
        DataFixtures.reloadData(dataSource, "/data/sample-data.xml");
    }

    @Test
    public void crudEntityWithArticle() throws Exception {
        //新建并保存带权限组的用户
        Article article = ArticleData.getRandomArticle();
        Assert.assertEquals(1, articleMapper.update(article));

        // 获取

    }
}