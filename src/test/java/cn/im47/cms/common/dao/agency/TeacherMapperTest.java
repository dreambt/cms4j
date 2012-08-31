package cn.im47.cms.common.dao.agency;

import cn.im47.cms.common.data.TeacherData;
import cn.im47.cms.common.entity.agency.Teacher;
import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * 老师信息测试类
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-26
 * Time: 下午2:33
 */
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml"})
public class TeacherMapperTest extends SpringTransactionalTestCase {

    @Autowired
    private TeacherMapper teacherMapper;

    @Before
    public void setUp() throws Exception {
        DataFixtures.executeScript(dataSource, "/data/import-data.sql");
    }

    @Test
    public void testGetTeacher() throws Exception {
        Teacher teacher = teacherMapper.get(1L);
        Assert.assertEquals("1", teacher.getArticle().getId().toString());
        Assert.assertEquals("测试文章1-3月份已归档", teacher.getArticle().getSubject());
    }

    @Test
    public void testGetArticleId() throws Exception {
        int result = teacherMapper.getByArticleId(1L).intValue();
        Assert.assertEquals(1, result);
    }

    @Test
    public void testGetAllTeacher() throws Exception {
        int result = teacherMapper.getAll().size();
        Assert.assertEquals(2, result);
    }

    @Test
    @Rollback(false)
    public void testSave() throws Exception {
        Teacher teacher = TeacherData.getTeacher();
        long result = teacherMapper.save(teacher);
        //System.out.println(teacher.getId());
        Assert.assertEquals(1, result);
    }

}
