package cn.im47.cms.common.dao.course;

import cn.im47.cms.common.dao.GenericDao;
import cn.im47.cms.common.entity.course.Course;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 课程 Dao
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 下午12:44
 */
@Repository
public interface CourseMapper extends GenericDao<Course, Long> {

    /**
     * 返回实体个数
     *
     * @return 记录数
     */
    long countAll();

    /**
     * 返回实体个数
     *
     * @return 记录数
     */
    long countAll2();

    /**
     * 返回实体个数
     *
     * @return 记录数
     */
    long countFree();

    /**
     * 获得所有收费课程
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Course> getAll(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

    /**
     * 获得所有课程
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Course> getAll2(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);


    /**
     * 获得所有免费课程
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Course> getFree(@Param("offset") int offset, @Param("limit") int limit, @Param("sort") String sort, @Param("direction") String direction);

}
