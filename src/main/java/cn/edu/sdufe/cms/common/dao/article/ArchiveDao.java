package cn.edu.sdufe.cms.common.dao.article;


import cn.edu.sdufe.cms.common.entity.article.Archive;
import org.mybatis.spring.support.SqlSessionDaoSupport;
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
public class ArchiveDao extends SqlSessionDaoSupport {

    /**
     * 获得前十条归类信息
     *
     * @return
     */
    public List<Archive> getTopTen() {
        return getSqlSession().selectList("Archive.getTopTen");
    }
}
