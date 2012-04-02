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

    public void sendTopic(final User user) {
        sendMessage(user, notifyTopic);
    }

    /**
     * 使用jmsTemplate的send/MessageCreator()发送Map类型的消息并在Message中附加属性用于消息过滤.
     */
    private void sendMessage(final User user, Destination destination) {
        jmsTemplate.send(destination, new MessageCreator() {
            @Override
            public Message createMessage(Session session) throws JMSException {

                MapMessage message = session.createMapMessage();
                message.setString("username", user.getUsername());
                message.setString("email", user.getEmail());

                message.setStringProperty("objectType", "user");

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