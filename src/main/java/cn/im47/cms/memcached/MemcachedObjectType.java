package cn.im47.cms.memcached;

/**
 * 统一定义Memcached中存储的各种对象的Key前缀和超时时间.
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-12
 * Time: 下午14:48
 */
public enum MemcachedObjectType {

    // 时间单位：s
    USER("user:", 60 * 60 * 1),
    GROUP("group:", 60 * 60 * 1),
    ARTICLE("article:", 60 * 60 * 24),
    ARCHIVE("archive:", 60 * 60 * 24),
    CATEGORY("category:", 60 * 60 * 24),
    LINK("link:", 60 * 1 * 1),
    IMAGE("image:", 60 * 60 * 24);

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
