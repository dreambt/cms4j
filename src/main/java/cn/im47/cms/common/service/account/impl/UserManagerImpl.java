package cn.im47.cms.common.service.account.impl;

import cn.im47.cms.common.dao.account.UserMapper;
import cn.im47.cms.common.entity.account.User;
import cn.im47.cms.common.service.ServiceException;
import cn.im47.cms.common.service.account.ShiroDbRealm;
import cn.im47.cms.common.service.account.UserManager;
import cn.im47.cms.jms.NotifyMessageProducer;
import cn.im47.cms.memcached.MemcachedObjectType;
import cn.im47.commons.utilities.RandomString;
import com.google.common.collect.Lists;
import org.apache.shiro.SecurityUtils;
import org.joda.time.LocalDateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.cache.memcached.SpyMemcachedClient;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Encodes;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 安全相关实体的管理类,包括用户和权限组.
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-22
 * Time: 下午5:25
 */
@Component
@Transactional(readOnly = true)
public class UserManagerImpl implements UserManager {

    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    private static final int SALT_SIZE = 8;

    private static final Logger logger = LoggerFactory.getLogger(UserManager.class);

    private UserMapper userMapper;

    private JsonMapper jsonMapper = JsonMapper.nonEmptyMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    @Value("${paged.user.limit}")
    public int userLimit;

    @Override
    public User get(Long id) {
        User user = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.USER.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            user = userMapper.get(id);
            jsonString = jsonMapper.toJson(user);
            spyMemcachedClient.set(key, MemcachedObjectType.USER.getExpiredTime(), jsonString);
        } else {
            user = jsonMapper.fromJson(jsonString, User.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取用户 #{} 用时：{}ms. key: " + key, id, end - start);
        return user;
    }

    @Override
    public List<User> getAll(int offset, int limit, String sort, String direction) {
        List<User> userList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.USER.getPrefix() + "all:" + offset + ":" + limit + ":" + sort + ":" + direction;
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            userList = userMapper.getAll(offset, limit, sort, direction);
            jsonString = jsonMapper.toJson(userList);
            spyMemcachedClient.set(key, MemcachedObjectType.USER.getExpiredTime(), jsonString);
        } else {
            userList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, User.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取所有用户 用时：{}ms. key: " + key, end - start);
        return userList;
    }

    @Override
    public User findUserByEmail(String email) {
        User user = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.USER.getPrefix() + "email:" + email;
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            user = userMapper.getByEmail(email);
            jsonString = jsonMapper.toJson(user);
            spyMemcachedClient.set(key, MemcachedObjectType.USER.getExpiredTime(), jsonString);
        } else {
            user = jsonMapper.fromJson(jsonString, User.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取用户 user.email={} 用时：{}ms. key: " + key, email, end - start);
        return user;
    }

    @Override
    public long count() {
        long num = 0;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.USER.getPrefix() + "count";
        String jsonString = spyMemcachedClient.get(key);

        if (org.apache.commons.lang3.StringUtils.isBlank(jsonString)) {
            num = userMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.USER.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取用户数 用时：{}ms. key: " + key, end - start);
        return num;
    }

    @Transactional(readOnly = false)
    public int save(User user) {
        //如果邮箱被注册，将直接返回
        if (userMapper.isUsedEmail(user.getEmail()) > 0) {
            return 0;
        }

        user.setPlainPassword(RandomString.get(12));// 设定随机密码
        entryptPassword(user);// 加密

        user.setPhotoURL("default.jpg");
        user.setLastIP(134744072L);
        user.setTimeOffset("0800");
        LocalDateTime now = new LocalDateTime();
        user.setLastTime(now);
        user.setLastActTime(now);

        // 发送通知邮件
        sendNotifyMessage(user);

        logger.info("保存用户 user={}.", user.toString());
        return userMapper.save(user);
    }

    @Override
    @Transactional(readOnly = false)
    public int deleteByTask() throws InterruptedException {
        logger.info("任务删除用户.");
        return userMapper.deleteByTask();
    }

    @Transactional(readOnly = false)
    public int delete(Long id) {
        // 判断用户是否为超级管理员
        if (isSupervisor(id)) {
            logger.warn("操作员 {} 尝试删除超级管理员用户.", this.getCurrentUserName());
            throw new ServiceException("不能删除超级管理员用户.");
        }
        return this.update(id, "deleted");
    }

    @Transactional(readOnly = false)
    public int update(User user) {
        // 判断用户是否为超级管理员
//        if (isSupervisor(user.getId())) {
//            logger.warn("操作员 {} 尝试修改超级管理员用户.", this.getCurrentUserName());
//            throw new ServiceException("不能修改超级管理员用户.");
//        }

        logger.info("更新用户 user={}.", user.toString());
        int num = userMapper.update(user);
        sendNotifyMessage(user);
        return num;
    }

    @Override
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        // 判断用户是否为超级管理员, 禁止反审核、标记删除超级管理员
        if (isSupervisor(id)) {
            logger.warn("操作员 {} 尝试修改超级管理员用户.", this.getCurrentUserName());
            throw new ServiceException("不能修改超级管理员用户.");
        }

        logger.info("更新用户 #{} 的 {} 属性.", id, column);
        return userMapper.updateBool(id, column);
    }

    @Override
    @Transactional(readOnly = false)
    public int updateLastTime(Long id) {
        return this.updateTimeToNow(id, "last_time");
    }

    @Override
    @Transactional(readOnly = false)
    public int updateLastActTime(Long id) {
        return this.updateTimeToNow(id, "last_act_time");
    }

    private int updateTimeToNow(Long id, String column) {
        return userMapper.updateTimeToNow(id, column, new LocalDateTime());
    }

    @Override
    @Transactional(readOnly = false)
    public int repass(Long id) {
        // 判断用户是否为超级管理员
        if (isSupervisor(id)) {
            logger.warn("操作员 {} 尝试修改超级管理员用户.", this.getCurrentUserName());
            throw new ServiceException("不能修改超级管理员用户.");
        }

        User user = this.get(id);
        user.setPlainPassword(RandomString.get(12));// 设定随机密码
        entryptPassword(user);// 加密

        logger.info("重置用户密码 #{}, user.email={}.", id, user.getEmail());
        return this.update(user);
    }

    @Override
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        logger.info("批量审核用户 #{}.", Arrays.toString(ids));
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            userMapper.updateBool(Long.parseLong(id), "status");
        }
    }

    @Override
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        logger.info("批量删除用户 #{}.", Arrays.toString(ids));
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            userMapper.updateBool(Long.parseLong(id), "deleted");
        }
    }

    @Override
    public List<User> search(Map<String, Object> parameters, int offset, int limit) {
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        logger.info("Find users by parameters={}.", parameters.toString());
        return userMapper.search(parameters);
    }

    /**
     * 取出Shiro中的当前用户LoginName.
     */
    private String getCurrentUserName() {
        ShiroDbRealm.ShiroUser user = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
        return user.getLoginName();
    }

    /**
     * 判断是否超级管理员
     *
     * @param userId
     * @return
     */
    private boolean isSupervisor(Long userId) {
        return userId == 1L;
    }

    /**
     * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
     */
    public void entryptPassword(User user) {
        byte[] salt = Digests.generateSalt(SALT_SIZE);
        user.setSalt(Encodes.encodeHex(salt));

        byte[] hashPassword = Digests.sha1(user.getPlainPassword().getBytes(), salt, HASH_INTERATIONS);
        user.setPassword(Encodes.encodeHex(hashPassword));
    }

    /**
     * 发送用户变更消息.
     * <p/>
     * 发送只有一个消费者的Queue消息
     *
     * @param user
     */
    private void sendNotifyMessage(User user) {
        if (notifyProducer != null) {
            try {
                logger.info("Notify message to user={}.", user.toString());
                notifyProducer.sendQueue(user);
            } catch (Exception e) {
                logger.error("消息发送失败. {}.", e);
            }
        }
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

    @Autowired(required = false)
    public void setNotifyProducer(NotifyMessageProducer notifyProducer) {
        this.notifyProducer = notifyProducer;
    }

}
