package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.data.UserData;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * UserDao的测试用例, 测试ORM映射及特殊的DAO操作. 默认在每个测试函数后进行回滚.
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午7:01
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
public class UserMapperTest extends SpringTransactionalTestCase {

    @Autowired
    private UserMapper userMapper = null;

    private User user = null;

    @Before
    public void setUp() throws Exception {
        DataFixtures.reloadData(dataSource, "/data/sample-data.xml");
        user = UserData.getRandomUserWithGroup();
    }

    @Test
    public void getUser() throws Exception {
        // 获取
        Assert.assertEquals("dreambt@126.com", userMapper.get(1L).getEmail());
    }

    @Test
    public void saveUser() throws Exception {
        //新建并保存带权限组的用户
        Assert.assertEquals(1, userMapper.save(user));

        // 获取
        Assert.assertEquals(user.getEmail(), userMapper.get(user.getId()).getEmail());
    }

    @Test
    public void updateUser() throws Exception {
        //更新用户
        user = userMapper.get(2L);
        user.setUsername("baitao.jibt");
        Assert.assertEquals(1, userMapper.update(user));

        // 获取
        Assert.assertEquals(user.getUsername(), userMapper.get(user.getId()).getUsername());
    }
}
