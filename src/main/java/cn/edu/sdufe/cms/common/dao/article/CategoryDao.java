package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 分类Dao
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午20:40
 */
@Component
public class CategoryDao extends SqlSessionDaoSupport {

    /**
     * 获取导航栏
     *
     * @return
     */
    public List<Category> getNavCategory() {
        return getSqlSession().selectList("CMS.getNavCategory");
    }

    /**
     * 获取编号为id的分类
     *
     * @param id
     * @return
     */
    @Cacheable(value = "category")
    public Category getCategory(Long id) {
        return (Category) getSqlSession().selectOne("CMS.getCategory", id);
    }

    /**
     * 获取所有可发表评论的分类列表
     *
     * @return
     */
    @Cacheable(value = "allowPublishCategory")
    public List<Category> getAllowPublishCategory() {
        return getSqlSession().selectList("CMS.getAllowPublishCategory");
    }

    /**
     * 获取编号为id的子分类
     *
     * @param id
     * @return
     */
    @Cacheable(value = "subCategory")
    public List<Category> getSubCategory(Long id) {
        return getSqlSession().selectList("CMS.getSubCategory", id);
    }

    /**
     * 获取子分类数量
     *
     * @return
     */
    public Long getCount(Long id) {
        return getSqlSession().selectOne("CMS.getCategoryCount", id);
    }

    /**
     * 搜索分类
     *
     * @param parameters
     * @return
     */
    public Category search(Map<String, Object> parameters) {
        return getSqlSession().selectOne("CMS.searchCategory", parameters);
    }

    /**
     * 创建分类
     *
     * @return
     */
    public Category save(Category category) {
        getSqlSession().insert("CMS.saveCategory", category);
        return category;
    }

    /**
     * 更新分类
     *
     * @return
     */
    public Category update(Category category) {
        getSqlSession().update("CMS.updateCategory", category);
        return category;
    }

    /**
     * 删除编号为id的分类
     *
     * @param id
     * @return
     */
    public int delete(Long id) {
        return getSqlSession().delete("CMS.deleteCategory", id);
    }
}