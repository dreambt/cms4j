package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.account.User;
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