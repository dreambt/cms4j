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
    public User getUser(Long id) {
        return getSqlSession().selectOne("ACCOUNT.getUser", id);
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    @Cacheable(value = "all_user")
    public List<User> getAllUser() {
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
     * 获取标记为删除的用户id
     *
     * @return
     */
    public List<Long> getDeletedId() {
        return getSqlSession().selectList("ACCOUNT.getDeletedUserId");
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