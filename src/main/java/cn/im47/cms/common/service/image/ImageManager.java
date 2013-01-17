package cn.im47.cms.common.service.image;

import cn.im47.cms.common.dao.image.ImageMapper;
import cn.im47.cms.common.entity.image.Image;
import cn.im47.cms.common.service.GenericManager;
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
     * 获得 image 数量
     *
     * @return
     */
    long count();

    /**
     * 按指定的排序方式指定偏移的所有 image
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Image> getAll(int offset, int limit, String sort, String direction);

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
    int save(MultipartFile file, Image image);

    /**
     * 修改image
     *
     * @param file
     * @param request
     * @param image
     * @return
     */
    int update(MultipartFile file, HttpServletRequest request, Image image);

    /**
     * 修改 Image 的 boolean 字段
     *
     * @param column
     * @return
     */
    int update(Long id, String column);

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    void batchDelete(String[] ids);

    void setImageMapper(ImageMapper imageMapper);

}
