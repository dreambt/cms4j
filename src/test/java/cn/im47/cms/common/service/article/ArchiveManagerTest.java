package cn.im47.cms.common.service.article;

import cn.im47.cms.common.entity.article.Archive;
import org.joda.time.DateTime;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

import java.util.List;

import static junit.framework.Assert.assertEquals;

/**
 * 归类业务逻辑层测试类
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-2
 * Time: 下午6:33
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class ArchiveManagerTest extends SpringTransactionalTestCase {

    @Autowired
    private ArchiveManager archiveManager;

    // 更新已生成过归档的日志
    @Test
    public void testSave() throws Exception {
        long num = archiveManager.updateByMonth(new DateTime("2012-03-01T00:00:00"));
        assertEquals(1, num);

        Archive archive = archiveManager.get(1L);
        num = archive.getArticleList().size();
        assertEquals(3, num);
    }

    // 生成新归档
    @Test
    public void testSave1() throws Exception {
        long num = archiveManager.updateByMonth(new DateTime("2012-06-01T00:00:00"));
        assertEquals(1, num);

        Archive archive = archiveManager.get(2L);
        num = archive.getArticleList().size();
        assertEquals(1, num);
    }

    @Test
    public void testGetTopTen() throws Exception {
        List<Archive> archiveList = archiveManager.getTop(10);
        assertEquals(1, archiveList.size());
    }

    @Test
    public void testUpdateByMonth() throws Exception {
        long num = archiveManager.updateByMonth(new DateTime("2012-03-01T00:00:00"));
        assertEquals(1, num);

        Archive archive = archiveManager.get(1L);
        num = archive.getArticleList().size();
        assertEquals(3, num);
    }

}
