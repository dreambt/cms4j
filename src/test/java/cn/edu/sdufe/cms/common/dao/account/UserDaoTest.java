package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.data.UserData;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.Fixtures;
import org.springside.modules.test.spring.SpringTxTestCase;

/**
 * UserDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午7:01
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
public class UserDaoTest extends SpringTxTestCase {

    @Autowired
    private UserDao userDao;

    @Before
    public void setUp() throws Exception {
        Fixtures.reloadData(dataSource, "/data/sample-data.xml");
    }

    @Test
    public void crudEntityWithUser() throws Exception {
        //新建并保存带权限组的用户
        User user = UserData.getRandomUserWithGroup();
        Assert.assertEquals(1, userDao.save(user));

        Assert.assertEquals(1, userDao.update(user));

        // 获取
        Assert.assertEquals(user.getEmail(), userDao.findOne(1L).getEmail());
    }
}
