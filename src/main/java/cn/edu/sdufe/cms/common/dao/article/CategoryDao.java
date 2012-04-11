package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 分类Dao
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:40
 */
@Component
public class CategoryDao extends SqlSessionDaoSupport {

    /**
     * 获取编号为id的分类
     *
     * @param id
     * @return
     */
    @Cacheable(value = "category")
    public Category get(Long id) {
        return (Category) getSqlSession().selectOne("Category.getCategory", id);
    }

    /**
     * 通过名称获得分类
     * @param name
     * @return
     */
    @Cacheable(value = "categroyByName")
    public Category getCategoryByName(String name) {
        return (Category) getSqlSession().selectOne("Category.getCategoryByName", name);
    }

    /**
     * 获取所有可发表评论的分类列表
     *
     * @return
     */
    @Cacheable(value = "allowPublishCategory")
    public List<Category> getAllowPublishCategory() {
        return getSqlSession().selectList("Category.getAllowPublishCategory");
    }

    /**
     * 获取编号为id的子分类
     *
     * @param id
     * @return
     */
    @Cacheable(value = "subCategory")
    public List<Category> getSubCategory(Long id) {
        return getSqlSession().selectList("Category.getSubCategory", id);
    }

    /**
     * 获取分类的数量
     *
     * @return
     */
    public Long count() {
        return getSqlSession().selectOne("Category.getCategoryCount");
    }

    /**
     * 获取分类id的子分类数量
     *
     * @param id
     * @return
     */
    public Long count(Long id) {
        return getSqlSession().selectOne("Category.getCountByFatherCategoryId", id);
    }

    /**
     * 搜索分类
     *
     * @param parameters
     * @return
     */
    public Category search(Map<String, Object> parameters) {
        return getSqlSession().selectOne("Category.searchCategory", parameters);
    }

    /**
     * 创建分类
     *
     * @return
     */
    public Category save(Category category) {
        getSqlSession().insert("Category.saveCategory", category);
        return category;
    }

    /**
     * 更新分类
     *
     * @return
     */
    public Category update(Category category) {
        getSqlSession().update("Category.updateCategory", category);
        return category;
    }

    /**
     * 删除编号为id的分类
     *
     * @param id
     * @return
     */
    public int delete(Long id) {
        return getSqlSession().delete("Category.deleteCategory", id);
    }
}