package cn.edu.sdufe.cms.common.dao.article;


import cn.edu.sdufe.cms.common.entity.article.Archive;
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
     * 新增图片
     */
    public int save(Archive archive) {
        return getSqlSession().insert("Archive.saveArchive", archive);
    }

    /**
     * 删除图片
     */
    public int delete(Long id) {
        return getSqlSession().delete("Archive.deleteArchive", id);
    }

    /**
     * 更新图片
     */
    public int update(Archive archive) {
        return getSqlSession().update("Archive.updateArchive", archive);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    public List<Archive> search(Map<String, Object> parameters) {
        RowBounds rowBounds = new RowBounds(0, 10);
        return getSqlSession().selectList("Archive.searchArchive", parameters, rowBounds);
    }

    /**
     * 搜索图片
     *
     * @param parameters
     * @return
     */
    public List<Archive> search(Map<String, Object> parameters, RowBounds rowBounds) {
        return getSqlSession().selectList("Archive.searchArchive", parameters, rowBounds);
    }
}
