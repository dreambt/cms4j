package cn.edu.sdufe.cms.common.service.account;

import cn.edu.sdufe.cms.common.dao.account.UserDao;
import cn.edu.sdufe.cms.common.dao.account.UserJpaDao;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.article.Article;
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
import org.springside.modules.orm.jpa.Jpas;

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

    private static Logger logger = LoggerFactory.getLogger(UserManager.class);

    private UserDao userDao;

    private UserJpaDao userJpaDao;

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    private ShiroDbRealm shiroRealm;

    /**
     * 通过id获取用户
     *
     * @param id
     * @return
     */
    public User get(Long id) {
        User user = userJpaDao.findOne(id);
        //Jpas.initLazyProperty(user.getGroupList());
        return user;
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    public List<User> getAll() {
        return (List<User>) userJpaDao.findAll();
    }

    /**
     * 获取用户数量
     *
     * @return
     */
    public Long getCount() {
        return userDao.count();
    }

    /**
     * 加载Lazy属性
     *
     * @return
     */
    public List<User> getAllInitialized() {
        List<User> result = (List<User>) userJpaDao.findAll();
        for (User user : result) {
            Jpas.initLazyProperty(user.getGroupList());
        }
        return result;
    }

    /**
     * 按照parameters搜索用户
     *
     * @param parameters
     * @return
     */
    public List<User> search(Map<String, Object> parameters) {
        return (List<User>) userDao.search(parameters);
    }

    /**
     * 任务删除用户
     *
     * @return
     */
    @Transactional(readOnly = false)
    public int delete() throws InterruptedException {
        List<Long> list = userDao.getDeletedId();
        int count = list.size();
        while (list.size() > 0) {
            userJpaDao.delete((Long) list.remove(0));

            // 每次都要休息一会儿
            Thread.sleep(5000);
        }
        return count;
    }

    /**
     * 删除用户,如果尝试删除超级管理员将抛出异常.
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void delete(Long id) {
        User user = get(id);
        if (isSupervisor(user)) {
            logger.warn("操作员{}尝试删除超级管理员用户", SecurityUtils.getSubject().getPrincipal());
            throw new ServiceException("不能删除超级管理员用户");
        }
        userJpaDao.delete(id);
    }

    /**
     * 通过邮箱获取用户
     *
     * @param email
     * @return
     */
    public User findUserByEmail(String email) {
        User user = userJpaDao.findByEmail(email);
        return user;
    }

    /**
     * 通过用户名获取用户
     *
     * @param username
     * @return
     */
    public User findUserByUsername(String username) {
        User user = userJpaDao.findByUsername(username);
        return user;
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
     * 创建新用户
     *
     * @param user
     */
    @Transactional(readOnly = false)
    public void save(User user) {
        user.setPlainPassword(RandomString.get(8));
        user.setSalt(RandomString.get(16));
        user.setPhotoURL("default.jpg");
        user.setLastIP(134744072L);
        user.setTimeOffset("0800");
        user.setLastTime(new Date());
        user.setLastActTime(new Date());
        user.setCreateTime(new Date());
        this.update(user);
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
        user.setSalt(RandomString.get(16));
        this.update(user);
    }

    /**
     * 批量审核用户
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        User user = null;
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            user = this.get(Long.parseLong(id));
            user.setStatus(false);
            this.update(user);
        }
    }

    /**
     * 批量改变用户的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        User user = null;
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            user = this.get(Long.parseLong(id));
            user.setDeleted(true);
            this.update(user);
        }
    }

    /**
     * 保存用户.
     * 在保存用户时,发送用户修改通知消息, 由消息接收者异步进行较为耗时的通知邮件发送.
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

        //设定安全的密码，使用passwordService提供的salt并经过1024次 sha-1 hash
        if (StringUtils.isNotBlank(user.getPlainPassword()) && shiroRealm != null) {
            HashPassword hashPassword = shiroRealm.encrypt(user.getPlainPassword());
            user.setSalt(hashPassword.getSalt());
            user.setPassword(hashPassword.getPassword());
        }

        user.setModifyTime(new Date());
        userJpaDao.save(user);

        if (shiroRealm != null) {
            shiroRealm.clearCachedAuthorizationInfo(user.getEmail());
        }

        sendNotifyMessage(user);
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
                notifyProducer.sendQueue(user);
            } catch (Exception e) {
                logger.error("消息发送失败", e);
            }
        }
    }

    @Autowired
    public void setUserDao(@Qualifier("userDao") UserDao userDao) {
        this.userDao = userDao;
    }

    @Autowired
    public void setUserJpaDao(UserJpaDao userJpaDao) {
        this.userJpaDao = userJpaDao;
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