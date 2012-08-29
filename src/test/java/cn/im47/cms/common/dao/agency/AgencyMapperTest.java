package cn.im47.cms.common.dao.agency;

import cn.im47.cms.common.entity.agency.Agency;
import cn.im47.cms.common.data.AgencyData;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

import java.util.List;

/**
 * 组织机构测试类
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-24
 * Time: 上午11:38
 */
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml"})
public class AgencyMapperTest extends SpringTransactionalTestCase {

    @Autowired
    private AgencyMapper agencyMapper;
    private Agency agency;

    @Before
    public void setUp() throws Exception {
        DataFixtures.executeScript(dataSource, "/data/import-data.sql");
    }

    @Test
    public void testGetAgency() {
        Agency agency = agencyMapper.get(1L);
        Assert.assertEquals("research", agency.getTitle());
    }

    @Test
    public void testGetAllAgency() {
        List<Agency> agencies = agencyMapper.getAll();
        Assert.assertEquals(2, agencies.size());
    }

    @Test
    public void testSave() {
        agency = AgencyData.getRandomAgency();
        long result = agencyMapper.save(agency);
        Assert.assertEquals(1, result);
    }

    @Test
    public void testDeleteAgency() {
        long result = agencyMapper.delete(1L);
        Assert.assertEquals(1, result);
    }

    @Test
    public void testUpdateAgency() {
        agency = agencyMapper.get(1L);
        agency.setTitle("b");
        long result = agencyMapper.update(agency);
        Assert.assertEquals(1, result);
        agency = agencyMapper.get(1L);
        Assert.assertEquals("b", agency.getTitle());
    }
}
