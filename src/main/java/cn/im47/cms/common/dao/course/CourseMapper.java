package cn.im47.cms.common.dao.course;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.course.Course;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 课程 Dao
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 下午12:44
 */
@Component
public interface CourseMapper extends GenericDao<Course, Long> {

    /**
     * 返回实体个数
     *
     * @return 记录数
     */
    long countAll();

    /**
     * 获得所有课程
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @param deleted
     * @return
     */
    List<Course> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction, @Param("deleted") int deleted);

}
