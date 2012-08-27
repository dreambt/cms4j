package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Archive;
import com.google.common.collect.Maps;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

import java.util.List;
import java.util.Map;

import static junit.framework.Assert.assertEquals;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-2
 * Time: 下午6:43
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class ArchiveMapperTest extends SpringTransactionalTestCase {

    private ArchiveMapper archiveMapper;

    @Test
    public void testGet() throws Exception {
        Archive archive = archiveMapper.get(1L);
        assertEquals(2, archive.getArticleList().size());
    }

    @Test
    public void testGetIdByTitle() throws Exception {
        List<Long> ids = archiveMapper.getArticleIdByTitle("2012年03月");
        assertEquals(2, ids.size());
    }

    @Test
    public void testDelete() throws Exception {
        long num = archiveMapper.delete(1L);
        assertEquals(1, num);
    }

    @Test
    public void testSearch() throws Exception {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("id", 1);
        List<Archive> archiveList = archiveMapper.search(parameters);
        assertEquals(1, archiveList.size());
    }

    @Autowired
    public void setArchiveMapper(ArchiveMapper archiveMapper) {
        this.archiveMapper = archiveMapper;
    }

}
