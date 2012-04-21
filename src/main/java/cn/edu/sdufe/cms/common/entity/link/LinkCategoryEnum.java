package cn.edu.sdufe.cms.common.entity.link;

import com.google.common.collect.Maps;

import java.util.Map;

/**
 * 文章显示类型枚举
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-23
 * Time: 下午00:12
 */
public enum LinkCategoryEnum {

    SERVICE("SERVICE", "服务对象"), COMPANY("COMPANY", "合作伙伴"), LINK("LINK", "友情链接");

    private static Map<String, LinkCategoryEnum> valueMap = Maps.newHashMap();

    private String value;
    private String displayName;

    static {
        for (LinkCategoryEnum linkCategory : LinkCategoryEnum.values()) {
            valueMap.put(linkCategory.value, linkCategory);
        }
    }

    LinkCategoryEnum(String value, String displayName) {
        this.value = value;
        this.displayName = displayName;
    }

    public static LinkCategoryEnum parse(String value) {
        return valueMap.get(value);
    }

    public String getValue() {
        return value;
    }

    public String getDisplayName() {
        return displayName;
    }
}