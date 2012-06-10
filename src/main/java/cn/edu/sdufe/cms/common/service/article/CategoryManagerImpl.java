package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.CategoryMapper;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;

import java.util.List;

/**
 * 分类 Manager 实现类
 * User: pengfei.dongpf@gmail.com, baitao.jibt@gmail.com
 * Date: 12-3-22
 * Time: 上午11:03
 */
@Component
//默认将类中的所有public方法纳入事务管理中
@Transactional(readOnly = true)
public class CategoryManagerImpl implements CategoryManager {

    private static final Logger logger = LoggerFactory.getLogger(CategoryManager.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private CategoryMapper categoryMapper;

    @Override
    public Category get(Long id) {
        Category category = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.CATEGORY.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            category = categoryMapper.get(id);
            jsonString = jsonMapper.toJson(category);
            spyMemcachedClient.set(key, MemcachedObjectType.CATEGORY.getExpiredTime(), jsonString);
        } else {
            category = jsonMapper.fromJson(jsonString, Category.class);
        }
        long end = System.currentTimeMillis();
        logger.debug("获取分类 #{} 用时：{}ms. key: " + key, id, end - start);
        return category;
    }

    @Override
    public List<Category> getSubCategory(Long id) {
        List<Category> categoryList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.CATEGORY.getPrefix() + "subCategory:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            categoryList = categoryMapper.getSubCategory(id);
            jsonString = jsonMapper.toJson(categoryList);
            spyMemcachedClient.set(key, MemcachedObjectType.CATEGORY.getExpiredTime(), jsonString);
        } else {
            categoryList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Category.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取分类 {} 的子分类用时：{}ms. key: " + key, end - start);
        return categoryList;
    }

    @Override
    public List<Category> getNavCategory() {
        List<Category> categoryList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.CATEGORY.getPrefix() + "navCategory";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            categoryList = categoryMapper.getNavCategory();
            jsonString = jsonMapper.toJson(categoryList);
            spyMemcachedClient.set(key, MemcachedObjectType.CATEGORY.getExpiredTime(), jsonString);
        } else {
            categoryList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Category.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取导航分类用时：{}ms. key: " + key, end - start);
        return categoryList;
    }

    @Override
    public List<Category> getAllowPublishCategory() {
        List<Category> categoryList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.CATEGORY.getPrefix() + "allowCategory";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            categoryList = categoryMapper.getAllowPublishCategory();
            jsonString = jsonMapper.toJson(categoryList);
            spyMemcachedClient.set(key, MemcachedObjectType.CATEGORY.getExpiredTime(), jsonString);
        } else {
            categoryList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Category.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取允许发表文章的分类用时：{}ms. key: " + key, end - start);
        return categoryList;
    }

    @Override
    public long count() {
        long num = 0L;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.CATEGORY.getPrefix() + "count";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = categoryMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.CATEGORY.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.debug("获取分类数用时：{}ms. key: " + key, end - start);
        return num;
    }

    @Override
    public long count(Long id) {
        long num = 0L;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.ARTICLE.getPrefix() + "count:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = categoryMapper.countByFatherCategoryId(id);
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.ARTICLE.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.debug("获取分类 {} 的子分类数用时：{}ms. key: " + key, id, end - start);
        return num;
    }

    @Transactional(readOnly = false)
    public long save(Category category) {
        logger.info("保存分类 category={}.", category.toString());
        return categoryMapper.save(category);
    }

    @Transactional(readOnly = false)
    public long update(Category category) {
        logger.info("更新分类 category={}.", category.toString());
        // 更新数据，先更新数据避免生成旧数据缓存
        return categoryMapper.update(category);
    }

    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除分类 category.id={}.", id);
        Category category = this.get(id);
        return this.delete(category);
    }

    @Override
    @Transactional(readOnly = false)
    public long delete(Category category) {
        logger.info("删除分类 category={}.", category.toString());
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

    @Autowired
    public void setCategoryMapper(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

}
