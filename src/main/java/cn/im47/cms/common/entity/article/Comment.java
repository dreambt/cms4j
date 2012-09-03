package cn.im47.cms.common.entity.article;

import cn.im47.commons.entity.PersistableEntity;
import cn.im47.commons.utilities.encoder.IPEncodes;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 评论Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:43
 */
public class Comment extends PersistableEntity implements Serializable {

    private static final long serialVersionUID = -4082457458619235446L;

    private Article article;
    private int rate;
    private String username;
    private String message;
    private Long postIP;
    private String postHostIP;
    private boolean status;
    private boolean deleted;

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    @NotBlank
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @NotBlank
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @NotNull
    public Long getPostIP() {
        return postIP;
    }

    public void setPostIP(Long postIP) {
        this.postIP = postIP;
    }

    public String getPostHostIP() {
        return IPEncodes.longToIp(this.postIP);
    }

    public void setPostHostIP(String postHostIP) {
        this.postIP = IPEncodes.ipToLong(postHostIP);
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
