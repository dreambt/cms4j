package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.image.Image;

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
     * @return
     */
    List<Image> getAll();

}