package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.List;

/**
 * 归类功能
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-31
 * Time: 下午3:59
 */
public class Archive extends PersistableEntity {

    private String title;

    private int articleCount;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getArticleCount() {
        return articleCount;
    }

    public void setArticleCount(int articleCount) {
        this.articleCount = articleCount;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
