package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveDao;
import cn.edu.sdufe.cms.common.dao.article.ArchiveJpaDao;
import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.entity.article.Archive;
import cn.edu.sdufe.cms.common.entity.article.Article;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 归类业务逻辑层
 *
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
     * 获得所有归档信息
     *
     * @return
     */
    public List<Archive> getAllArchive(){
        return (List<Archive>)archiveJpaDao.findAll();
    }

    /**
     * 获得最新10条的归类信息
     *
     * @return
     */
    public List<Archive> getTopTenArchive() {
        return archiveDao.getTopTen();
    }

    /**
     * 获取标题为title的归类信息
     *
     * @param title
     * @return
     */
    public Archive getArchiveByTitle(String title) {
        return archiveJpaDao.findByTitle(title);
    }

    /**
     * 获取编号为id的归类信息
     *
     * @param id
     * @return
     */
    public Archive getArchiveByArchiveId(Long id) {
        return archiveJpaDao.findOne(id);
    }

    /**
     * 添加指定月份的归类记录
     */
    @Transactional(readOnly = false)
    public void addArchive(Date archiveMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(archiveMonth);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        //获得指定月份的所有文章
        List<Article> articles = articleDao.getMonthArticle(archiveMonth);
        if(articles.size()<=0) {
            return;
        } else {
            Archive archive = new Archive();
            archive.setTitle(year + "年" + month + "月");
            archive.setArticleCount(articles.size());
            archive.setCreateTime(new Date());
            archive.setModifyTime(new Date());
            archive.setArticleList(articles);
            archiveJpaDao.save(archive);
        }
    }

    /**
     * 更新指定月份的归类信息
     *
     * @param archiveMonth
     */
    @Transactional(readOnly = false)
    public void updateArchive(Date archiveMonth){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(archiveMonth);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH)+1;
        String title = String.valueOf(year).trim() + "年" + String.valueOf(month).trim() + "月";
        Archive archive = this.getArchiveByTitle(title);
        //获得指定月份的所有文章
        List<Article> articles = articleDao.getMonthArticle(archiveMonth);
        if(articles.size()<=0) {
            deleteArchive(archive.getId());
        } else {
            archive.setArticleCount(articles.size());
            archive.setModifyTime(new Date());
            archive.setArticleList(articles);
            archiveJpaDao.save(archive);
        }
    }

    /**
     * 删除编号为id的归类记录
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void deleteArchive(Long id) {
        archiveJpaDao.delete(id);
    }

    @Autowired
    public void setArchiveJpaDao(ArchiveJpaDao archiveJpaDao) {
        this.archiveJpaDao = archiveJpaDao;
    }

    @Autowired(required = false)
    public void setArchiveDao(ArchiveDao archiveDao) {
        this.archiveDao = archiveDao;
    }

    @Autowired(required = false)
    public void setArticleDao(@Qualifier("articleDao") ArticleDao articleDao) {
        this.articleDao = articleDao;
    }
}
