package cn.im47.cms.common.data;

import cn.im47.cms.security.ShiroDbRealm;
import org.springside.modules.test.data.RandomData;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-27
 * Time: 下午9:41
 */
public class ShiroUserData {

    private static final String UserSuffix = "User";

    public static ShiroDbRealm.ShiroUser getRandomUser() {
        String username = RandomData.randomName(UserSuffix);

        ShiroDbRealm.ShiroUser user = new ShiroDbRealm.ShiroUser(1L, "dreambt@126.com", username, "无分组");
        return user;
    }

}
