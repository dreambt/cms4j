package cn.edu.sdufe.cms.common.dao.article;


import cn.edu.sdufe.cms.common.entity.article.Archive;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 归类的Dao
 *
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-1
 * Time: 下午6:53
 */
@Repository
public class ArchiveDao extends SqlSessionDaoSupport {

    public List<Archive> getTopTen() {
        return getSqlSession().selectList("CMS.getTopTen");
    }
}
