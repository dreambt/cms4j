package cn.im47.cms.common.dao.article;

import cn.im47.cms.common.data.ArticleData;
import cn.im47.cms.common.entity.article.Article;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * ArticleDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午6:44
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class ArticleMapperTest extends SpringTransactionalTestCase {

    @Autowired
    private ArticleMapper articleMapper;

    @Test
    public void crudEntityWithArticle() throws Exception {
        //新建并保存带权限组的用户
        Article article = ArticleData.getRandomArticle();
        Assert.assertEquals(1, articleMapper.update(article));

        // 获取

    }

}
