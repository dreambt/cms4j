package cn.edu.sdufe.cms.common.dao.agency;

import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.data.TeacherData;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.Fixtures;
import org.springside.modules.test.spring.SpringTxTestCase;

/**
 * 老师信息测试类
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-26
 * Time: 下午2:33
 */
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml"})
public class TeacherDaoTest extends SpringTxTestCase {

    @Autowired
    private TeacherDao teacherDao;
    private Teacher teacher;

    @Before
    public void setUp() throws Exception {
        Fixtures.reloadData(dataSource, "/data/sample-data.xml");
    }

    @Test
    public void testGetArticleId() throws Exception {
        int result =  teacherDao.getArticleId(1L).intValue();
        Assert.assertEquals(1, result);
    }

    @Test
    public void testGetAllTeacher() throws Exception {
        int result = teacherDao.getAllTeacher().size();
        Assert.assertEquals(2, result);
    }

    @Test
    @Rollback(false)
    public void testSave() throws Exception {
        teacher = TeacherData.getTeacher();
        int result = teacherDao.save(teacher);
        System.out.println(teacher.getId());
        //Assert.assertEquals(1, result);
    }
}
