package cn.edu.sdufe.cms.common.entity.link;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * link实体类
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:25
 */
@Entity
@Table(name = "cms_link")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Link extends PersistableEntity {

    private String title;
    private String url;
    private boolean status;

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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
