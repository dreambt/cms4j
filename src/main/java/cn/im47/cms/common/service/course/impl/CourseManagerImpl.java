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
    public List<Course> getAll() {
        return this.getAll(0, 10, "id", "DESC");
    }

    @Override
    public List<Course> getAll(int offset, int limit) {
        return this.getAll(offset, limit, "id", "DESC");
    }

    @Override
    public List<Course> getAll(int offset, int limit, String sort, String direction) {
        return courseMapper.getAll(offset, limit, sort, direction, 0);// 不包含标记删除的文章
    }

    @Override
    public List<Course> getAll2() {
        return this.getAll2(0, 10, "id", "DESC");
    }

    @Override
    public List<Course> getAll2(int offset, int limit) {
        return this.getAll2(offset, limit, "id", "DESC");
    }

    @Override
    public List<Course> getAll2(int offset, int limit, String sort, String direction) {
        return courseMapper.getAll(offset, limit, sort, direction, 1);// 包含标记删除的文章
    }

    @Override
    public boolean top(Long id) {
        return courseMapper.updateBool(id, "top") > 0;
    }

    @Override
    public boolean open(Long id) {
        return courseMapper.updateBool(id, "opened") > 0;
    }

    @Override
    public boolean allowApply(Long id) {
        return courseMapper.updateBool(id, "allow_apply") > 0;
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
    public long save(Course object) {
        object.setCourseTime("-");
        return courseMapper.save(object);
    }

    @Override
    public long update(Course object) {
        return courseMapper.update(object);
    }

    @Override
    public long delete(Long id) {
        return courseMapper.delete(id);
    }

}
