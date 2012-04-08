package cn.edu.sdufe.cms.common.entity.link;

import cn.edu.sdufe.cms.common.entity.IdEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * link实体类
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:25
 */
@Entity
@Table(name = "cms_link")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Link extends IdEntity {
    private String title;

    private String url;

    private boolean deleted;

    private Date createTime;

    private Date modifyTime;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Date getCreateTime() {
        return createTime;
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
