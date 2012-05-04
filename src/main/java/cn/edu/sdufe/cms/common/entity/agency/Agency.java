package cn.edu.sdufe.cms.common.entity.agency;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com), lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午12:55
 */
public class Agency extends PersistableEntity {

    private String title;
    private Long categoryId;
    private String imageUrl;
    private String introduction;
    private int rate;
    private boolean deleted;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
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
