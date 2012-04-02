package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.IdEntity;
import cn.edu.sdufe.cms.utilities.IPEncodes;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 评论Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:43
 */
@Entity
@Table(name = "cms_comment")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Comment extends IdEntity {

    private Article article;

    private String username;

    private String message;

    private Long postIp;

    private String postHostIp;

    private boolean status;

    private boolean deleted;

    private Date createTime;

    private Date modifyTime;

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
    public Long getPostIp() {
        return postIp;
    }

    public void setPostIp(Long postIp) {
        this.postIp = postIp;
    }

    @Transient
    public String getPostHostIp() {
        return IPEncodes.longToIp(this.postIp);
    }

    public void setPostHostIp(String postHostIp) {
        this.postIp = IPEncodes.ipToLong(postHostIp);
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

    /**
     * 防止外部通过getter引用修改属性
     *
     * @return
     */
    public Date getCreateTime() {
        if (null != this.createTime) {
            return new Date(this.createTime.getTime());
        } else {
            return null;
        }
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}