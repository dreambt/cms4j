package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.agency.TeacherManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.utils.Encodes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 指定id老师控制器
 * User: meng.hm(Uee2011@126.com)
 * Date: 12-5-6
 * Time: 上午10:55
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherDetailController {

    private TeacherManager teacherManager;
    private AgencyManager agencyManager;

    /**
     * 跳转到修改老师的edit页面
     *
     * @param teacher
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}")
    public String edit(@Valid @ModelAttribute Teacher teacher, Model model) {
        if (teacher.isDeleted()) {
            model.addAttribute("error", "该老师已经删除不能修改");
            return "redirect:/teacher/listAll";
        } else {
            // 反解析，否则编辑器会显示HTML代码 baitao.jibt@gmail.com
            Article article = teacher.getArticle();
            article.setMessage(Encodes.unescapeHtml(article.getMessage()));
            teacher.setArticle(article);

            model.addAttribute("agencies", agencyManager.getAllAgency());
            return "dashboard/teacher/edit";
        }
    }

    /**
     * 保存修改
     *
     * @param file
     * @param request
     * @param teacher
     * @param bindingResult
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String update(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
                         @Valid @ModelAttribute("teacher") Teacher teacher, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || teacher.isDeleted()) {
            redirectAttributes.addFlashAttribute("error", "该老师已不存在");
            return "redirect:/teacher/listAll";
        }

        //是否置顶
        if (null == request.getParameter("top")) {
            teacher.setTop(false);
        } else {
            teacher.setTop(true);
        }

        if (teacherManager.updateTeacher(file, request, teacher) <= 0) {
            redirectAttributes.addFlashAttribute("error", "修改老师失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改老师成功");
        }
        return "redirect:/teacher/listAll";
    }

    @ModelAttribute("teacher")
    public Teacher getTeacher(@PathVariable Long id) {
        return teacherManager.getTeacher(id);
    }

    @Autowired
    public void setTeacherManager(TeacherManager teacherManager) {
        this.teacherManager = teacherManager;
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

}
