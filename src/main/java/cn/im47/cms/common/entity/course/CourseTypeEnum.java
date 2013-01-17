package cn.im47.cms.common.entity.course;

import com.google.common.collect.Maps;

import java.util.Map;

/**
 * 课程类型枚举
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-23
 * Time: 下午00:12
 */
public enum CourseTypeEnum {

    NONE("NONE", "无效"), ORDER("ORDER", "可预定"),

    FULL("FULL", "已满"), CLOSE("CLOSE", "已开课");

    private static Map<String, CourseTypeEnum> valueMap = Maps.newHashMap();
    private static Map<String, String> map = Maps.newHashMap();

    private String value;
    private String displayName;

    static {
        for (CourseTypeEnum showType : CourseTypeEnum.values()) {
            valueMap.put(showType.value, showType);
            map.put(showType.value, showType.displayName);
        }
    }

    CourseTypeEnum(String value, String displayName) {
        this.value = value;
        this.displayName = displayName;
    }

    public static CourseTypeEnum parse(String value) {
        return valueMap.get(value);
    }

    public String getValue() {
        return value;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static Map<String, String> getAll(){
        return map;
    }
}
