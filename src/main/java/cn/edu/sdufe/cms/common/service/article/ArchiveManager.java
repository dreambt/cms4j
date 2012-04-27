package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveDao;
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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    private static final Logger logger = LoggerFactory.getLogger(ArchiveManager.class);

    private ArchiveDao archiveDao;
    private ArticleDao articleDao;

    /**
     * 获得所有归档
     *
     * @return
     */
    public List<Archive> getAll() {
        return archiveDao.findAll();
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
     * 获取编号为id的归类
     *
     * @param id
     * @return
     */
    public Archive getByArchiveId(Long id) {
        return archiveDao.findOne(id);
    }

    /**
     * 通过archive编号获得文章编号
     *
     * @param archiveId
     * @return
     */
    public List<Long> getArticleIdByArchiveId(Long archiveId, int offset, int limit) {
        return archiveDao.getArticleIdByArchiveId(archiveId, offset, limit);
    }

    /**
     * 保存指定月份的归类
     *
     */
    @Transactional(readOnly = false)
    public void save() {
        DateTime dateTime = new DateTime();
        dateTime = dateTime.plusMonths(-1);
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();

        //获得指定月份的所有文章
        List<Article> articles = articleDao.findByMonth(dateTime.toDate());
        if (articles.size() > 0) {
            Archive archive = new Archive();
            archive.setTitle(String.format("%04d年%02d月", year, month));
            archive.setArticleCount(articles.size());
            archiveDao.save(archive);
            //加入归档文章对应表
            Long archiveId = archiveDao.findByTitle(String.format("%04d年%02d月", year, month)).getId();
            for(Article article: articles) {
                Long articleId = article.getId();
                archiveDao.saveAA(archiveId, articleId);
            }
        }
    }

    /**
     * 删除编号为id的归类
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void delete(Long id) {
        archiveDao.delete(id);
    }

    /**
     * 更新指定月份的归类
     */
    @Transactional(readOnly = false)
    public void update(Archive archive) {
        String month = archive.getTitle();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月");
        Date date = null;
        try {
            date = sdf.parse(month);
        } catch (ParseException e) {
            logger.error(e.getMessage());
        }

        List<Article> articles = articleDao.findByMonth(date);
        if(null == articles || articles.size() == 0) {
            archiveDao.delete(archive.getId());
        }
        if(articles.size() > 0 && archive.getArticleCount() != articles.size()) {
            archive.setArticleCount(articles.size());
            archiveDao.updateArchive(archive);
        }
    }

    /**
     * 更新归类
     */
    @Transactional(readOnly = false)
    public void batchUpdate() {
        List<Archive> archives = archiveDao.findAll();
        if(null == archives) {
            return;
        }
        for(Archive archive: archives) {
            this.update(archive);
        }
    }

    @Autowired
    public void setArchiveDao(@Qualifier("archiveDao") ArchiveDao archiveDao) {
        this.archiveDao = archiveDao;
    }

    @Autowired
    public void setArticleDao(@Qualifier("articleDao") ArticleDao articleDao) {
        this.articleDao = articleDao;
    }
}