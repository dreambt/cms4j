package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageJpaDao;
import cn.edu.sdufe.cms.common.entity.image.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * image 业务逻辑类
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午8:08
 */
@Component
@Transactional(readOnly = true)
public class ImageManager {
    private ImageJpaDao imageJpaDao;

    /**
     * 获得所有没有删除的image
     *
     * @return
     */
    public List<Image> getAllImage() {
        return (List<Image>)imageJpaDao.findByDeleted(false);
    }

    //
    public Image getImageByid(Long id) {
        return (Image)imageJpaDao.findOne(id);
    }

    /**
     * 添加image
     *
     * @param image
     * @return
     */
    public Image save(Image image) {
        return (Image)imageJpaDao.save(image);
    }

    /**
     * 将image的删除标记置为true
     *
     * @param image
     */
    public void delete(Image image) {
        image.setDeleted(true);
    }

    @Autowired
    public void setImageJpaDao(ImageJpaDao imageJpaDao) {
        this.imageJpaDao = imageJpaDao;
    }
}
