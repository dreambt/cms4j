package cn.im47.sdufe.common.data;

import cn.im47.cms.common.entity.account.Group;
import cn.im47.cms.common.entity.account.Permission;
import cn.im47.cms.common.entity.account.User;
import com.google.common.collect.Lists;
import org.joda.time.LocalDateTime;
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
        user.setId(RandomData.randomId() & 0xFF);
        user.setEmail(username + "@sdufe.edu.cn");
        user.setUsername(username);
        user.setPassword(DEFAULT_PASSWORD);
        user.setSalt(RandomData.randomName(UserSuffix));
        user.setStatus(true);
        user.setPhotoURL("1.jpg");
        user.setTimeOffset("0800");
        user.setLastIP(134744072L);
        LocalDateTime now = new LocalDateTime();
        user.setLastTime(now);
        user.setLastActTime(now);
        return user;
    }

    public static User getRandomUserWithGroup() {
        User user = getRandomUser();
        user.setGroupList(getRandomDefaultGroup());
        return user;
    }

    public static Group getRandomGroup() {
        Group group = new Group();
        group.setGroupName(RandomData.randomName("Group"));
        return group;
    }

    public static List<Group> getRandomGroupWithPermissions() {
        List<Group> groupList = Lists.newArrayList();
        Group group = getRandomGroup();
        group.getPermissionList().addAll(getRandomDefaultPermissionList());
        groupList.add(group);
        return groupList;
    }

    public static List<Group> getDefaultGroupList() {
        if (defaultGroupList == null) {
            defaultGroupList = Lists.newArrayList();
            defaultGroupList.add(new Group(1L, "管理员"));
            defaultGroupList.add(new Group(2L, "用户"));
        }
        return defaultGroupList;
    }

    public static List<Group> getRandomDefaultGroup() {
        return RandomData.randomSome(getDefaultGroupList());
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