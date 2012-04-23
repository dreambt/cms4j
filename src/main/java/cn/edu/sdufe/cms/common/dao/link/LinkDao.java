package cn.edu.sdufe.cms.common.dao.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import com.google.common.collect.Maps;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * link Dao
 * User: baitao.jibt@gmail.com
 * Date: 12-4-10
 * Time: 下午8:25
 */
@Component
public class LinkDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的连接
     */
    public Link findOne(Long id) {
        return getSqlSession().selectOne("Link.getLink", id);
    }

    /**
     * 获得所有的连接
     *
     * @return
     */
    public List<Link> findAll() {
        return getSqlSession().selectList("Link.getAllLink");
    }

    /**
     * 根据分类获得连接
     *
     * @return
     */
    public List<Link> getLinkByCategory(LinkCategoryEnum category) {
        return getSqlSession().selectList("Link.getLinkByCategory", category);
    }

    /**
     * 新增连接
     */
    public int save(Link link) {
        return getSqlSession().insert("Link.saveLink", link);
    }

    /**
     * 删除图片
     */
    public int delete(Long id) {
        return getSqlSession().delete("Link.deleteLink", id);
    }

    /**
     * 更新图片
     */
    public int update(Link link) {
        return getSqlSession().update("Link.updateLink", link);
    }

    /**
     * 更新图片
     */
    public int update(Long id, String column) {
        Map parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Link.updateLinkBool", parameters);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    public List<Link> search(Map<String, Object> parameters) {
        RowBounds rowBounds = new RowBounds(0, 10);
        return getSqlSession().selectList("Link.searchLink", parameters, rowBounds);
    }
}