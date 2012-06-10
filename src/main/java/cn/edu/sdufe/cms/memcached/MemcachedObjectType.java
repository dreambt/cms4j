package cn.edu.sdufe.cms.memcached;

/**
 * 统一定义Memcached中存储的各种对象的Key前缀和超时时间.
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-12
 * Time: 下午14:48
 */
public enum MemcachedObjectType {

    USER("user:", 60 * 1 * 1),
    GROUP("group:", 60 * 1 * 1),
    ARTICLE("article:", 60 * 24 * 7),
    ARCHIVE("archive:", 60 * 24 * 7),
    COMMENT("comment:", 60 * 24 * 1),
    CATEGORY("category:", 60 * 24 * 7),
    LINK("link:", 60 * 24 * 7),
    IMAGE("inage:", 60 * 24 * 1);

    private String prefix;
    private int expiredTime;

    MemcachedObjectType(String prefix, int expiredTime) {
        this.prefix = prefix;
        this.expiredTime = expiredTime;
    }

    public String getPrefix() {
        return prefix;
    }

    public int getExpiredTime() {
        return expiredTime;
    }

}
