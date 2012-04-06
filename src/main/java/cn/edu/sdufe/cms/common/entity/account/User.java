package cn.edu.sdufe.cms.common.entity.account;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.utilities.IPEncodes;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springside.modules.utils.Collections3;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 用户Entity
 * 使用JPA annotation定义ORM关系.
 * 使用Hibernate annotation定义JPA未覆盖的部分.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:55
 */
@Entity
//表名与类名不相同时重新定义表名.
@Table(name = "cms_user")
//默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User extends PersistableEntity {

    private String email;

    private String username;

    private String plainPassword;

    private String password;

    private String salt;

    private boolean status;

    private boolean emailStatus;

    private boolean avatarStatus;

    private boolean deleted;

    private String photoURL;

    private String timeOffset;

    private List<Group> groupList = Lists.newArrayList(); //有序的关联对象集合

    private List<Article> articleList = Lists.newArrayList();

    private Long lastIP;

    private String lastLoginIP;

    private Date lastTime;

    private Date lastActTime;

    @Email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @NotBlank
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Transient
    public String getPlainPassword() {
        return plainPassword;
    }

    public void setPlainPassword(String plainPassword) {
        this.plainPassword = plainPassword;
    }

    @NotBlank
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @NotBlank
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isEmailStatus() {
        return emailStatus;
    }

    public void setEmailStatus(boolean emailStatus) {
        this.emailStatus = emailStatus;
    }

    public boolean isAvatarStatus() {
        return avatarStatus;
    }

    public void setAvatarStatus(boolean avatarStatus) {
        this.avatarStatus = avatarStatus;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getPhotoURL() {
        return photoURL;
    }

    public void setPhotoURL(String photoURL) {
        this.photoURL = photoURL;
    }

    public String getTimeOffset() {
        return timeOffset;
    }

    public void setTimeOffset(String timeOffset) {
        this.timeOffset = timeOffset;
    }

    public Long getLastIP() {
        return lastIP;
    }

    public void setLastIP(Long lastIP) {
        this.lastIP = lastIP;
    }

    @Transient
    public String getLastLoginIP() {
        return IPEncodes.longToIp(lastIP);
    }

    public void setLastLoginIP(String lastLoginIP) {
        this.lastIP = IPEncodes.ipToLong(lastLoginIP);
    }

    public Date getLastTime() {
        return lastTime;
    }

    public void setLastTime(Date lastTime) {
        this.lastTime = lastTime;
    }

    public Date getLastActTime() {
        return lastActTime;
    }

    public void setLastActTime(Date lastActTime) {
        this.lastActTime = lastActTime;
    }

    //多对多定义
    @ManyToMany
    //中间表定义,表名采用默认命名规则
    @JoinTable(name = "cms_user_group", joinColumns = {@JoinColumn(name = "user_id")}, inverseJoinColumns = {@JoinColumn(name = "group_id")})
    //Fecth策略定义
    @Fetch(FetchMode.SUBSELECT)
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Group> getGroupList() {
        return groupList;
    }

    public void setGroupList(List<Group> groupList) {
        this.groupList = groupList;
    }

    @OneToMany(orphanRemoval = true, fetch = FetchType.LAZY)
    @JoinTable(name = "cms_user_article", joinColumns = {@JoinColumn(name = "user_id")}, inverseJoinColumns = {@JoinColumn(name = "article_id")})
    @Fetch(FetchMode.SUBSELECT)
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Article> getArticleList() {
        return articleList;
    }

    public void setArticleList(List<Article> articleList) {
        this.articleList = articleList;
    }

    @Transient
    @JsonIgnore
    public String getGroupNames() {
        return Collections3.extractToString(groupList, "groupName", ",");
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}