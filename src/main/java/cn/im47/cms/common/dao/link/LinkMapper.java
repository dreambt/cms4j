package cn.im47.cms.common.dao.link;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.link.Link;
import org.apache.ibatis.annotations.Param;

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
    public List<Link> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

}
