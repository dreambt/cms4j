package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageDao;
import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.jms.NotifyMessageProducer;
import cn.edu.sdufe.cms.utilities.RandomString;
import cn.edu.sdufe.cms.utilities.thumb.ImageThumb;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * image 业务逻辑类
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午8:08
 */
@Component
@Transactional(readOnly = true)
public class ImageManager {

    private static final Logger logger = LoggerFactory.getLogger(ImageManager.class);

    private ImageDao imageDao;
    private ImageThumb imageThumb = new ImageThumb();

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    @Value("${path.upload.base}")
    private String UPLOAD_PATH;
    @Value("${path.upload.dir}")
    private String UPLOAD_DIR;

    /**
     * 获得编号为id的image
     *
     * @param id
     * @return
     */
    public Image findOne(Long id) {
        return imageDao.findOne(id);
    }

    /**
     * 获得分页的image
     *
     * @param offset
     * @param limit
     * @return
     */
    public List<Image> getPagedImage(int offset, int limit) {
        Map<String, Object> parameters = Maps.newHashMap();
        return imageDao.search(parameters, offset, limit);
    }

    /**
     * 获得image数量
     *
     * @return
     */
    public Long count() {
        return imageDao.count();
    }

    /**
     * 获得所有image
     *
     * @return
     */
    public List<Image> findAll() {
        return imageDao.findAll();
    }

    /**
     * 获得首页显示的image
     *
     * @return
     */
    public List<Image> findByShowIndex() {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("showIndex", "1");
        return imageDao.search(parameters);
    }

    /**
     * 添加image
     *
     * @param image
     * @return
     */
    @Transactional(readOnly = false)
    public int save(MultipartFile file, HttpServletRequest request, Image image) {
        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            String fileName = this.uploadFile(file, request);
            image.setImageUrl(fileName);

            try {
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery-big/" + fileName, UPLOAD_PATH + "thumb-50x57/" + fileName, 50, 57);
                logger.info("Success to generate Thumb: {}", UPLOAD_PATH + "thumb-50x57/" + fileName);

                // 异步生成其他缩略图
                notifyProducer.sendQueueGenThumb(UPLOAD_PATH, fileName);
            } catch (Exception e) {
                logger.info(e.getMessage());
            }
        } else {
            image.setImageUrl("");
        }
        return imageDao.save(image);
    }

    /**
     * 上传文件
     *
     * @param file
     * @param request
     * @return
     */
    public String uploadFile(MultipartFile file, HttpServletRequest request) {
        // 转型为MultipartHttpRequest：
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        //上传路径
        String path = multipartRequest.getSession().getServletContext().getRealPath(UPLOAD_DIR);

        //原文件名
        String imageName = file.getOriginalFilename();
        String ext = imageName.substring(imageName.lastIndexOf("."), imageName.length());

        //服务器上的文件名
        String fileName = new Date().getTime() + "-" + RandomString.get(6) + ext;
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }

        //保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }

    /**
     * 修改image
     *
     * @param file
     * @param request
     * @param image
     * @return
     */
    @Transactional(readOnly = false)
    public int update(MultipartFile file, HttpServletRequest request, Image image) {
        //首页显示
        if (null == request.getParameter("showIndex")) {
            image.setShowIndex(false);
        } else {
            image.setShowIndex(true);
        }

        //实现上传
        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            //存储旧图片名
            String oldFileName = image.getImageUrl();
            String fileName = this.uploadFile(file, request);
            image.setImageUrl(fileName);

            //项目路径
            //String path = System.getProperty("user.dir") + "/src/main/webapp/static/uploads/gallery/";

            //图片来源路径
            ImageThumb imageThumb = new ImageThumb();
            try {
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery-big/" + fileName, UPLOAD_PATH + "thumb-50x57/" + fileName, 50, 57);
                logger.info("Success to generate Thumb: {}", UPLOAD_PATH + "thumb-50x57/" + fileName);

                // 异步生成其他缩略图
                notifyProducer.sendQueueGenThumb(UPLOAD_PATH, fileName);

                // TODO 删除时只删除数据库，硬盘文件起任务轮询删除
                // notifyProducer.sendQueueDelThumb(fileName);

                // 成功上传新图片以后再删除旧图片，防止事务失败无法回滚图片
                this.deletePic("gallery-big/" + oldFileName);
                this.deletePic("thumb-50x57/" + oldFileName);
                this.deletePic("thumb-134x134/" + oldFileName);
                this.deletePic("thumb-224x136/" + oldFileName);
                this.deletePic("thumb-218x194/" + oldFileName);
                this.deletePic("thumb-460x283/" + oldFileName);
            } catch (Exception e) {
                logger.info(e.getMessage());
            }
        }
        return imageDao.update(image);
    }

    /**
     * 修改image
     *
     * @param image
     * @return
     */
    @Transactional(readOnly = false)
    public int update(Image image) {
        return imageDao.update(image);
    }

    /**
     * 修改image
     *
     * @param column
     * @return
     */
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        return imageDao.update(id, column);
    }

    /**
     * 将编号为id的image的删除标记置为true
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public int delete(Long id) {
        String fileName = this.findOne(id).getImageUrl();
        this.deletePic("gallery-big/" + fileName);
        this.deletePic("thumb-50x57/" + fileName);
        this.deletePic("thumb-134x134/" + fileName);
        this.deletePic("thumb-224x136/" + fileName);
        this.deletePic("thumb-218x194/" + fileName);
        this.deletePic("thumb-460x283/" + fileName);

        int num = imageDao.delete(id);
        // 成功删除数据库记录时，异步删除所有缩略图
        if (num > 0) {
            // TODO 删除时只删除数据库，硬盘文件起任务轮询删除
            // notifyProducer.sendQueueDelThumb(fileName);
        }
        return num;
    }

    /**
     * 批量改变评论的删除标志
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            this.delete(Long.parseLong(id));
        }
    }

    /**
     * 真正删除上传的图片
     *
     * @param fileName
     */
    public void deletePic(String fileName) {
        // TODO 删除
        //上传路径
        String path = System.getProperty("user.dir");
        new File(path + "/src/main/webapp/static/uploads/gallery/", fileName).delete();
        //new File(UPLOAD_PATH + "gallery-big/", fileName).delete();
    }

    @Autowired
    public void setImageDao(@Qualifier("imageDao") ImageDao imageDao) {
        this.imageDao = imageDao;
    }

    @Autowired
    public void setNotifyProducer(NotifyMessageProducer notifyProducer) {
        this.notifyProducer = notifyProducer;
    }
}