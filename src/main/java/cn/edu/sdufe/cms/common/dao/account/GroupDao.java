package cn.edu.sdufe.cms.common.dao.account;

import cn.edu.sdufe.cms.common.entity.account.Group;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 用户组Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-29
 * Time: 下午5:06
 */
@Component
public class GroupDao extends SqlSessionDaoSupport {

    /**
     * 获取用户组
     *
     * @param groupId
     * @return
     */
    public Group getGroup(Long groupId) {
        return getSqlSession().selectOne("ACCOUNT.getGroup", groupId);
    }

    /**
     * 获取所有用户组
     *
     * @return
     */
    public List<Group> getAllGroup() {
        return getSqlSession().selectList("ACCOUNT.getAllGroup");
    }

    /**
     * 获取数量
     *
     * @return
     */
    public Long count() {
        return getSqlSession().selectOne("ACCOUNT.getGroupCount");
    }

    /**
     * 搜索用户组
     *
     * @param parameters
     * @return
     */
    public List<Group> search(Map<String, Object> parameters) {
        return getSqlSession().selectOne("ACCOUNT.searchGroup", parameters);
    }
}