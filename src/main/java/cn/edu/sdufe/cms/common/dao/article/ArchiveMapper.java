package cn.edu.sdufe.cms.common.dao.article;


import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.article.Archive;
import cn.edu.sdufe.cms.common.entity.article.Article;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 归类的Dao
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-1
 * Time: 下午6:53
 */
@Component
public interface ArchiveMapper extends GenericDao<Archive, Long> {

    List<Archive> getAll();

    /**
     * 获取标题为title的archive
     */
    Archive getByTitle(String title);

    /**
     * 获得前十条归类信息
     *
     * @return
     */
    List<Archive> getTopTen();

    /**
     * 根据归档编号获得文章编号，分页
     *
     * @return
     */
    List<Long> getArticleIdByArchiveId(Long archiveId, int offset, int limit);

    /**
     * 根据归档编号获得文章编号
     *
     * @return
     */
    List<Long> getAllArticleIdByArchiveId(Long archiveId);

    /**
     * 新增归档文章对应表
     */
    int saveAA(Long archiveId, Long articleId);

    /**
     * 删除归档文章对应表
     */
    int deleteAAByArchiveId(Long archiveId);

    /**
     * 删除归档文章对应表
     */
    int deleteAAByArticleId(List<Article> articleList);

}
