package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveMapper;
import cn.edu.sdufe.cms.common.dao.article.ArticleMapper;
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

    private static final Logger logger = LoggerFactory.getLogger(ArchiveManager.class);

    private ArchiveMapper archiveMapper;
    private ArticleMapper articleMapper;

    /**
     * 获得所有归档
     *
     * @return
     */
    public List<Archive> getAll() {
        return archiveMapper.getAll();
    }

    /**
     * 获得最新10条的归类
     *
     * @return
     */
    public List<Archive> getTopTen() {
        return archiveMapper.getTopTen();
    }

    /**
     * 获取编号为id的归类
     *
     * @param id
     * @return
     */
    public Archive getByArchiveId(Long id) {
        return archiveMapper.get(id);
    }

    /**
     * 通过archive编号获得文章编号
     *
     * @param archiveId
     * @return
     */
    public List<Long> getArticleIdByArchiveId(Long archiveId, int offset, int limit) {
        return archiveMapper.getArticleIdByArchiveId(archiveId, offset, limit);
    }

    /**
     * 保存上个月的归类
     */
    @Transactional(readOnly = false)
    public void save() {
        DateTime dateTime = new DateTime();
        dateTime = dateTime.plusMonths(-1);
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();

        String title = String.format("%04d年%02d月", year, month);
        if (null != archiveMapper.getByTitle(title)) {
            return;
        }

        //获得指定月份的所有文章
        List<Article> articles = articleMapper.getByMonth(dateTime.toDate());
        if (articles.size() > 0) {
            Archive archive = new Archive();
            archive.setTitle(title);
            archive.setArticleCount(articles.size());
            archiveMapper.save(archive);
            //加入归档文章对应表
            Long archiveId = archiveMapper.getByTitle(String.format("%04d年%02d月", year, month)).getId();
            for (Article article : articles) {
                Long articleId = article.getId();
                archiveMapper.saveAA(archiveId, articleId);
            }
        }
    }

    /**
     * 保存指定月份的归档
     *
     * @param dateTime
     */
    @Transactional(readOnly = false)
    public void save(DateTime dateTime) {
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();

        String title = String.format("%04d年%02d月", year, month);
        if (null != archiveMapper.getByTitle(title)) {
            return;
        }

        //获得指定月份的所有文章
        List<Article> articles = articleMapper.getByMonth(dateTime.toDate());
        if (articles.size() > 0) {
            Archive archive = new Archive();
            archive.setTitle(title);
            archive.setArticleCount(articles.size());
            archiveMapper.save(archive);
            //加入归档文章对应表
            Long archiveId = archiveMapper.getByTitle(String.format("%04d年%02d月", year, month)).getId();
            for (Article article : articles) {
                Long articleId = article.getId();
                archiveMapper.saveAA(archiveId, articleId);
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
        archiveMapper.delete(id);
    }

    /**
     * 更新归类
     */
    @Transactional(readOnly = false)
    public void update(Archive archive) {
        List<Long> archives = archiveMapper.getAllArticleIdByArchiveId(archive.getId());
        if (null == archives || 0 == archives.size()) {
            archiveMapper.delete(archive.getId());
        } else if (archive.getArticleCount() != archives.size()) {
            archiveMapper.update(archive);
        }
    }

    /**
     * 更新归类
     */
    @Transactional(readOnly = false)
    public void batchUpdate() {
        List<Archive> archives = archiveMapper.getAll();
        if (null != archives) {
            for (Archive archive : archives) {
                this.update(archive);
            }
        }
    }

    @Autowired
    public void setArchiveMapper(@Qualifier("archiveMapper") ArchiveMapper archiveMapper) {
        this.archiveMapper = archiveMapper;
    }

    @Autowired
    public void setArticleMapper(@Qualifier("articleMapper") ArticleMapper articleMapper) {
        this.articleMapper = articleMapper;
    }
}