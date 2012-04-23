package cn.edu.sdufe.cms.common.entity.agency;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午3:28
 */
public class Teacher extends PersistableEntity {
    private String teacherName;
    private String introduction;
    private int articleId;
    private int agencyId;
    private String imageUrl;
    private boolean deleted;

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public int getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(int agencyId) {
        this.agencyId = agencyId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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
