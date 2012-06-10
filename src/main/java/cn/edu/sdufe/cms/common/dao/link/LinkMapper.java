package cn.edu.sdufe.cms.common.dao.link;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;

import java.util.List;

/**
 * link Dao
 * User: baitao.jibt@gmail.com
 * Date: 12-4-10
 * Time: 下午8:25
 */
public interface LinkMapper extends GenericDao<Link, Long> {

    /**
     * 获得所有的连接
     *
     * @return
     */
    public List<Link> getAll();

    /**
     * 根据分类获得连接
     *
     * @return
     */
    public List<Link> getLinkByCategory(LinkCategoryEnum category);

}