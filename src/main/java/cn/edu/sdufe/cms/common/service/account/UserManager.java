package cn.edu.sdufe.cms.common.service.account;

import cn.edu.sdufe.cms.common.dao.account.UserMapper;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.service.ServiceException;
import cn.edu.sdufe.cms.jms.NotifyMessageProducer;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.security.ShiroDbRealm.HashPassword;
import cn.edu.sdufe.cms.utilities.RandomString;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

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
//Spring Bean的标识.
@Component
//默认将类中的所有public函数纳入事务管理.
@Transactional(readOnly = true)
public class UserManager {

    private static final Logger logger = LoggerFactory.getLogger(UserManager.class);

    private UserMapper userMapper;

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    private ShiroDbRealm shiroRealm;

    /**
     * 通过id获取用户
     *
     * @param id
     * @return
     */
    public User get(Long id) {
        logger.debug("== Find user by id={}.", id);
        return userMapper.get(id);
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    public List<User> getAll() {
        logger.debug("== Find all user.");
        return userMapper.getAll();
    }

    /**
     * 通过邮箱获取用户
     *
     * @param email
     * @return
     */
    public User findUserByEmail(String email) {
        logger.debug("== Find user by email={}.", email);
        return userMapper.getByEmail(email);
    }

    /**
     * 获取用户数量
     *
     * @return
     */
    public Long getCount() {
        logger.debug("== Find the number of user.");
        return userMapper.count();
    }

    /**
     * 创建新用户
     *
     * @param user
     */
    @Transactional(readOnly = false)
    public int save(User user) {
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

        logger.debug("== Save user={}.", user.toString());
        return userMapper.save(user);
    }

    /**
     * 任务删除用户
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() throws InterruptedException {
        logger.debug("== Delete user.");
        return userMapper.deleteByTask();
    }

    /**
     * 删除用户,如果尝试删除超级管理员将抛出异常.
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public int delete(Long id) {
        // 判断用户是否为超级管理员
        if (id == 1) {
            logger.warn("操作员{}尝试删除超级管理员用户", SecurityUtils.getSubject().getPrincipal());
            throw new ServiceException("不能删除超级管理员用户");
        }
        return this.update(id, "deleted");
    }

    /**
     * 更新用户.
     * 在更新用户时,发送用户修改通知消息, 由消息接收者异步进行较为耗时的通知邮件发送.
     * 如果企图修改超级用户,取出当前操作员用户,打印其信息然后抛出异常.
     *
     * @param user
     */
    @Transactional(readOnly = false)
    public void update(User user) {
        if (isSupervisor(user)) {
            logger.warn("操作员{}尝试修改超级管理员用户", SecurityUtils.getSubject().getPrincipal());
            throw new ServiceException("不能修改超级管理员用户");
        }

        logger.debug("== Update user={}.", user);
        userMapper.update(user);
        sendNotifyMessage(user);
    }

    /**
     * 更新用户
     *
     * @param id
     * @param column
     */
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        logger.debug("== Update user's #{} by id={}.", column, id);
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

    /**
     * 重置密码
     *
     * @param id
     */
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

        logger.debug("== Reset user's password by id={}, email={}.", id, user.getEmail());
        this.update(user);
        sendNotifyMessage(user);
    }

    /**
     * 批量审核用户
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            userMapper.updateBool(Long.parseLong(id), "status");
        }
    }

    /**
     * 批量改变用户的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            userMapper.updateBool(Long.parseLong(id), "deleted");
        }
    }

    /**
     * 按照parameters搜索用户
     *
     * @param parameters
     * @return
     */
    public List<User> search(Map<String, Object> parameters) {
        logger.debug("== Find users by parameters={}.", parameters.toString());
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
                logger.info("== Notify message to user={}.", user.toString());
                notifyProducer.sendQueue(user);
            } catch (Exception e) {
                logger.error("消息发送失败", e);
            }
        }
    }

    @Autowired
    public void setUserMapper(@Qualifier("userMapper") UserMapper userMapper) {
        this.userMapper = userMapper;
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