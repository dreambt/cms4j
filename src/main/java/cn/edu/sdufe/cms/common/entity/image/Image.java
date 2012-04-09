package cn.edu.sdufe.cms.common.entity.image;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 图片功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午7:33
 */
@Entity
@Table(name = "cms_image")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Image extends PersistableEntity {

    private String title;

    private String imageUrl;

    private String description;

    private boolean showIndex;

    private boolean deleted;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isShowIndex() {
        return showIndex;
    }

    public void setShowIndex(boolean showIndex) {
        this.showIndex = showIndex;
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
