package cn.im47.cms.common.web.agency;

import cn.im47.cms.common.entity.agency.Teacher;
import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.service.agency.AgencyManager;
import cn.im47.cms.common.service.agency.TeacherManager;
import cn.im47.cms.common.service.article.impl.ArticleManagerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.utils.Encodes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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

    @RequestMapping(value = "content/{id}", method = RequestMethod.GET)
    public String contentOfTeacher(@PathVariable Long id, Model model) {
        model.addAttribute("article", articleManagerImpl.get(teacherManager.getArticleId(id)));
        return "article/content";
    }

    @RequestMapping(value = {"", "listAll"}, method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("teachers", teacherManager.getAllTeacher());
        return "dashboard/teacher/listAll";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("teacher", new Teacher());
        model.addAttribute("article", new Article());
        model.addAttribute("agencies", agencyManager.getAllAgency());
        return "dashboard/teacher/edit";
    }

    @RequestMapping(value = "save")
    public String save(@RequestParam(value = "file") MultipartFile file, Teacher teacher, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (teacherManager.save(file, teacher, request) > 0) {
            redirectAttributes.addFlashAttribute("info", "创建老师成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "创建老师失败");
        }
        return "redirect:/teacher/listAll";
    }

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

    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (teacherManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "删除老师成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除老师失败");
        }
        return "redirect:/teacher/listAll";
    }

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

    @RequestMapping(value = "showIndex/{id}")
    public String showIndex(@PathVariable Long id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        teacherManager.showIndex(id);
        redirectAttributes.addFlashAttribute("info", "成功置顶");
        return "redirect:/teacher/listAll";
    }

    @ModelAttribute("teacher")
    public Teacher getTeacher(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return teacherManager.getTeacher(id);
        }
        return null;
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
