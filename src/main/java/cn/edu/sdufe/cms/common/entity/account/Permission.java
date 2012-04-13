package cn.edu.sdufe.cms.common.entity.account;

import com.google.common.collect.Maps;

import java.util.Map;

/**
 * 权限枚举.Resource Base Access Control中的资源定义.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:14
 */
public enum Permission {

    USER_VIEW("user:view", "查看用户"), USER_EDIT("user:edit", "修改用户"),

    GROUP_VIEW("group:view", "查看权限组"), GROUP_EDIT("group:edit", "修改权限组");

    private static Map<String, Permission> valueMap = Maps.newHashMap();

    private String value;
    private String displayName;

    static {
        for (Permission permission : Permission.values()) {
            valueMap.put(permission.value, permission);
        }
    }

    Permission(String value, String displayName) {
        this.value = value;
        this.displayName = displayName;
    }

    public static Permission parse(String value) {
        return valueMap.get(value);
    }

    public String getValue() {
        return value;
    }

    public String getDisplayName() {
        return displayName;
    }
}