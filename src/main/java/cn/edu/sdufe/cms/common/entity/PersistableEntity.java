package cn.edu.sdufe.cms.common.entity;

import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

/**
 * 统一定义的entity基类.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:55
 */
@MappedSuperclass
public abstract class PersistableEntity extends IdEntity {

    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Temporal(TemporalType.TIMESTAMP)
    private Date lastModifiedDate;

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(final Date createdDate) {
        this.createdDate = null == createdDate ? null : createdDate;
    }

    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate(final Date lastModifiedDate) {
        this.lastModifiedDate = null == lastModifiedDate ? null : lastModifiedDate;
    }

    //    @Type(type = "org.jadira.usertype.dateandtime.joda.PersistentDateTime")
//    public DateTime getCreatedDate() {
//        return null == createdDate ? null : new DateTime(createdDate);
//    }
//
//    public void setCreatedDate(final DateTime createdDate) {
//        this.createdDate = null == createdDate ? null : createdDate.toDate();
//    }
//
//    @Type(type = "org.jadira.usertype.dateandtime.joda.PersistentDateTime")
//    public DateTime getLastModifiedDate() {
//        return null == lastModifiedDate ? null : new DateTime(lastModifiedDate);
//    }
//
//    public void setLastModifiedDate(final DateTime lastModifiedDate) {
//        this.lastModifiedDate = null == lastModifiedDate ? null : lastModifiedDate.toDate();
//    }

}