package cn.edu.sdufe.cms.common.entity;

import cn.edu.sdufe.cms.common.entity.account.User;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;

/**
 * 管理日志Entity
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午22:10
 */
@Entity
@Table(name = "cms_manage_log")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ManageLog extends IdEntity {

    private User user;

    private String action;

    private Date manageTime;

    private Date createTime;

    private Date modifyTime;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "user_id")
    @Fetch(FetchMode.JOIN)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Date getManageTime() {
        return manageTime;
    }

    public void setManageTime(Date manageTime) {
        this.manageTime = manageTime;
    }

    /**
     * 防止外部通过getter引用修改属性
     *
     * @return
     */
    public Date getCreateTime() {
        if (null != this.createTime) {
            return new Date(this.createTime.getTime());
        } else {
            return null;
        }
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}