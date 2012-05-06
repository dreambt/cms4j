package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.service.agency.TeacherManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午3:55
 */
@Controller
@RequestMapping(value = "/teacher/")
public class TeacherController {
    private TeacherManager teacherManager;
    private ArticleManager articleManager;

    /**
     * 根据编号获得老师信息
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id}")
    public String contentOfTeacher(@PathVariable Long id, Model model) {
        model.addAttribute("article", articleManager.findOne(teacherManager.getArticleId(id)));
        return "article/content";
    }

    @Autowired
    public void setTeacherManager(TeacherManager teacherManager) {
        this.teacherManager = teacherManager;
    }

    @Autowired
    public void setArticleManager(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }
}
