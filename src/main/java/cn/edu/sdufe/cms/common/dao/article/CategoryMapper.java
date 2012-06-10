package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.article.Category;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 分类Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:40
 */
@Component
public interface CategoryMapper extends GenericDao<Category, Long> {

    /**
     * 获取所有可发表评论的分类列表
     *
     * @return
     */
    List<Category> getAllowPublishCategory();

    /**
     * 获取编号为id的子分类
     *
     * @param id
     * @return
     */
    List<Category> getSubCategory(Long id);

    /**
     * 获取导航分类
     *
     * @return
     */
    List<Category> getNavCategory();

    /**
     * 获取分类id的子分类数量
     *
     * @param id
     * @return
     */
    Long countByFatherCategoryId(Long id);

}