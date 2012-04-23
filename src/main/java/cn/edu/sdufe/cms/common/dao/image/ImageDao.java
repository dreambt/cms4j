package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import com.google.common.collect.Maps;
import org.mybatis.spring.support.SqlSessionDaoSupport;
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
    public Image findOne(Long id) {
        return getSqlSession().selectOne("Image.getImage", id);
    }

    /**
     * 获得所有的image
     *
     * @return
     */
    public List<Image> findAll() {
        return getSqlSession().selectList("Image.getAllImage");
    }

    /**
     * 获得image数量
     *
     * @return
     */
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
     * 更新图片
     */
    public int update(Long id, String column) {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Image.updateImageBool", parameters);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    public List<Image> search(Map<String, Object> parameters) {
        return this.search(parameters, 0, 10);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    public List<Image> search(Map<String, Object> parameters, int offset, int limit) {
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        parameters.put("Sort", "id");
        parameters.put("Direction", "DESC");
        return getSqlSession().selectList("Image.searchImage", parameters);
    }
}