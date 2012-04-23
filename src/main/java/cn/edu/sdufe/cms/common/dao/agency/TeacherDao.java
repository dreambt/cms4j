package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午3:31
 */
@Component
public class TeacherDao extends SqlSessionDaoSupport {

    /**
     * 根据编号获得老师信息
     * @param id
     * @return
     */
    public Teacher getTeacher(Long id) {
        return getSqlSession().selectOne("Teacher.getTeacher", id);
    }

}
