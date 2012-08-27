package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.agency.TeacherManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManagerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * 用途
 * User: meng.hm(Uee2011@126.com)
 * Date: 12-4-23
 * Time: 下午3:55
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {

    private TeacherManager teacherManager;
    private ArticleManagerImpl articleManagerImpl;
    private AgencyManager agencyManager;

    /**
     * 根据编号获得老师信息
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "content/{id}")
    public String contentOfTeacher(@PathVariable Long id, Model model) {
        model.addAttribute("article", articleManagerImpl.get(teacherManager.getArticleId(id)));
        return "article/content";
    }

    /**
     * 显示所有teacher
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "listAll")
    public String listAll(Model model) {
        model.addAttribute("teachers", teacherManager.getAllTeacher());
        return "dashboard/teacher/listAll";
    }

    /**
     * 创建老师
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create")
    public String create(Model model) {
        model.addAttribute("teacher", new Teacher());
        model.addAttribute("article", new Article());
        model.addAttribute("agencies", agencyManager.getAllAgency());
        return "dashboard/teacher/edit";
    }

    /**
     * 保存老师
     *
     * @param file
     * @param teacher
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save")
    public String save(@RequestParam(value = "file") MultipartFile file, Teacher teacher, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (teacherManager.save(file, teacher, request) > 0) {
            redirectAttributes.addFlashAttribute("info", "创建老师成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "创建老师失败");
        }
        return "redirect:/teacher/listAll";
    }

    /**
     * 删除一个老师
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (teacherManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "删除老师成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除老师失败");
        }
        return "redirect:/teacher/listAll";
    }

    /**
     * 批量删除
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "batchDelete")
    public String deleteAllTeacher(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的老师");
            return "redirect:/teacher/listAll";
        } else {
            teacherManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除文章成功.");
            return "redirect:/teacher/listAll";
        }
    }

    /**
     * 老师置顶
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "showIndex/{id}")
    public String showIndex(@PathVariable Long id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        teacherManager.showIndex(id);
        redirectAttributes.addFlashAttribute("info", "成功置顶");
        return "redirect:/teacher/listAll";
    }


    @Autowired
    public void setTeacherManager(TeacherManager teacherManager) {
        this.teacherManager = teacherManager;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManagerImpl articleManagerImpl) {
        this.articleManagerImpl = articleManagerImpl;
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

}
