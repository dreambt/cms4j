package cn.edu.sdufe.cms.common.service.agency;

import cn.edu.sdufe.cms.common.dao.agency.AgencyDao;
import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用途
 * User: lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午1:15
 */
@Component
@Transactional(readOnly = true)
public class AgencyManager {

    private static final Logger logger = LoggerFactory.getLogger(AgencyManager.class);

    private AgencyDao agencyDao;

    private CategoryManager categoryManager;

    /**
     * 根据编号获得组织机构
     *
     * @param id
     * @return
     */
    public Agency getAgency(Long id) {
        return agencyDao.getAgency(id);
    }

    /**
     * 获得所有的组织机构
     *
     * @return
     */
    public List<Agency> getAllAgency() {
        return (List<Agency>) agencyDao.getAllAgency();
    }

    /**
     * @param id
     */
    @Transactional(readOnly = false)
    public int deleteAgency(Long id) {
        return agencyDao.updateAgencyBool(id, "deleted");
    }

    @Transactional(readOnly = false)
    public int saveAgency(Agency agency) {

        agency.setCategoryId(1L);
        agency.setImageUrl("banner.png");
        return agencyDao.save(agency);

    }

    @Autowired
    public void setAgencyDao(AgencyDao agencyDao) {
        this.agencyDao = agencyDao;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}
