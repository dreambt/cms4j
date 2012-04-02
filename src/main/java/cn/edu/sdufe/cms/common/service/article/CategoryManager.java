package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryJpaDao;
import cn.edu.sdufe.cms.common.entity.article.Category;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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

    private CategoryDao categoryDao;

    private CategoryJpaDao categoryJpaDao;

    /**
     * 获得编号为id的分类
     *
     * @param id
     * @return
     */
    public Category getCategory(Long id) {
        return (Category) categoryJpaDao.findOne(id);
    }

    /**
     * 获得编号为id的子分类
     *
     * @param id
     * @return
     */
    public List<Category> getSubCategory(Long id) {
        if (id.equals(0L)) {
            return (List<Category>) this.getAllFatherCategory();
        } else {
            return (List<Category>) categoryJpaDao.findByFatherCategoryIdAndDeletedAndIdGreaterThanOrderByDisplayOrderAsc(id, false,0L);
        }
    }

    /**
     * 获得顶级分类
     *
     * @return
     */
    public List<Category> getAllFatherCategory() {
        return (List<Category>) categoryJpaDao.findByFatherCategoryIdAndDeletedAndIdGreaterThanOrderByDisplayOrderAsc(0L, false, 0L);
    }

    /**
     * 获得导航栏显示的分类
     *
     * @return
     */
    public List<Category> getNavCategory() {
        return categoryJpaDao.findByShowNavAndFatherCategoryId(true,0L);
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
     * 查找允许评论的分类
     *
     * @return
     */
    public List<Category> getAllowCommentCategory() {
        return (List<Category>) categoryJpaDao.findByAllowComment(true);
    }

    /**
     * 获得编号为id的子分类数量
     *
     * @param id
     * @return
     */
    public Long getCount(Long id) {
        return (Long) categoryJpaDao.count();
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
        category.setCreateTime(new Date());
        category.setModifyTime(new Date());
        categoryJpaDao.save(category);
        return category;
    }

    /**
     * 修改分类
     *
     * @param category
     * @return
     */
    @Transactional(readOnly = false)
    public Category update(Category category) {
        category.setModifyTime(new Date());
        return categoryJpaDao.save(category);
    }

    /**
     * 删除编号为id的分类
     *
     * @param id
     * @return
     */
    @Transactional(readOnly = false)
    public void delete(Long id) {
        categoryJpaDao.delete(id);
    }

    /**
     * 批量删除
     *
     * @param categories
     * @return
     */
    @Transactional(readOnly = false)
    public void delete(List<Category> categories) {
        categoryJpaDao.delete(categories);
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
