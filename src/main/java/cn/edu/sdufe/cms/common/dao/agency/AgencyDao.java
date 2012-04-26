package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import com.google.common.collect.Maps;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午1:16
 */
@Component
public class AgencyDao extends SqlSessionDaoSupport {

    /**
     * 根据编号获得组织机构
     * @param id
     * @return
     */
    @Cacheable(value = "agencyCache")
    public Agency getAgency(Long id) {
        return getSqlSession().selectOne("Agency.getAgency", id);
    }

    /**
     * 获得所有的组织机构
     * @return
     */
    @Cacheable(value = "agencyCache")
    public List<Agency> getAllAgency() {
        return getSqlSession().selectList("Agency.getAllAgency");
    }

    /**
     * 保存组织机构
     * @param agency
     * @return
     */
    @Cacheable(value = "agencyCache")
    public int save(Agency agency) {
        return getSqlSession().insert("Agency.saveAgency", agency);
    }

    /**
     * 彻底删除标记为删除的组织机构
     * @return
     */
    @Cacheable(value = "agencyCache")
    public int deleteAgency() {
        return getSqlSession().delete("Agency.deleteAgency");
    }

    /**
     * 更新组织机构
     * @param agency
     * @return
     */
    @Cacheable(value = "agencyCache")
    public int updateAgency(Agency agency) {
        return getSqlSession().update("Agency.updateAgency", agency);
    }

    /**
     * 更新组织机构某一boolean字段
     * @param id
     * @param column
     * @return
     */
    @Cacheable(value = "agencyCache")
    public int updateAgencyBool(Long id, String column) {
        Map parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Agency.updateAgencyBool", parameters);
    }

    /**
     * 增加浏览次数
     * @param id
     * @return
     */
    @Cacheable(value = "agencyCache")
    public int updateAgencyViews(Long id) {
        return getSqlSession().update("Agency.updateAgencyViews", id);
    }
}
