package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertNotNull;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-27
 * Time: 下午4:37
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class CategoryManagerTest extends SpringTransactionalTestCase {

    @Autowired
    private CategoryManager categoryManager;

    @Test
    public void testGet() throws Exception {

    }

    @Test
    public void testGetSubCategory() throws Exception {

    }

    @Test
    public void testGetNavCategory() throws Exception {

    }

    @Test
    public void testGetAllowPublishCategory() throws Exception {

    }

    @Test
    public void testCount() throws Exception {

    }

    @Test
    public void testSave() throws Exception {

    }

    @Test
    public void testUpdate() throws Exception {
        Category category = categoryManager.get(1L);
        assertNotNull(category);
        category.setAllowComment(false);
        assertEquals(1, categoryManager.update(category));
    }

    @Test
    public void testDelete() throws Exception {

    }

}
