package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Archive;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 归类jpa dao
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-31
 * Time: 下午4:34
 */
public interface ArchiveJpaDao extends PagingAndSortingRepository<Archive, Long> {

    /**
     * 根据title查找归类信息
     *
     * @param title
     * @return
     */
    Archive findByTitle(String title);
}
