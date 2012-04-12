package cn.edu.sdufe.cms.data;

import cn.edu.sdufe.cms.common.entity.account.Group;
import cn.edu.sdufe.cms.common.entity.account.Permission;
import cn.edu.sdufe.cms.common.entity.account.User;
import com.google.common.collect.Lists;
import org.springside.modules.test.data.RandomData;

import java.util.List;

/**
 * User相关实体测试数据生成.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午7:01
 */
public class UserData {

    private static final String UserSuffix = "User";
    private static final String DEFAULT_PASSWORD = "123456";

    private static List<Group> defaultGroupList = null;

    private static List<String> defaultPermissionList = null;

    public static User getRandomUser() {
        String username = RandomData.randomName(UserSuffix);

        User user = new User();
        user.setEmail(username + "@sdufe.edu.cn");
        user.setUsername(username);
        user.setPassword(DEFAULT_PASSWORD);
        user.setSalt("");
        user.setStatus(true);

        return user;
    }

    public static User getRandomUserWithGroup() {
        User user = getRandomUser();
        user.setGroup(getRandomDefaultGroup());
        return user;
    }

    public static Group getRandomGroup() {
        Group group = new Group();
        group.setGroupName(RandomData.randomName("Group"));
        return group;
    }

    public static Group getRandomGroupWithPermissions() {
        Group group = getRandomGroup();
        group.getPermissionList().addAll(getRandomDefaultPermissionList());
        return group;
    }

    public static List<Group> getDefaultGroupList() {
        if (defaultGroupList == null) {
            defaultGroupList = Lists.newArrayList();
            defaultGroupList.add(new Group(1L, "管理员"));
            defaultGroupList.add(new Group(2L, "用户"));
        }
        return defaultGroupList;
    }

    public static Group getRandomDefaultGroup() {
        return RandomData.randomOne(getDefaultGroupList());
    }

    public static List<String> getDefaultPermissionList() {
        if (defaultPermissionList == null) {
            defaultPermissionList = Lists.newArrayList();
            for (Permission permission : Permission.values()) {
                defaultPermissionList.add(permission.getValue());
            }
        }
        return defaultPermissionList;
    }

    public static List<String> getRandomDefaultPermissionList() {
        return RandomData.randomSome(getDefaultPermissionList());
    }
}