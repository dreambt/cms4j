package cn.edu.sdufe.cms.jms;

import cn.edu.sdufe.cms.utilities.email.MimeMailService;
import cn.edu.sdufe.cms.utilities.email.UserRecoveryMailService;
import cn.edu.sdufe.cms.utilities.thumb.ImageThumb;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;
import java.io.File;

/**
 * 消息的异步被动接收者.
 * 使用Spring的MessageListenerContainer侦听消息并调用本Listener进行处理.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午16:39
 */
public class NotifyMessageListener implements MessageListener {

    private static Logger logger = LoggerFactory.getLogger(NotifyMessageListener.class);

    @Autowired(required = false)
    private MimeMailService mimeMailService;

    @Autowired(required = false)
    private UserRecoveryMailService userRecoveryMailService;

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
                String path = mapMessage.getString("path");
                String fileName = mapMessage.getString("fileName");
                ImageThumb imageThumb = new ImageThumb();
                imageThumb.saveImageAsJpg(path + "gallery-big/" + fileName, path + "thumb-134x134/" + fileName, 134, 134);
                imageThumb.saveImageAsJpg(path + "gallery-big/" + fileName, path + "thumb-200x122/" + fileName, 200, 122);
                imageThumb.saveImageAsJpg(path + "gallery-big/" + fileName, path + "thumb-218x194/" + fileName, 218, 194);
                imageThumb.saveImageAsJpg(path + "gallery-big/" + fileName, path + "thumb-272x166/" + fileName, 460, 283);
                logger.info("Success to generate Thumb: {}", path + "thumb-*/" + fileName);
            } else if ("del_thumb".equals(objectType)) {
                String path = System.getProperty("user.dir");
                String fileName = mapMessage.getString("fileName");
                new File(path + "/src/main/webapp/static/uploads/gallery/gallery-big/thumb-50x57", fileName).delete();
                new File(path + "/src/main/webapp/static/uploads/gallery/gallery-big/thumb-134x134", fileName).delete();
                new File(path + "/src/main/webapp/static/uploads/gallery/gallery-big/thumb-200x122", fileName).delete();
                new File(path + "/src/main/webapp/static/uploads/gallery/gallery-big/thumb-218x194", fileName).delete();
                new File(path + "/src/main/webapp/static/uploads/gallery/gallery-big/thumb-272x166", fileName).delete();
                logger.info("Success to delete Thumb: {}", path + "thumb-*/" + fileName);
            } else {
                logger.error("Unknown objectType: " + mapMessage.toString());
            }
        } catch (Exception e) {
            logger.error("处理消息时发生异常.", e);
        }
    }

}