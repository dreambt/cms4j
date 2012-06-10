package cn.edu.sdufe.cms.common.service.account;

import cn.edu.sdufe.cms.common.entity.account.Group;

import java.util.List;

/**
 * 用户 Manager 接口
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-12
 * Time: 下午4:12
 */
public interface GroupManager {

    /**
     * 获取用户组
     *
     * @param id
     * @return
     */
    Group getGroup(Long id);

    /**
     * 获取所有用户组
     *
     * @return
     */
    List<Group> getAllGroup();

    /**
     * 获取用户组数量
     *
     * @return
     */
    long count();

}
