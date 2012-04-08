package cn.edu.sdufe.cms.common.dao.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * link Jpa dao
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:54
 */
public interface LinkJpaDao extends PagingAndSortingRepository<Link, Long> {

    /**
     * 查找所有未删除的link
     *
     * @param deleted
     * @return
     */
    List<Link> findByDeleted(boolean deleted);
}
