package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.data.AgencyData;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springside.modules.test.data.Fixtures;
import org.springside.modules.test.spring.SpringTxTestCase;

import java.util.List;

/**
 * 组织机构测试类
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-24
 * Time: 上午11:38
 */
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml"})
public class AgencyDaoTest extends SpringTxTestCase {

    @Autowired
    private AgencyDao agencyDao;
    private Agency agency;

    @Before
    public void setUp() throws Exception {
        Fixtures.reloadData(dataSource, "/data/sample-data.xml");
    }

    @Test
    public void testGetAgency() {
        Agency agency = agencyDao.getAgency(1L);
        Assert.assertEquals("research", agency.getTitle());
    }

    @Test
    public void testGetAllAgency() {
        List<Agency> agencies = agencyDao.getAllAgency();
        Assert.assertEquals(2, agencies.size());
    }

    @Test
    public void testSave() {
        agency = AgencyData.getRandomAgency();
        int result = agencyDao.save(agency);
        Assert.assertEquals(1, result);
    }

    @Test
    public void testDeleteAgency() {
        int result = agencyDao.deleteAgency();
        Assert.assertEquals(1, result);
    }

    @Test
    public void testUpdateAgency() {
        agency = agencyDao.getAgency(1L);
        agency.setTitle("b");
        int result = agencyDao.updateAgency(agency);
        Assert.assertEquals(1, result);
        agency = agencyDao.getAgency(1L);
        Assert.assertEquals("b", agency.getTitle());
    }
}
