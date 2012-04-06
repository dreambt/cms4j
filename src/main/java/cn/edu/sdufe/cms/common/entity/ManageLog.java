package cn.edu.sdufe.cms.common.entity;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Entity;
import javax.persistence.Table;
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
public class ManageLog extends PersistableEntity {

    private String action;

    private Date manageTime;

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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}