package cn.im47.cms.common.service.account.impl;

import cn.im47.cms.common.dao.account.GroupMapper;
import cn.im47.cms.common.entity.account.Group;
import cn.im47.cms.common.service.account.GroupManager;
import cn.im47.cms.memcached.MemcachedObjectType;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.cache.memcached.SpyMemcachedClient;
import org.springside.modules.mapper.JsonMapper;

import java.util.List;

/**
 * 用户 Manager 实现类
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-22
 * Time: 下午5:25
 */
@Component
@Transactional(readOnly = true)
public class GroupManagerImpl implements GroupManager {

    private static final Logger logger = LoggerFactory.getLogger(GroupManager.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private GroupMapper groupMapper;

    @Override
    public Group getGroup(Long id) {
        Group group = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.GROUP.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            group = groupMapper.get(id);
            jsonString = jsonMapper.toJson(group);
            spyMemcachedClient.set(key, MemcachedObjectType.GROUP.getExpiredTime(), jsonString);
        } else {
            group = jsonMapper.fromJson(jsonString, Group.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取用户组 #{} 用时：{}ms. key: " + key, id, end - start);
        return group;
    }

    @Override
    public List<Group> getAllGroup() {
        List<Group> groupList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.GROUP.getPrefix() + "all";
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            groupList = groupMapper.getAll();
            jsonString = jsonMapper.toJson(groupList);
            spyMemcachedClient.set(key, MemcachedObjectType.GROUP.getExpiredTime(), jsonString);
        } else {
            groupList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Group.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取所有用户组用时：{}ms. key: " + key, end - start);
        return groupList;
    }

    @Override
    public long count() {
        long num = 0;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.GROUP.getPrefix() + "count";
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            num = groupMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.GROUP.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取用户数用时：{}ms. key: " + key, end - start);
        return num;
    }

    @Autowired
    public void setGroupMapper(GroupMapper groupMapper) {
        this.groupMapper = groupMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

}
