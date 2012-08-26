package cn.edu.sdufe.cms.common.service.account;

import cn.edu.sdufe.cms.common.dao.account.UserMapper;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.service.ServiceException;
import cn.edu.sdufe.cms.jms.NotifyMessageProducer;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.security.ShiroDbRealm.HashPassword;
import cn.edu.sdufe.cms.utilities.RandomString;
import com.google.common.collect.Lists;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 安全相关实体的管理类,包括用户和权限组.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午5:25
 */
@Component
@Transactional(readOnly = true)
public class UserManagerImpl implements UserManager {

    private static final Logger logger = LoggerFactory.getLogger(UserManager.class);

    private UserMapper userMapper;

    private JsonMapper jsonMapper = JsonMapper.nonEmptyMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    private ShiroDbRealm shiroRealm;

    @Value("${paged.user.limit}")
    public int LIMIT;

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
    public List<User> getAll() {
        return this.getAll(0, LIMIT, "id", "ASC");
    }

    @Override
    public List<User> getAll(int offset, int limit) {
        return this.getAll(offset, limit, "id", "ASC");
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
    public long save(User user) {
        user.setPlainPassword(RandomString.get(8));
        user.setSalt(RandomString.get(16));

        //设定安全的密码，使用passwordService提供的salt并经过1024次 sha-1 hash
        if (StringUtils.isNotBlank(user.getPlainPassword()) && shiroRealm != null) {
            HashPassword hashPassword = shiroRealm.encrypt(user.getPlainPassword());
            user.setSalt(hashPassword.getSalt());
            user.setPassword(hashPassword.getPassword());
        }

        user.setPhotoURL("default.jpg");
        user.setLastIP(134744072L);
        user.setTimeOffset("0800");
        user.setLastTime(new Date());
        user.setLastActTime(new Date());

        // 发送通知邮件
        sendNotifyMessage(user);

        logger.info("保存用户 user={}.", user.toString());
        return userMapper.save(user);
    }


    @Override
    @Transactional(readOnly = false)
    public long deleteByTask() throws InterruptedException {
        logger.info("任务删除用户.");
        return userMapper.deleteByTask();
    }

    @Transactional(readOnly = false)
    public long delete(Long id) {
        // 判断用户是否为超级管理员
        if (id == 1) {
            logger.warn("操作员 {} 尝试删除超级管理员用户.", SecurityUtils.getSubject().getPrincipal());
            throw new ServiceException("不能删除超级管理员用户.");
        }
        return this.update(id, "deleted");
    }

    @Transactional(readOnly = false)
    public long update(User user) {
        if (isSupervisor(user)) {
            logger.warn("操作员 {} 尝试修改超级管理员用户.", SecurityUtils.getSubject().getPrincipal());
            throw new ServiceException("不能修改超级管理员用户.");
        }

        logger.info("更新用户 user={}.", user.toString());
        long num = userMapper.update(user);
        sendNotifyMessage(user);
        return num;
    }

    @Override
    @Transactional(readOnly = false)
    public long update(Long id, String column) {
        logger.info("更新用户 #{} 的 {} 属性.", id, column);
        return userMapper.updateBool(id, column);
    }

    /**
     * 判断是否超级管理员
     *
     * @param user
     * @return
     */
    private boolean isSupervisor(User user) {
        return (user.getId() != null && user.getId() == 1L);
    }

    @Override
    @Transactional(readOnly = false)
    public void repass(Long id) {
        User user = this.get(id);
        user.setPlainPassword(RandomString.get(8));

        //设定安全的密码，使用passwordService提供的salt并经过1024次 sha-1 hash
        if (StringUtils.isNotBlank(user.getPlainPassword()) && shiroRealm != null) {
            HashPassword hashPassword = shiroRealm.encrypt(user.getPlainPassword());
            user.setSalt(hashPassword.getSalt());
            user.setPassword(hashPassword.getPassword());
        }

        logger.info("重置用户密码 #{}, user.email={}.", id, user.getEmail());
        this.update(user);
    }

    @Override
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        logger.info("批量审核用户 #{}.", ids.toString());
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
        logger.info("批量删除用户 #{}.", ids.toString());
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

    @Autowired(required = false)
    public void setShiroRealm(ShiroDbRealm shiroRealm) {
        this.shiroRealm = shiroRealm;
    }

}
