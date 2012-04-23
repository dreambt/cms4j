package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.service.agency.TeacherManager;
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

    /**
     * 根据编号获得老师信息
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id}")
    public String contentOfTeacher(@PathVariable Long id, Model model) {
        model.addAttribute("article", teacherManager.getTeacher(id));
        return "article/content";
    }

    @Autowired
    public void setTeacherManager(TeacherManager teacherManager) {
        this.teacherManager = teacherManager;
    }
}
