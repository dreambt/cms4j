package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageJpaDao;
import cn.edu.sdufe.cms.common.entity.image.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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
    public List<Image> getAllImageByDeleted() {
        return (List<Image>)imageJpaDao.findByDeleted(false);
    }

    /**
     * 获得所有image
     *
     * @return
     */
    public List<Image> getAllImage() {
        return (List<Image>)imageJpaDao.findAll();
    }

    /**
     * 获得编号为id的image
     *
     * @param id
     * @return
     */
    public Image getImage(Long id) {
        return (Image)imageJpaDao.findOne(id);
    }

    /**
     * 添加image
     *
     * @param image
     * @return
     */
    @Transactional(readOnly = false)
    public Image save(Image image) {
        image.setDeleted(false);
        image.setCreateTime(new Date());
        image.setModifyTime(new Date());
        return (Image)imageJpaDao.save(image);
    }

    /**
     * 修改image
     *
     * @param image
     * @return
     */
    @Transactional(readOnly = false)
    public Image update(Image image) {
        image.setModifyTime(new Date());
        return (Image)imageJpaDao.save(image);
    }

    /**
     * 将image的删除标记置为true
     *
     * @param image
     */
    @Transactional(readOnly = false)
    public Image delete(Image image) {
        image.setDeleted(!image.isDeleted());
        return this.update(image);
    }

    /**
     * 将编号为id的image的删除标记置为true
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public Image delete(Long id) {
        Image image = this.getImage(id);
        image.setDeleted(!image.isDeleted());
        return this.update(image);
    }

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            Image image = this.getImage(Long.parseLong(id));
            image.setDeleted(true);
            this.update(image);
        }
    }

    /**
     * 真正删除image
     *
     * @param id
     */
    public void deleteImage(Long id) {
        imageJpaDao.delete(id);
    }

    @Autowired
    public void setImageJpaDao(ImageJpaDao imageJpaDao) {
        this.imageJpaDao = imageJpaDao;
    }
}
