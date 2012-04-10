package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import cn.edu.sdufe.cms.utilities.IPEncodes;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

/**
 * 评论Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:43
 */
@Entity
@Table(name = "cms_comment")
public class Comment extends PersistableEntity {

    private Article article;
    private String username;
    private String message;
    private Long postIP;
    private String postHostIP;
    private boolean status;
    private boolean deleted;

    @ManyToOne
    @JoinColumn(name = "article_id")
    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
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

    @Transient
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
        return ToStringBuilder.reflectionToString(this);
    }
}