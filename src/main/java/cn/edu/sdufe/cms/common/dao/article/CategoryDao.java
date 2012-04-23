package cn.edu.sdufe.cms.common.dao.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import org.mybatis.spring.support.SqlSessionDaoSupport;
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
    public Category findOne(Long id) {
        return (Category) getSqlSession().selectOne("Category.getCategory", id);
    }

    /**
     * 获取所有可发表评论的分类列表
     *
     * @return
     */
    public List<Category> getAllowPublishCategory() {
        return getSqlSession().selectList("Category.getAllowPublishCategory");
    }

    /**
     * 获取编号为id的子分类
     *
     * @param id
     * @return
     */
    public List<Category> getSubCategory(Long id) {
        return getSqlSession().selectList("Category.getSubCategory", id);
    }

    /**
     * 获取导航分类
     *
     * @return
     */
    public List<Category> getNavCategory() {
        return getSqlSession().selectList("Category.getNavCategory");
    }

    /**
     * 获取分类的数量
     *
     * @return
     */
    public Long count() {
        return getSqlSession().selectOne("Category.getCount");
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
     * 创建分类
     *
     * @return
     */
    public int save(Category category) {
        return getSqlSession().insert("Category.saveCategory", category);
    }

    /**
     * 删除分类
     *
     * @return
     */
    public int delete() {
        return getSqlSession().delete("Category.deleteCategory");
    }

    /**
     * 更新分类
     *
     * @return
     */
    public int update(Category category) {
        return getSqlSession().update("Category.updateCategory", category);
    }

    /**
     * 搜索分类
     *
     * @param parameters
     * @return
     */
    public List<Category> search(Map<String, Object> parameters) {
        return getSqlSession().selectList("Category.searchCategory", parameters);
    }
}