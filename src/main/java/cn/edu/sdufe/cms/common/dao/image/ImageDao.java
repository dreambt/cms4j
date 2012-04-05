package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * image Dao
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-4
 * Time: 下午7:49
 */
@Component
public class ImageDao extends SqlSessionDaoSupport {

    /**
     * 获得分页的image
     *
     * @param rowBounds
     * @return
     */
    @Cacheable(value = "imagePaged")
    public List<Image> getPagedImage(RowBounds rowBounds) {
        return getSqlSession().selectList("Image.getPagedImage", 1L, rowBounds);
    }
}
