package cn.im47.cms.common.entity.image;

import cn.im47.commons.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.io.Serializable;

/**
 * 图片功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午7:33
 */
public class Image extends PersistableEntity implements Serializable {

    private static final long serialVersionUID = -4082457458619235441L;

    private String title;
    private String imageUrl;
    private String description;
    private boolean showIndex;

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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
