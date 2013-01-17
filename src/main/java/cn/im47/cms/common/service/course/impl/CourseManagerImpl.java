package cn.im47.cms.common.service.course.impl;

import cn.im47.cms.common.dao.course.CourseMapper;
import cn.im47.cms.common.entity.course.Course;
import cn.im47.cms.common.service.course.CourseManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 下午12:46
 */
@Component
public class CourseManagerImpl implements CourseManager {

    private static final Logger logger = LoggerFactory.getLogger(CourseManager.class);

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public long count() {
        return courseMapper.count();
    }

    @Override
    public long countAll() {
        return courseMapper.countAll();
    }

    @Override
    public long countAll2() {
        return courseMapper.countAll2();
    }

    @Override
    public long countFree() {
        return courseMapper.countFree();
    }

    @Override
    public List<Course> getAll() {
        return this.getAll(0, 10, "class_date", "DESC");
    }

    @Override
    public List<Course> getAll(int offset, int limit) {
        return this.getAll(offset, limit, "class_date", "DESC");
    }

    @Override
    public List<Course> getAll(int offset, int limit, String sort, String direction) {
        return courseMapper.getAll(offset, limit, sort, direction);// 不包含标记删除的文章，前台用
    }

    @Override
    public List<Course> getAll2() {
        return this.getAll2(0, 10, "class_date", "DESC");
    }

    @Override
    public List<Course> getAll2(int offset, int limit) {
        return this.getAll2(offset, limit, "class_date", "DESC");
    }

    @Override
    public List<Course> getAll2(int offset, int limit, String sort, String direction) {
        return courseMapper.getAll2(offset, limit, sort, direction);// 包含标记删除的文章，后台用
    }

    @Override
    public List<Course> getFree() {
        return this.getFree(0, 10, "class_date", "DESC");
    }

    @Override
    public List<Course> getFree(int offset, int limit) {
        return this.getFree(offset, limit, "class_date", "DESC");
    }

    @Override
    public List<Course> getFree(int offset, int limit, String sort, String direction) {
        return courseMapper.getFree(offset, limit, sort, direction);// 不包含标记删除的文章，前台用
    }

    @Override
    public boolean top(Long id) {
        return courseMapper.updateBool(id, "top") > 0;
    }

    @Override
    public void batchDelete(String[] ids) {
        logger.info("批量删除课程 #{}.", Arrays.toString(ids));
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            courseMapper.updateBool(Long.parseLong(id), "deleted");
        }
    }

    @Override
    public Course get(Long id) {
        return courseMapper.get(id);
    }

    @Override
    public int save(Course object) {
        object.setCourseTime("-");
        return courseMapper.save(object);
    }

    @Override
    public int update(Course object) {
        return courseMapper.update(object);
    }

    @Override
    public int delete(Long id) {
        return courseMapper.delete(id);
    }

}
