package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryJpaDao;
import cn.edu.sdufe.cms.common.entity.article.Category;
import net.sf.ehcache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 分类的业务逻辑
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-22
 * Time: 上午11:03
 */
@Component
//默认将类中的所有public方法纳入事务管理中
@Transactional(readOnly = true)
public class CategoryManager {

    private static Logger logger = LoggerFactory.getLogger(CategoryManager.class);

    private CacheManager ehcacheManager;

    private CategoryDao categoryDao;
    private CategoryJpaDao categoryJpaDao;

    /**
     * 获得编号为id的分类
     *
     * @param id
     * @return
     */
    public Category get(Long id) {
        return categoryJpaDao.findOne(id);
    }

    /**
     * 获得编号为id的子分类
     *
     * @param id
     * @return
     */
    public List<Category> getSubCategory(Long id) {
        return categoryDao.getSubCategory(id);
    }

    /**
     * 获得导航栏显示的分类
     *
     * @return
     */
    public List<Category> getNavCategory() {
        //return categoryDao.getSubCategory(1L);
        return categoryJpaDao.findByIdGreaterThanAndFatherCategoryIdAndDeletedOrderByDisplayOrderAsc(1L, 1L, false);
    }

    /**
     * 获得允许发表文章的分类
     *
     * @return
     */
    public List getAllowPublishCategory() {
        return categoryDao.getAllowPublishCategory();
    }

    /**
     * 获得所有分类数量
     *
     * @return
     */
    public Long count() {
        return categoryDao.count();
    }

    /**
     * 获得编号为id的子分类数量
     *
     * @param id
     * @return
     */
    public Long count(Long id) {
        return categoryDao.count(id);
    }

    /**
     * 新建分类
     *
     * @param category
     * @return
     */
    @Transactional(readOnly = false)
    public Category save(Category category) {
        category.setDeleted(false);
        return update(category);
    }

    /**
     * 修改分类
     *
     * @param category
     * @return
     */
    @Transactional(readOnly = false)
    public Category update(Category category) {
        // 更新数据，先更新数据避免生成旧数据缓存
        category.setLastModifiedDate(null);
        categoryJpaDao.save(category);

        // 清理缓存
        this.cleanCache();

        return category;
    }

    /**
     * 删除编号为id的分类
     *
     * @param id
     * @return 0 删除成功；1 该分类有文章，不能删除；2 该分类的子分类有文章，不能删除；3 指定菜单不存在
     */
    public int delete(Long id) {
        Category category = this.get(id);
        return this.delete(category);
    }

    /**
     * 删除指定分类
     *
     * @param category
     * @return 0 删除成功；1 该分类有文章，不能删除；2 该分类的子分类有文章，不能删除；3 指定菜单不存在
     */
    @Transactional(readOnly = false)
    public int delete(Category category) {
        // 指定的分类不存在
        if (null == category) {
            return 3;
        }

        // 检查该分类下面的文章，如果有文章则不能删除
        if (category.getArticleList().size() > 0) {
            return 1;
        }

        // 检查该分类下面的子分类
        boolean flag = true;
        for (Category subCategory : category.getSubCategories()) {
            if (this.delete(subCategory) > 0) {
                flag = false;
            }
        }

        if (flag) {// 没有子分类
            category.setDeleted(true);
            this.update(category);
            return 0;
        } else {// 有子分类
            return 2;
        }
    }

    /**
     * 清理缓存
     */
    private void cleanCache() {
        ehcacheManager = CacheManager.create();
        ehcacheManager.getEhcache("cn.edu.sdufe.cms.common.entity.article.Category.subCategories").removeAll();
        ehcacheManager.getCache("cn.edu.sdufe.cms.common.entity.article.Category.articleList").removeAll();
        ehcacheManager.getCache("cn.edu.sdufe.cms.common.entity.article.Category").removeAll();
    }

    @Autowired
    public void setCategoryDao(@Qualifier("categoryDao") CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

    @Autowired
    public void setCategoryJpaDao(CategoryJpaDao categoryJpaDao) {
        this.categoryJpaDao = categoryJpaDao;
    }

}