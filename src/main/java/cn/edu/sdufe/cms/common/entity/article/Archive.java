package cn.edu.sdufe.cms.common.entity.article;

import cn.edu.sdufe.cms.common.entity.PersistableEntity;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

/**
 * 归类功能
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-31
 * Time: 下午3:59
 */
@Entity
@Table(name = "cms_archive")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Archive extends PersistableEntity {

    private String title;

    private int articleCount;

    private List<Article> articleList = Lists.newArrayList();

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

    @OneToMany(orphanRemoval = true, fetch = FetchType.LAZY)
    @JoinTable(name = "cms_archive_article", joinColumns = @JoinColumn(name = "archive_id"), inverseJoinColumns = @JoinColumn(name = "article_id"))
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy(value = "id DESC")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Article> getArticleList() {
        return articleList;
    }

    public void setArticleList(List<Article> articleList) {
        this.articleList = articleList;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
