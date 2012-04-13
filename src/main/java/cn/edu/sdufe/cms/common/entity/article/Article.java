package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import cn.edu.sdufe.cms.common.entity.account.User;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import java.util.List;

/**
 * 文章Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:40
 */
@Entity
@Table(name = "cms_article")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Article extends PersistableEntity {

    private Category category;
    private Long categoryId;
    private String categoryName;
    private User user;
    private String author;
    private boolean top;
    private String subject;
    private String message;
    private String imageName;
    private String digest;
    private String keyword;
    private boolean status;
    private int rate;
    private int rateTimes;
    private boolean deleted;
    private boolean allowComment;
    private int views;
    private List<Comment> commentList = Lists.newArrayList();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinTable(name = "cms_category_article", joinColumns = {@JoinColumn(name = "article_id")}, inverseJoinColumns = {@JoinColumn(name = "category_id")})
    @Fetch(FetchMode.JOIN)
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Transient
    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinTable(name = "cms_user_article", joinColumns = {@JoinColumn(name = "article_id")}, inverseJoinColumns = {@JoinColumn(name = "user_id")})
    @Fetch(FetchMode.SELECT)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public boolean isTop() {
        return top;
    }

    public void setTop(boolean top) {
        this.top = top;
    }

    @NotBlank
    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    @NotBlank
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getDigest() {
        return digest;
    }

    public void setDigest(String digest) {
        this.digest = digest;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public int getRateTimes() {
        return rateTimes;
    }

    public void setRateTimes(int rateTimes) {
        this.rateTimes = rateTimes;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public boolean isAllowComment() {
        return allowComment;
    }

    public void setAllowComment(boolean allowComment) {
        this.allowComment = allowComment;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    @OneToMany(fetch = FetchType.LAZY) // 级联删除相关评论
    @JoinTable(name = "cms_comment", joinColumns = {@JoinColumn(name = "article_id")}, inverseJoinColumns = {@JoinColumn(name = "id")})
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("id DESC")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Comment> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<Comment> commentList) {
        this.commentList = commentList;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}