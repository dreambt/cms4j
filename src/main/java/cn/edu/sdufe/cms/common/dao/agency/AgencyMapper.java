package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.agency.Agency;

import java.util.List;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午1:16
 */
public interface AgencyMapper extends GenericDao<Agency, Long> {

    /**
     * 获得所有的组织机构
     *
     * @return
     */
    List<Agency> getAll();

    /**
     * 增加浏览次数
     *
     * @param id
     * @return
     */
    int updateViews(Long id);
}
