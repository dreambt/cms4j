package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;
import org.springside.modules.utils.Collections3;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import java.util.List;

/**
 * 分类Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:42
 */
@Entity
@Table(name = "cms_category")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Category extends PersistableEntity {

    private Long fatherCategoryId;

    private String categoryName;

    private List<Category> subCategories = Lists.newArrayList();

    private List<Article> articleList = Lists.newArrayList();

    private boolean allowComment;

    private int displayOrder;

    private String url;

    private boolean deleted;

    private String description;

    private boolean allowPublish;

    private String showType;

    @Column(name = "father_category_id")
    public Long getFatherCategoryId() {
        return fatherCategoryId;
    }

    public void setFatherCategoryId(Long fatherCategoryId) {
        this.fatherCategoryId = fatherCategoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "cms_category", joinColumns = @JoinColumn(name = "father_category_id"), inverseJoinColumns = @JoinColumn(name = "id"))
    @Fetch(FetchMode.SUBSELECT)
    @WhereJoinTable(clause = "deleted='false'")
    @OrderBy("displayOrder ASC")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Category> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<Category> subCategories) {
        this.subCategories = subCategories;
    }

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "cms_category_article", joinColumns = @JoinColumn(name = "category_id"), inverseJoinColumns = @JoinColumn(name = "article_id"))
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy(value = "id DESC")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Article> getArticleList() {
        return articleList;
    }

    public void setArticleList(List<Article> articleList) {
        this.articleList = articleList;
    }

    public boolean isAllowComment() {
        return allowComment;
    }

    public void setAllowComment(boolean allowComment) {
        this.allowComment = allowComment;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isAllowPublish() {
        return allowPublish;
    }

    public void setAllowPublish(boolean allowPublish) {
        this.allowPublish = allowPublish;
    }

    @Enumerated(EnumType.STRING)
    public ShowTypeEnum getShowType() {
        return ShowTypeEnum.parse(this.showType);
    }

    public void setShowType(ShowTypeEnum showType) {
        this.showType = showType.getValue();
    }

    @Transient
    @JsonIgnore
    public String getArticleNames() {
        return Collections3.extractToString(articleList, "subject", ", ");
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}