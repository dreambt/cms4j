package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.agency.Agency;
import org.apache.ibatis.io.Resources;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-24
 * Time: 上午11:38
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class AgencyDaoTest {

    @Autowired
    private AgencyDao agencyDao;

    @Before
    public void setUp() throws Exception {
        agencyDao = new AgencyDao();
    }

    @Test
    public void testGetAgency() throws Exception {
        Agency agency = agencyDao.getAgency(1L);
        System.out.println(agency.getTitle());
    }
}
