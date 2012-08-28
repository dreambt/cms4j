package cn.im47.sdufe.common.data;

import cn.im47.cms.common.entity.agency.Agency;
import cn.im47.cms.common.entity.agency.Teacher;
import cn.im47.cms.common.entity.article.Article;

/**
 * 老师信息测试数据
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-26
 * Time: 下午2:12
 */
public class TeacherData {

    public static Teacher getTeacher() {
        Teacher teacher = new Teacher();
        teacher.setTeacherName("teacherName");

        Article article = ArticleData.getRandomArticle();
        teacher.setArticle(article);

        Agency agency = AgencyData.getRandomAgency();
        teacher.setAgency(agency);
        teacher.setImageUrl("teacherName.jpg");
        return teacher;
    }

}
