package cn.edu.sdufe.cms.common.dao.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * image类jpa dao
 *
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午8:05
 */
public interface ImageJpaDao extends PagingAndSortingRepository<Image, Long> {

    /**
     * 通过删除标记查找image
     *
     * @return
     */
    List<Image> findByDeleted(boolean deleted);
}
