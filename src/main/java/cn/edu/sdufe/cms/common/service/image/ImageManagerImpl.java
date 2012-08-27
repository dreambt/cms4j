package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageMapper;
import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.jms.NotifyMessageProducer;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import cn.edu.sdufe.cms.utilities.thumb.ImageThumb;
import cn.edu.sdufe.cms.utilities.upload.UploadFile;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;

import javax.servlet.http.HttpServletRequest;
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
public class ImageManagerImpl implements ImageManager {

    private static final Logger logger = LoggerFactory.getLogger(ImageManager.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private NotifyMessageProducer notifyProducer; //JMS消息发送

    private ImageMapper imageMapper;

    @Value("${path.upload.base}")
    private String UPLOAD_PATH;

    @Value("${paged.image.limit}")
    public int LIMIT;

    public Image get(Long id) {
        Image image = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.IMAGE.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            image = imageMapper.get(id);
            jsonString = jsonMapper.toJson(image);
            spyMemcachedClient.set(key, MemcachedObjectType.IMAGE.getExpiredTime(), jsonString);
        } else {
            image = jsonMapper.fromJson(jsonString, Image.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取相册 #{} 用时：{}ms. key: " + key, id, end - start);
        return image;
    }

    @Override
    @Deprecated
    public long save(Image object) {
        return 0;
    }

    public long count() {
        long num = 0L;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.IMAGE.getPrefix() + "count";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = imageMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.IMAGE.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取相册数 用时：{}ms. key: " + key, end - start);
        return num;
    }

    @Override
    public List<Image> getAll() {
        return this.getAll(0, LIMIT, "id", "DESC");
    }

    @Override
    public List<Image> getAll(int offset, int limit) {
        return this.getAll(offset, limit, "id", "DESC");
    }

    @Override
    public List<Image> getAll(int offset, int limit, String sort, String direction) {
        List<Image> imageList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.IMAGE.getPrefix() + "all:" + offset + ":" + limit + ":" + sort + ":" + direction;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            imageList = imageMapper.getAll(offset, limit, sort, direction);
            jsonString = jsonMapper.toJson(imageList);
            spyMemcachedClient.set(key, MemcachedObjectType.IMAGE.getExpiredTime(), jsonString);
        } else {
            imageList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Image.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取所有相册 用时：{}ms. key: " + key, end - start);
        return imageList;
    }

    @Override
    public List<Image> findByShowIndex() {
        List<Image> imageList = Lists.newArrayList();
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("showIndex", 1);
        parameters.put("offset", 0);
        parameters.put("limit", 10);
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.IMAGE.getPrefix() + "showIndex";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            imageList = imageMapper.search(parameters);
            jsonString = jsonMapper.toJson(imageList);
            spyMemcachedClient.set(key, MemcachedObjectType.IMAGE.getExpiredTime(), jsonString);
        } else {
            imageList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Image.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取首页显示的相册 用时：{}ms. key: " + key, end - start);
        return imageList;
    }

    @Override
    @Transactional(readOnly = false)
    public long save(MultipartFile file, Image image) {
        logger.info("保存相册 image={}.", image.toString());
        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, UPLOAD_PATH + "gallery/gallery-big/");
            image.setImageUrl(fileName);

            ImageThumb imageThumb = new ImageThumb();
            try {
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-50x57/" + fileName, 50, 57);
                logger.info("成功创建缩略图: {}.", UPLOAD_PATH + "gallery/thumb-50x57/" + fileName);

                // 异步生成其他缩略图
                notifyProducer.sendQueueGenThumb(fileName);
            } catch (Exception e) {
                logger.warn("保存相册失败", e.getMessage());
            }
        } else {
            image.setImageUrl("");
        }
        return imageMapper.save(image);
    }

    @Override
    @Transactional(readOnly = false)
    public long update(MultipartFile file, HttpServletRequest request, Image image) {
        logger.info("更新相册 image={}.", image.toString());
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
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, UPLOAD_PATH + "gallery/gallery-big/");
            image.setImageUrl(fileName);

            //图片来源路径
            ImageThumb imageThumb = new ImageThumb();
            try {
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-50x57/" + fileName, 50, 57);
                logger.info("成功创建缩略图: {}", UPLOAD_PATH + "gallery/thumb-50x57/" + fileName);

                // 异步生成其他缩略图
                notifyProducer.sendQueueGenThumb(fileName);

                // 成功上传新图片以后再删除旧图片，防止事务失败无法回滚图片
                // 删除时只删除数据库，硬盘文件起任务轮询删除
                notifyProducer.sendQueueDelThumb(oldFileName);
            } catch (Exception e) {
                logger.warn("保存相册失败", e.getMessage());
            }
        }
        return imageMapper.update(image);
    }

    @Transactional(readOnly = false)
    public long update(Image image) {
        logger.info("更新相册 image={}.", image.toString());
        return imageMapper.update(image);
    }

    @Override
    @Transactional(readOnly = false)
    public long update(Long id, String column) {
        logger.info("更新相册 #{} 的 {} 属性.", id, column);
        return imageMapper.updateBool(id, column);
    }

    @Override
    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除相册 #{}.", id);
        String fileName = imageMapper.get(id).getImageUrl();

        long num = imageMapper.delete(id);
        // 成功删除数据库记录时，异步删除所有缩略图
        if (num > 0) {
            // 删除时只删除数据库，硬盘文件起任务轮询删除
            notifyProducer.sendQueueDelThumb(fileName);
        }
        return num;
    }

    @Override
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        logger.info("批量删除相册 #{}.", ids.toString());
        for (String id : ids) {
            this.delete(Long.parseLong(id));
        }
    }

    @Autowired
    public void setImageMapper(ImageMapper imageMapper) {
        this.imageMapper = imageMapper;
    }

    @Autowired
    public void setNotifyProducer(NotifyMessageProducer notifyProducer) {
        this.notifyProducer = notifyProducer;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

}
