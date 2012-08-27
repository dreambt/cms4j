package cn.edu.sdufe.cms.common.entity.link;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.io.Serializable;

/**
 * link实体类
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:25
 */
public class Link extends PersistableEntity implements Serializable {

    private static final long serialVersionUID = -4082457458619235440L;

    private String title;
    private String url;
    private boolean status;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
