package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveDao;
import cn.edu.sdufe.cms.common.dao.article.ArchiveJpaDao;
import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.entity.article.Archive;
import cn.edu.sdufe.cms.common.entity.article.Article;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 归类业务逻辑层
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-31
 * Time: 下午4:46
 */
@Component
@Transactional(readOnly = true)
public class ArchiveManager {

    private static Logger logger = LoggerFactory.getLogger(ArchiveManager.class);

    private ArchiveJpaDao archiveJpaDao;

    private ArchiveDao archiveDao;

    private ArticleDao articleDao;

    /**
     * 获得所有归档
     *
     * @return
     */
    public List<Archive> getAll() {
        return (List<Archive>) archiveJpaDao.findAll();
    }

    /**
     * 获得最新10条的归类
     *
     * @return
     */
    public List<Archive> getTopTen() {
        return archiveDao.getTopTen();
    }

    /**
     * 获取标题为title的归类
     *
     * @param title
     * @return
     */
    public Archive getByTitle(String title) {
        return archiveJpaDao.findByTitle(title);
    }

    /**
     * 获取编号为id的归类
     *
     * @param id
     * @return
     */
    public Archive getByArchiveId(Long id) {
        return archiveJpaDao.findOne(id);
    }

    /**
     * 更新最近12个月份的归类
     */
    @Transactional(readOnly = false)
    public void update() {
        DateTime dateTime = new DateTime();
        int count = 12;
        while (count-- >= 0) {
            this.save(dateTime);
            dateTime.plusMonths(-1);
        }
    }

    /**
     * 保存指定月份的归类
     *
     * @param dateTime
     */
    @Transactional(readOnly = false)
    public void save(DateTime dateTime) {
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();
        Archive archive = this.getByTitle(String.format("%04d年%02d月", year, month));

        //获得指定月份的所有文章
        List<Article> articles = articleDao.getByMonth(dateTime.toDate());
        if (articles.size() > 0 && articles.size() != archive.getArticleCount()) {
            archive.setArticleCount(articles.size());
            archive.setArticleList(articles);
            archive.setLastModifiedDate(null);
            archiveJpaDao.save(archive);
        }
    }

    /**
     * 删除编号为id的归类
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void delete(Long id) {
        archiveJpaDao.delete(id);
    }

    @Autowired
    public void setArchiveJpaDao(@Qualifier("archiveJpaDao") ArchiveJpaDao archiveJpaDao) {
        this.archiveJpaDao = archiveJpaDao;
    }

    @Autowired(required = false)
    public void setArchiveDao(@Qualifier("archiveDao") ArchiveDao archiveDao) {
        this.archiveDao = archiveDao;
    }

    @Autowired(required = false)
    public void setArticleDao(@Qualifier("articleDao") ArticleDao articleDao) {
        this.articleDao = articleDao;
    }

}