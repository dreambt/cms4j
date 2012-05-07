package cn.edu.sdufe.cms.jms;

import cn.edu.sdufe.cms.common.entity.account.User;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import javax.jms.*;

/**
 * JMS用户变更消息生产者.
 * 使用jmsTemplate将用户变更消息分别发送到queue与topic.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-22
 * Time: 下午16:39
 */
public class NotifyMessageProducer {

    private JmsTemplate jmsTemplate;
    private Destination notifyQueue;
    private Destination notifyTopic;

    public void sendQueue(final User user) {
        sendMessage(user, notifyQueue);
    }

    public void sendQueueGenThumb(final String fileName) {
        sendMessage(fileName, notifyQueue);
    }

    public void sendQueueDelThumb(final String fileName) {
        sendMessage2(fileName, notifyQueue);
    }

    public void sendTopic(final User user) {
        sendMessage(user, notifyTopic);
    }

    /**
     * 用户信息变更通知邮件
     */
    private void sendMessage(final User user, Destination destination) {
        jmsTemplate.send(destination, new MessageCreator() {
            @Override
            public Message createMessage(Session session) throws JMSException {

                MapMessage message = session.createMapMessage();
                message.setString("username", user.getUsername());
                message.setString("email", user.getEmail());
                message.setString("password", user.getPlainPassword());

                message.setStringProperty("objectType", "user");

                return message;
            }
        });
    }

    /**
     * 生成缩略图
     */
    private void sendMessage(final String fileName, Destination destination) {
        jmsTemplate.send(destination, new MessageCreator() {
            @Override
            public Message createMessage(Session session) throws JMSException {

                MapMessage message = session.createMapMessage();
                message.setString("fileName", fileName);

                message.setStringProperty("objectType", "gen_thumb");

                return message;
            }
        });
    }

    /**
     * 删除缩略图
     */
    private void sendMessage2(final String fileName, Destination destination) {
        jmsTemplate.send(destination, new MessageCreator() {
            @Override
            public Message createMessage(Session session) throws JMSException {

                MapMessage message = session.createMapMessage();
                message.setString("fileName", fileName);

                message.setStringProperty("objectType", "del_thumb");

                return message;
            }
        });
    }

    public void setJmsTemplate(JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

    public void setNotifyQueue(Destination notifyQueue) {
        this.notifyQueue = notifyQueue;
    }

    public void setNotifyTopic(Destination nodifyTopic) {
        this.notifyTopic = nodifyTopic;
    }
}