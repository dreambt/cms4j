package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import cn.edu.sdufe.cms.common.service.agency.TeacherManager;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;

/**
 * 指定id老师控制器
 * User: meng.hm(Uee2011@126.com)
 * Date: 12-5-6
 * Time: 上午10:55
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/teacher/")

public class TeacherDetailController {
    private  TeacherManager teacherManager;
    private AgencyManager agencyManager;
    private ArticleManager articleManager;
    /**
     * 跳转到修改老师的edit页面
     * @param teacher
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}")
    public String edit(@Valid @ModelAttribute Teacher teacher,@Valid @ModelAttribute Article article,Model model) {
          if(teacher.isDeleted()){
              model.addAttribute("error","该老师已经删除不能修改");
              return "redirect:/teacher/listAll";
          }else {
              model.addAttribute("article",article);
              model.addAttribute("teacher",teacher) ;

              List<Agency> agencyList = agencyManager.getAllAgency();
              model.addAttribute("agencies", agencyList);
              return "dashboard/teacher/edit";
          }
    }

    /**
     *  保存修改
     * @param file
     * @param request
     * @param id
     * @param teacher
     * @param bindingResult
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String update(@RequestParam(value="file", required=false) MultipartFile file,HttpServletRequest request,
                         @PathVariable Long id,@Valid @ModelAttribute("teacher") Teacher teacher,Article article,BindingResult bindingResult,
                         RedirectAttributes redirectAttributes)  {
        article.setMessage(request.getParameter("message"));
        if(bindingResult.hasErrors()||teacher.isDeleted()){
            redirectAttributes.addFlashAttribute("error","该老师已不存在");
            return "redirect:/teacher/listAll" ;
        }  if(articleManager.update(article, request) <= 0)  {
            if(teacherManager.updateTeacher(file,article,request,teacher)<=0){
                redirectAttributes.addFlashAttribute("error", "修改老师老师失败");
            }
        }
        else{
            teacher.setLastModifiedDate(new Date());
            teacher.getArticle().setMessage(request.getParameter("message"));
            redirectAttributes.addFlashAttribute("info", "修改" + id + "修改老师成功");
        }

        return "redirect:/teacher/listAll";
    }
    @ModelAttribute("teacher")
    public Teacher getTeacher(@PathVariable Long id) {
        return  teacherManager.getTeacher(id);
    }
    @Autowired
    public void setTeacherManager(TeacherManager teacherManager){
        this.teacherManager=teacherManager;

    }
    @Autowired
    public void setAgencyManager(AgencyManager agencyManager){
        this.agencyManager=agencyManager;
    }
    @Autowired
    public void setArticleManager(ArticleManager articleManager){
        this.articleManager=articleManager;
    }
}
