package cn.im47.cms.common.entity.category;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.commons.entity.PersistableEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springside.modules.utils.Collections3;

import java.io.Serializable;
import java.util.List;

/**
 * 分类Entity
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-20
 * Time: 下午19:42
 */
public class Category extends PersistableEntity implements Serializable {

    private static final long serialVersionUID = -4082457458619235449L;

    private Long fatherCategoryId;
    private String categoryName;
    private List<Category> subCategories = Lists.newArrayList();
    private List<Article> articleList = Lists.newArrayList();
    private boolean allowComment;
    private int displayOrder;
    private String url;
    private boolean showNav;
    private boolean deleted;
    private String description;
    private boolean allowPublish;
    private String showType;

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

    public List<Category> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<Category> subCategories) {
        this.subCategories = subCategories;
    }

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

    public boolean isShowNav() {
        return showNav;
    }

    public void setShowNav(boolean showNav) {
        this.showNav = showNav;
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

    public ShowTypeEnum getShowType() {
        return ShowTypeEnum.parse(this.showType);
    }

    public void setShowType(ShowTypeEnum showType) {
        this.showType = showType.getValue();
    }

    @JsonIgnore
    public String getArticleNames() {
        return Collections3.extractToString(articleList, "subject", ", ");
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
