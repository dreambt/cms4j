package cn.im47.cms.common.service.course;

import cn.im47.cms.common.entity.course.Course;
import cn.im47.cms.common.service.GenericManager;

import java.util.List;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 下午12:45
 */
public interface CourseManager extends GenericManager<Course, Long> {

    /**
     * 获取课程数
     *
     * @return
     */
    long count();

    long countAll();

    /**
     * 使用默认的排序方式的所有课程
     *
     * @return
     */
    List<Course> getAll();

    List<Course> getAll2();

    /**
     * 使用默认的排序方式指定偏移的所有课程
     *
     * @param offset
     * @param limit
     * @return
     */
    List<Course> getAll(int offset, int limit);

    List<Course> getAll2(int offset, int limit);

    /**
     * 按指定的排序方式指定偏移的所有课程
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Course> getAll(int offset, int limit, String sort, String direction);

    List<Course> getAll2(int offset, int limit, String sort, String direction);

    /**
     * 置顶编号为id的课程
     *
     * @param id
     * @return
     */
    boolean top(Long id);

    /**
     * 开关编号为id的课程
     *
     * @param id
     * @return
     */
    boolean open(Long id);

    /**
     * 允许评论编号为id的课程
     *
     * @param id
     * @return
     */
    boolean allowApply(Long id);

    /**
     * 批量改变课程的删除标志
     *
     * @param ids
     */
    void batchDelete(String[] ids);

}
