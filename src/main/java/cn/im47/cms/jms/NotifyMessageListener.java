package cn.im47.cms.jms;

import cn.im47.cms.utilities.email.MimeMailService;
import cn.im47.cms.utilities.email.UserRecoveryMailService;
import cn.im47.commons.utilities.thumb.ImageThumb;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;
import java.io.File;

/**
 * 消息的异步被动接收者.
 * 使用Spring的MessageListenerContainer侦听消息并调用本Listener进行处理.
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-22
 * Time: 下午16:39
 */
public class NotifyMessageListener implements MessageListener {

    private static Logger logger = LoggerFactory.getLogger(NotifyMessageListener.class);

    @Autowired(required = false)
    private MimeMailService mimeMailService;

    @Autowired(required = false)
    private UserRecoveryMailService userRecoveryMailService;

    @Value("${path.upload.base}")
    private String UPLOAD_PATH;

    /**
     * MessageListener回调函数.
     */
    @Override
    public void onMessage(Message message) {
        try {
            MapMessage mapMessage = (MapMessage) message;
            String objectType = mapMessage.getStringProperty("objectType");
            if ("user".equals(objectType)) {
                //打印消息详情
                logger.info("UserName:" + mapMessage.getString("username") + ", Email:" + mapMessage.getString("email")
                        + ", ObjectType:" + mapMessage.getStringProperty("objectType"));

                //发送邮件
                if (mimeMailService != null) {
                    String plainPassword = mapMessage.getString("password");
                    if (null == plainPassword || plainPassword.length() == 0) {
                        mimeMailService.sendNotificationMail(mapMessage.getString("email"), mapMessage.getString("username"));
                    } else {
                        userRecoveryMailService.sendNotificationMail(mapMessage.getString("email"), mapMessage.getString("username"), plainPassword);
                    }
                }
            } else if ("gen_thumb".equals(objectType)) {
                String fileName = mapMessage.getString("fileName");
                ImageThumb imageThumb = new ImageThumb();
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-134x134/" + fileName, 134, 134);
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-224x136/" + fileName, 224, 136);
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-218x194/" + fileName, 218, 194);
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "gallery/gallery-big/" + fileName, UPLOAD_PATH + "gallery/thumb-272x166/" + fileName, 272, 166);
                logger.info("Success to generate Thumb: {}", UPLOAD_PATH + "gallery/thumb-*/" + fileName);
            } else if ("del_thumb".equals(objectType)) {
                String fileName = mapMessage.getString("fileName");
                new File(UPLOAD_PATH + "gallery/gallery-big", fileName).delete();
                new File(UPLOAD_PATH + "gallery/thumb-50x57", fileName).delete();
                new File(UPLOAD_PATH + "gallery/thumb-134x134", fileName).delete();
                new File(UPLOAD_PATH + "gallery/thumb-224x136", fileName).delete();
                new File(UPLOAD_PATH + "gallery/thumb-218x194", fileName).delete();
                new File(UPLOAD_PATH + "gallery/thumb-272x166", fileName).delete();
                logger.info("Success to delete Thumb: {}", UPLOAD_PATH + "gallery/thumb-*/" + fileName);
            } else if ("gen_article_image".equals(objectType)) {
                String fileName = mapMessage.getString("fileName");
                ImageThumb imageThumb = new ImageThumb();
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "article/article-big/" + fileName, UPLOAD_PATH + "article/news-thumb/" + fileName, 274, 157);
                imageThumb.saveImageAsJpg(UPLOAD_PATH + "article/article-big/" + fileName, UPLOAD_PATH + "article/digest-thumb/" + fileName, 134, 134);
                logger.info("Success to generate Article Image: {}", UPLOAD_PATH + "article/*-*/" + fileName);
            } else if ("del_article_image".equals(objectType)) {
                String fileName = mapMessage.getString("fileName");
                new File(UPLOAD_PATH + "article/article-big", fileName).delete();
                new File(UPLOAD_PATH + "article/digest-thumb", fileName).delete();
                new File(UPLOAD_PATH + "article/news-thumb", fileName).delete();
                logger.info("Success to delete Article Image: {}", UPLOAD_PATH + "article/*-*/" + fileName);
            } else {
                logger.error("Unknown objectType: " + mapMessage.toString());
            }
        } catch (Exception e) {
            logger.error("处理消息时发生异常.", e);
        }
    }

}
