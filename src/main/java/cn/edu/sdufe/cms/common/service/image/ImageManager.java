package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageMapper;
import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.service.GenericManager;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Image Manager 接口
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-13
 * Time: 上午9:42
 */
public interface ImageManager extends GenericManager<Image, Long> {

    /**
     * 获得分页的image
     *
     * @param offset
     * @param limit
     * @return
     */
    List<Image> getPagedImage(int offset, int limit);

    /**
     * 获得image数量
     *
     * @return
     */
    long count();

    /**
     * 获得所有image
     *
     * @return
     */
    List<Image> getAll();

    /**
     * 获得首页显示的image
     *
     * @return
     */
    List<Image> findByShowIndex();

    /**
     * 添加image
     *
     * @param image
     * @return
     */
    long save(MultipartFile file, Image image);

    /**
     * 修改image
     *
     * @param file
     * @param request
     * @param image
     * @return
     */
    long update(MultipartFile file, HttpServletRequest request, Image image);

    /**
     * 修改 Image 的 boolean 字段
     *
     * @param column
     * @return
     */
    long update(Long id, String column);

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    void batchDelete(String[] ids);

    void setImageMapper(ImageMapper imageMapper);

}
