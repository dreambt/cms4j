package cn.im47.cms.common.dao.account;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.account.User;
import cn.im47.commons.dao.MyBatisRepository;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户Dao
 * User: baitao.jibt@gmail.com
 * Date: 12-3-20
 * Time: 下午20:34
 */
@MyBatisRepository
public interface UserMapper extends GenericDao<User, Long> {

    List<User> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

    /**
     * 根据email获得用户信息
     *
     * @param email
     * @return
     */
    User getByEmail(String email);

    /**
     * 获取标记为删除的用户id
     *
     * @return
     */
    List<Long> getDeletedUserId();

    /**
     * 任务批量删除用户
     *
     * @return
     */
    int deleteByTask();

    /**
     * 检查邮箱是否已经注册
     *
     * @return
     */
    int isUsedEmail(@Param("email") String email);

}