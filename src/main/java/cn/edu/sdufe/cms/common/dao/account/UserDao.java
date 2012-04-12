package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 用户Dao
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:34
 */
@Component
public class UserDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的用户
     *
     * @param id
     * @return
     */
    @Cacheable(value = "user")
    public User findOne(Long id) {
        return getSqlSession().selectOne("ACCOUNT.getUser", id);
    }

    /**
     * 获取邮箱为email的用户，仅用于登录
     *
     * @param email
     * @return
     */
    @Cacheable(value = "user")
    public User findByEmail(String email) {
        return getSqlSession().selectOne("ACCOUNT.getUserByEmail", email);
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    @Cacheable(value = "all_user")
    public List<User> findAll() {
        return getSqlSession().selectList("ACCOUNT.getAllUser");
    }

    /**
     * 获取用户数量
     *
     * @return
     */
    @Cacheable(value = "user_num")
    public Long count() {
        return getSqlSession().selectOne("ACCOUNT.getUserCount");
    }

    /**
     * 新建用户
     *
     * @param user
     * @return
     */
    public int save(User user) {
        return getSqlSession().insert("ACCOUNT.saveUser", user);
    }

    /**
     * 删除用户
     *
     * @return
     */
    public int delete() {
        return getSqlSession().delete("ACCOUNT.deleteUser");
    }

    /**
     * 更新用户
     *
     * @param user
     * @return
     */
    public int update(User user) {
        return getSqlSession().update("ACCOUNT.updateUser", user);
    }

    /**
     * 搜索用户
     *
     * @param parameters
     * @return
     */
    public List<User> search(Map<String, Object> parameters) {
        return getSqlSession().selectList("ACCOUNT.searchUser", parameters);
    }

}