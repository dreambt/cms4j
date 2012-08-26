package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.image.Image;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * image Dao
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-4
 * Time: 下午7:49
 */
public interface ImageMapper extends GenericDao<Image, Long> {

    /**
     * 获得所有的连接
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Image> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

}