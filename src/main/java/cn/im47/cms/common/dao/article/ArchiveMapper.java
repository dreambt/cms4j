package cn.im47.cms.common.dao.article;


import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.article.Archive;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 归类的Dao
 * <p/>
 * User: pengfei.dongpf@gmail.com, baitao.jibt@gmail.com
 * Date: 12-4-1
 * Time: 下午6:53
 */
public interface ArchiveMapper extends GenericDao<Archive, Long> {

    /**
     * 获取标题为title的archive
     */
    Archive getByTitle(String title);

    /**
     * 获得前n条归类信息
     *
     * @return
     */
    List<Archive> list(Map<String, Object> parameters);

    /**
     * 新增相关文章
     */
    int addArticle(@Param("archiveId") Long archiveId, @Param("articleId") Long articleId);

    /**
     * 删除相关文章
     */
    int deleteArticle(@Param("archiveId") Long archiveId);

    int deleteArticle2(@Param("archiveId") Long archiveId, @Param("articleId") Long articleId);

}
