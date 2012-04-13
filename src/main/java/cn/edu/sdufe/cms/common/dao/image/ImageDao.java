package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * image Dao
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-4
 * Time: 下午7:49
 */
@Component
public class ImageDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的图片
     */
    @Cacheable(value = "image")
    public Image findOne(Long id) {
        return getSqlSession().selectOne("Image.getImage", id);
    }

    /**
     * 获得所有的image
     *
     * @return
     */
    @Cacheable(value = "image")
    public List<Image> findAll() {
        return getSqlSession().selectList("Image.getAllImage");
    }

    /**
     * 获得image数量
     *
     * @return
     */
    @Cacheable(value = "image_num")
    public Long count() {
        return getSqlSession().selectOne("Image.getImageCount");
    }

    /**
     * 新增图片
     */
    public int save(Image image) {
        return getSqlSession().insert("Image.saveImage", image);
    }

    /**
     * 删除图片
     */
    public int delete(Long id) {
        return getSqlSession().delete("Image.deleteImage", id);
    }

    /**
     * 更新图片
     */
    public int update(Image image) {
        return getSqlSession().update("Image.updateImage", image);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    @Cacheable(value = "image")
    public List<Image> search(Map<String, Object> parameters) {
        return getSqlSession().selectList("Image.searchImage", parameters, new RowBounds(0, 12));
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    @Cacheable(value = "image")
    public List<Image> search(Map<String, Object> parameters, RowBounds rowBounds) {
        parameters.put("Sort", "id");
        parameters.put("Direction", "DESC");
        return getSqlSession().selectList("Image.searchImage", parameters, rowBounds);
    }
}
