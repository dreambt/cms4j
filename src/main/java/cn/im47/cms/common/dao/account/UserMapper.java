package cn.im47.cms.common.dao.account;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.account.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户Dao
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:34
 */
public interface UserMapper extends GenericDao<User, Long> {

    List<User> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

    /**
     * 获取邮箱为email的用户，仅用于登录
     *
     * @param email
     * @return
     */
    User getByEmail(String email);

    int deleteByTask();

}