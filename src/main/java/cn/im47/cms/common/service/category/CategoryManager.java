package cn.im47.cms.common.service.category;

import cn.im47.cms.common.entity.category.Category;
import cn.im47.cms.common.service.GenericManager;

import java.util.List;

/**
 * 分类 Manager 接口
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-12
 * Time: 下午3:24
 */
public interface CategoryManager extends GenericManager<Category, Long> {

    /**
     * 获得编号为id的子分类
     *
     * @param id
     * @return
     */
    List<Category> getSubCategory(Long id);

    /**
     * 获得导航栏显示的分类
     *
     * @return
     */
    List<Category> getNavCategory();

    /**
     * 获得允许发表文章的分类
     *
     * @return
     */
    List<Category> getAllowPublishCategory();

    long count();

    /**
     * 获得分类id的子分类数量
     *
     * @param id
     * @return
     */
    long count(Long id);

    /**
     * 删除指定分类
     *
     * @param category
     * @return 0 删除成功；1 该分类有文章，不能删除；2 该分类的子分类有文章，不能删除；3 指定菜单不存在
     */
    long delete(Category category);

}
