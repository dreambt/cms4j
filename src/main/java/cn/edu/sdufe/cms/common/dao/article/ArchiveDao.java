package cn.edu.sdufe.cms.common.dao.article;


import cn.edu.sdufe.cms.common.entity.article.Archive;
import com.google.common.collect.Maps;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 归类的Dao
 * <p/>
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-1
 * Time: 下午6:53
 */
@Component
public class ArchiveDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的archive
     */
    public Archive findOne(Long id) {
        return getSqlSession().selectOne("Archive.getArchive", id);
    }

    /**
     * 获取标题为title的archive
     */
    public Archive findByTitle(String title) {
        return getSqlSession().selectOne("Archive.getArchiveByTitle", title);
    }

    /**
     * 获得所有的archive
     *
     * @return
     */
    public List<Archive> findAll() {
        return getSqlSession().selectList("Archive.getAllArchive");
    }

    /**
     * 获得前十条归类信息
     *
     * @return
     */
    public List<Archive> getTopTen() {
        return getSqlSession().selectList("Archive.getTopTenArchive");
    }

    /**
     * 新增归档
     */
    public int save(Archive archive) {
        return getSqlSession().insert("Archive.saveArchive", archive);
    }

    /**
     * 新增归档文章对应表
     */
    public int saveAA(Long archiveId, Long articleId) {
        Map parameter = Maps.newHashMap();
        parameter.put("archiveId", archiveId);
        parameter.put("articleId", articleId);
        return getSqlSession().insert("Archive.saveAA", parameter);
    }

    /**
     *  删除归档
     */
    public int delete(Long id) {
        return getSqlSession().delete("Archive.deleteArchive", id);
    }

    /**
     * 删除归档文章对应表
     */
    public int deleteAAByArchiveId(Long archiveId) {
        return getSqlSession().delete("Archive.deleteAAByArchiveId", archiveId);
    }

    /**
     * 删除归档文章对应表
     */
    public int deleteAAByArticleId(List ids) {
        return getSqlSession().delete("Archive.deleteAAByArticleId", ids);
    }

    /**
     * 更新归档
     */
    public int updateArchive(Archive archive) {
        return getSqlSession().update("Archive.updateArchive", archive);
    }
}
