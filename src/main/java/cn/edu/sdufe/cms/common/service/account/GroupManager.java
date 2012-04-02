package cn.edu.sdufe.cms.common.service.account;

import cn.edu.sdufe.cms.common.dao.account.GroupDao;
import cn.edu.sdufe.cms.common.entity.account.Group;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户组管理类
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午5:25
 */
@Component
@Transactional(readOnly = true)
public class GroupManager {

    private static Logger logger = LoggerFactory.getLogger(GroupManager.class);

    private GroupDao groupDao;

    /**
     * 获取用户组
     *
     * @param id
     * @return
     */
    public Group getGroup(Long id) {
        return groupDao.getGroup(id);
    }

    /**
     * 获取所有用户组
     *
     * @return
     */
    public List<Group> getAllGroup() {
        return groupDao.getAllGroup();
    }

    /**
     * 获取用户组数量
     *
     * @return
     */
    public Long getCount() {
        return groupDao.count();
    }

    @Autowired
    public void setGroupDao(GroupDao groupDao) {
        this.groupDao = groupDao;
    }
}