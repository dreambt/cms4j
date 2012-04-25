package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
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
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-24
 * Time: 上午11:38
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml"})
public class AgencyDaoTest extends SpringTxTestCase {

    @Autowired
    private AgencyDao agencyDao;
    private Agency agency1 = new Agency();
    private Agency agency2 = new Agency();

    @Before
    public void setUp() throws Exception {
        Fixtures.reloadData(dataSource, "/data/sample-data.xml");

        agency1.setTitle("a");
        agency1.setCategoryId(100);
        agency1.setImageUrl("a.jpg");
        agency1.setIntroduction("a");
    }

    @Test
    public void testGetAgency() {
        Agency agency = agencyDao.getAgency(1L);
        Assert.assertEquals("research", agency.getTitle());
    }

    @Test
    public void testGetAllAgency() {
        List<Agency> agencies = agencyDao.getAllAgency();
        for (Agency agency : agencies) {
            System.out.println(agency.getTitle());
        }
    }

    @Test
    @Rollback(value = false)
    public void testSave() {
        int result = agencyDao.save(agency1);
        Assert.assertEquals(1, result);
    }

    @Test
    public void testDeleteAgency() {
        int result = agencyDao.deleteAgency(8L);
        System.out.println(result);
    }

    @Test
    @Rollback(false)
    public void testUpdateAgency() {
        int result1 = agencyDao.save(agency1);
        System.out.println(result1);
        agency2 = agencyDao.getAgency(7L);
        agency2.setTitle("b");
        int result = agencyDao.updateAgency(agency2);
        System.out.println(result);
    }
}
