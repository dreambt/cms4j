package cn.edu.sdufe.cms.utilities.email;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Collections;
import java.util.Map;

/**
 * MIME邮件服务类.
 * <p/>
 * 演示由Freemarker引擎生成的的html格式邮件, 并带有附件.
 * User: baitao.jibt@gmail.com
 * Date: 12-4-2
 * Time: 下午23:53
 */
public class UserRecoveryMailService {

    private static final String DEFAULT_ENCODING = "utf-8";

    private static Logger logger = LoggerFactory.getLogger(UserRecoveryMailService.class);

    private JavaMailSender mailSender;

    private Template template;

    /**
     * 发送MIME格式的用户修改通知邮件.
     */
    public void sendNotificationMail(String email, String username, String plainPassword) {
        try {
            MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, DEFAULT_ENCODING);

            helper.setTo(email);
            helper.setFrom("baitao.jibt@gmail.com");
            helper.setSubject("用户信息修改通知");

            String content = generateContent(username, plainPassword);
            helper.setText(content, true);

            mailSender.send(msg);
            logger.info("HTML版邮件已发送至 " + email);
        } catch (MessagingException e) {
            logger.error("构造邮件失败", e);
        } catch (Exception e) {
            logger.error("发送邮件失败", e);
        }
    }

    /**
     * 使用Freemarker生成html格式内容.
     */
    private String generateContent(String username, String plainPassword) throws MessagingException {
        try {
            Map context = Collections.singletonMap("password", plainPassword);
            return FreeMarkerTemplateUtils.processTemplateIntoString(template, context);
        } catch (IOException e) {
            logger.error("生成邮件内容失败, FreeMarker模板不存在", e);
            throw new MessagingException("FreeMarker模板不存在", e);
        } catch (TemplateException e) {
            logger.error("生成邮件内容失败, FreeMarker处理失败", e);
            throw new MessagingException("FreeMarker处理失败", e);
        }
    }

    /**
     * Spring的MailSender.
     */
    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * 注入Freemarker引擎配置,构造Freemarker 邮件内容模板.
     */
    public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) throws IOException {
        //根据freemarkerConfiguration的templateLoaderPath载入文件.
        template = freemarkerConfiguration.getTemplate("userRecoveryTemplate.vm", DEFAULT_ENCODING);
    }

}