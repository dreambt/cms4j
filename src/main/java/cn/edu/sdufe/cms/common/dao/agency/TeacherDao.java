package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import com.google.common.collect.Maps;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)，meng.hm(Uee2011@126.com)
 * Date: 12-4-23
 * Time: 下午3:31
 */
@Component
public class TeacherDao extends SqlSessionDaoSupport {

    /**
     * 根据编号获得老师信息
     *
     * @param id
     * @return
     */
    public Teacher getTeacher(Long id) {
        return getSqlSession().selectOne("Teacher.getTeacher", id);
    }

    /**
     * 根据编号获得对应文章编号
     *
     * @param id
     * @return
     */
    public Long getArticleId(Long id) {
        return getSqlSession().selectOne("Teacher.getArticleId", id);
    }

    /**
     * 获得所有老师信息
     *
     * @return
     */
    public List<Teacher> getAllTeacher() {
        return getSqlSession().selectList("Teacher.getAllTeacher");
    }

    /**
     * 保存老师信息
     *
     * @param teacher
     * @return
     */
    public int save(Teacher teacher) {
        return getSqlSession().insert("Teacher.saveTeacher", teacher);
    }

    /**
     * 彻底删除标记为删除的老师信息
     *
     * @return
     */
    public int deleteTeacher() {
        return getSqlSession().delete("Teacher.deleteTeacher");
    }

    /**
     * 修改老师信息
     *
     * @param teacher
     * @return
     */
    public int updateTeacher(Teacher teacher) {
        return getSqlSession().update("Teacher.updateTeacher", teacher);
    }

    /**
     * 更新老师信息某一boolean字段
     *
     * @param id
     * @param column
     * @return
     */
    public int updateTeacherBool(Long id, String column) {
        Map parameters = Maps.newHashMap();
        parameters.put("id", id);
        parameters.put("column", column);
        return getSqlSession().update("Teacher.updateTeacherBool", parameters);
    }

}
