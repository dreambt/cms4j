package cn.im47.cms.common.dao.account;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.account.Group;

import java.util.List;

/**
 * 用户组Dao
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-29
 * Time: 下午5:06
 */
public interface GroupMapper extends GenericDao<Group, Long> {

    /**
     * 获取所有用户组
     *
     * @return
     */
    List<Group> getAll();

}