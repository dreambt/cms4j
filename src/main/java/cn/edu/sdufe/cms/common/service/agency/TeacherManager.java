package cn.edu.sdufe.cms.common.service.agency;

import cn.edu.sdufe.cms.common.dao.agency.TeacherDao;
import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午3:52
 */
@Component
@Transactional(readOnly = true)
public class TeacherManager {
    private static final Logger logger = LoggerFactory.getLogger(TeacherManager.class);

    private TeacherDao teacherDao;

    /**
     * 根据编号获得老师信息
     * @param id
     * @return
     */
    public Teacher getTeacher(Long id) {
        return teacherDao.getTeacher(id);
    }

    @Autowired
    public void setTeacherDao(TeacherDao teacherDao) {
        this.teacherDao = teacherDao;
    }
}
