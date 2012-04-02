package cn.edu.sdufe.cms.common.dao;

import cn.edu.sdufe.cms.common.entity.ManageLog;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 管理日志Dao
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:46
 */
@Component
public class ManageLogDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的管理日志
     *
     * @param id
     * @return
     */
    @Cacheable(value = "manageLog")
    public ManageLog get(Long id) {
        return (ManageLog) getSqlSession().selectOne("System.getManageLog", id);
    }

    /**
     * 获取管理日志数量
     *
     * @return
     */
    public Long getCount() {
        return (Long) getSqlSession().selectOne("System.getManageLogCount");
    }

    /**
     * 搜索管理日志
     *
     * @param parameters
     * @return
     */
    public ManageLog search(Map<String, Object> parameters) {
        return (ManageLog) getSqlSession().selectOne("System.searchManageLog", parameters);
    }

    /**
     * 创建管理日志
     *
     * @return
     */
    public ManageLog save(ManageLog user) {
        getSqlSession().insert("System.saveManageLog", user);
        return user;
    }

    /**
     * 更新管理日志
     *
     * @return
     */
    public ManageLog update(ManageLog user) {
        getSqlSession().update("System.updateManageLog", user);
        return user;
    }

    /**
     * 删除编号为id的管理日志
     *
     * @param id
     * @return
     */
    public int delete(Long id) {
        return getSqlSession().delete("System.deleteManageLog", id);
    }
}