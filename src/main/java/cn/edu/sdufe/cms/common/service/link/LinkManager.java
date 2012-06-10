package cn.edu.sdufe.cms.common.service.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.common.service.GenericManager;

import java.util.List;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-13
 * Time: 上午9:23
 */
public interface LinkManager extends GenericManager<Link, Long> {

    /**
     * 获得所有link
     *
     * @return
     */
    List<Link> getAll();

    /**
     * 根据分类获得link
     *
     * @return
     */
    List<Link> getByCategory(LinkCategoryEnum category);

    long update(Long id, String column);

    /**
     * 批量删除link
     *
     * @param ids
     */
    void batchDelete(String[] ids);

}
