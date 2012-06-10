package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.dao.GenericDao;
import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)，meng.hm(Uee2011@126.com)
 * Date: 12-4-23
 * Time: 下午3:31
 */
@Component
public interface TeacherMapper extends GenericDao<Teacher, Long> {

    /**
     * 根据编号获得对应文章编号
     *
     * @param id
     * @return
     */
    Long getByArticleId(Long id);

    /**
     * 获得所有老师信息
     *
     * @return
     */
    List<Teacher> getAll();

}
