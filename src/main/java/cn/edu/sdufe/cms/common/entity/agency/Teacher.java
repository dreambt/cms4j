package cn.edu.sdufe.cms.common.entity.agency;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import cn.edu.sdufe.cms.common.entity.article.Article;
import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午3:28
 */
public class Teacher extends PersistableEntity {

    private String teacherName;
    private boolean top;
    private Article article;
    private Agency agency;
    private String imageUrl;
    private boolean deleted;

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public boolean isTop() {
        return top;
    }

    public void setTop(boolean top) {
        this.top = top;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
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
