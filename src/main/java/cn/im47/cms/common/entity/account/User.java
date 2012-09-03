package cn.im47.cms.common.entity.account;

import cn.im47.commons.entity.PersistableEntity;
import cn.im47.commons.utilities.encoder.IPEncodes;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.joda.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.joda.ser.LocalDateTimeSerializer;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.joda.time.LocalDateTime;
import org.springside.modules.utils.Collections3;

import java.io.Serializable;
import java.util.List;

/**
 * 用户Entity
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:55
 */
public class User extends PersistableEntity implements Serializable {

    private static final long serialVersionUID = -4082457458619235442L;

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
    private List<Group> groupList = Lists.newArrayList();
    private Long lastIP;
    private String lastLoginIP;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime lastTime;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime lastActTime;

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

    public LocalDateTime getLastTime() {
        return lastTime;
    }

    public void setLastTime(LocalDateTime lastTime) {
        this.lastTime = lastTime;
    }

    public LocalDateTime getLastActTime() {
        return lastActTime;
    }

    public void setLastActTime(LocalDateTime lastActTime) {
        this.lastActTime = lastActTime;
    }

    public List<Group> getGroupList() {
        return groupList;
    }

    public void setGroupList(List<Group> groupList) {
        this.groupList = groupList;
    }

    /**
     * 用户拥有的权限组名称字符串, 多个权限组名称用','分隔.
     */
    public String getGroupNames() {
        return Collections3.extractToString(groupList, "groupName", ", ");
    }

    @JsonIgnore
    public Long getGroupId() {
        return groupList.get(0).getId();
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
