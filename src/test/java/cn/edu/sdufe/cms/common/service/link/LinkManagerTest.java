package cn.edu.sdufe.cms.common.service.link;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-27
 * Time: 下午4:32
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class LinkManagerTest extends SpringTransactionalTestCase {

    @Autowired
    private LinkManager linkManager;

    @Test
    public void testCount() throws Exception {

    }

    @Test
    public void testGetAll() throws Exception {

    }

    @Test
    public void testGet() throws Exception {

    }

    @Test
    public void testSave() throws Exception {

    }

    @Test
    public void testUpdate() throws Exception {

    }

    @Test
    public void testUpdateBool() throws Exception {

    }

    @Test
    public void testDelete() throws Exception {

    }

}
