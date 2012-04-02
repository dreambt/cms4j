package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 用户 JPA Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午3:55
 */
public interface UserJpaDao extends PagingAndSortingRepository<User, Long> {

    /**
     * 通过邮箱查找用户
     *
     * @param email
     * @return
     */
    User findByEmail(String email);

    /**
     * 通过用户名查找用户
     *
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * 通过审核状态查找用户
     *
     * @param status
     * @return
     */
    User findByStatus(String status);

    /**
     * 通过邮箱审核状态查找用户
     *
     * @param emailStatus
     * @return
     */
    User findByEmailStatus(String emailStatus);

    /**
     * 通过头像审核状态查找用户
     *
     * @param avatarStatus
     * @return
     */
    User findByAvatarStatus(String avatarStatus);

}