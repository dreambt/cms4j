package cn.im47.cms.common.web.course;

import cn.im47.cms.common.entity.course.Course;
import cn.im47.cms.common.service.course.CourseManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 课程更新控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/course/")
public class CourseDetailController {

    @Autowired
    private CourseManager courseManager;

    @RequiresPermissions("course:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("course") Course course, BindingResult bindingResult,
                         HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (null == course) {
            redirectAttributes.addFlashAttribute("error", "该课程不存在，请刷新重试.");
            return "redirect:/article/listAll";
        }

        //是否置顶
        if (null == request.getParameter("top")) {
            course.setTop(false);
        } else {
            course.setTop(true);
        }

        if (bindingResult.hasErrors() || courseManager.update(course) <= 0) {
            redirectAttributes.addFlashAttribute("error", "保存课程失败.");
            return "redirect:/course/listAll";
        } else {
            redirectAttributes.addFlashAttribute("info", "保存课程成功.");
            return "redirect:/course/listAll";
        }
    }

    @ModelAttribute("course")
    public Course get(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return courseManager.get(id);
        }
        return null;
    }

}
