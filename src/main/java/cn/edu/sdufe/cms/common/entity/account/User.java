package cn.edu.sdufe.cms.common.entity.account;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import cn.edu.sdufe.cms.utilities.IPEncodes;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import java.util.Date;

/**
 * 用户Entity
 * 使用JPA annotation定义ORM关系.
 * 使用Hibernate annotation定义JPA未覆盖的部分.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:55
 */
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
    private Group group;
    private Long lastIP;
    private String lastLoginIP;
    private Date lastTime;
    private Date lastActTime;

    public User() {
    }

    public User(Long id) {
        super.setId(id);
    }

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

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}