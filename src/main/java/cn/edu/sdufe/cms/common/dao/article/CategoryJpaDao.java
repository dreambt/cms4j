package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * 文章 JPA Dao
 * <p/>
 * User: pengfei.dongpf (pengfei.dongpf@gmail.com)
 * Date: 12-3-22
 * Time: 下午3:55
 */
public interface CategoryJpaDao extends PagingAndSortingRepository<Category, Long> {

    /**
     * 通过顶级分类id查找子分类
     *
     * @param fatherCategoryId
     * @return
     */
    List<Category> findByIdGreaterThanAndFatherCategoryIdAndDeletedOrderByDisplayOrderAsc(Long id, Long fatherCategoryId, boolean deleted);

    /**
     * 查找在导航栏显示的分类
     *
     * @param showNav
     * @return
     */
    List<Category> findByFatherCategoryId(boolean showNav, Long fatherCategoryId);

    /**
     * 查找允许发表文章的分类
     *
     * @param allowPublish
     * @return
     */
    List<Category> findByAllowPublish(boolean allowPublish);

    /**
     * 查找允许评论的分类
     *
     * @param allowComment
     * @return
     */
    List<Category> findByAllowComment(boolean allowComment);

    /**
     * 查找已删除或未删除的分类
     *
     * @param deleted
     * @return
     */
    List<Category> findByDeleted(boolean deleted);

}