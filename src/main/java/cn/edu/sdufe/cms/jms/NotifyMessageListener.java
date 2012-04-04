package cn.edu.sdufe.cms.jms;

import cn.edu.sdufe.cms.utilities.email.MimeMailService;
import cn.edu.sdufe.cms.utilities.email.UserRecoveryMailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

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

            //打印消息详情
            logger.info("UserName:" + mapMessage.getString("username") + ", Email:" + mapMessage.getString("email")
                    + ", ObjectType:" + mapMessage.getStringProperty("objectType"));

            //发送邮件
            if (mimeMailService != null) {
                String plainPassword = mapMessage.getString("plainPassword");
                if (plainPassword.length() > 0)
                    userRecoveryMailService.sendNotificationMail(mapMessage.getString("email"), mapMessage.getString("username"), plainPassword);
                else
                    mimeMailService.sendNotificationMail(mapMessage.getString("email"), mapMessage.getString("username"));
            }
        } catch (Exception e) {
            logger.error("处理消息时发生异常.", e);
        }
    }

}