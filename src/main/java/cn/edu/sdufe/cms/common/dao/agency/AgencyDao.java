package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;

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
}
