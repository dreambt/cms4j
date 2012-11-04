package cn.im47.cms.common.web.course;

import cn.im47.cms.common.entity.course.Course;
import cn.im47.cms.common.service.article.ArticleManager;
import cn.im47.cms.common.service.course.CourseManager;
import cn.im47.cms.common.vo.ResponseMessage;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 文章控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-10-30
 * Time: 上午11:29
 */
@Controller
@RequestMapping(value = "/course")
public class CourseController {

    @Autowired
    private CourseManager courseManager;

    @Autowired
    private ArticleManager articleManager;

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String get(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Course course = courseManager.get(id);
        if (null == course) {
            redirectAttributes.addFlashAttribute("message", "不存在编号为 " + id + " 的课程");
            return "redirect:/error/404";
        }

        //course.setMessage(Encodes.unescapeHtml(course.getMessage()));

        model.addAttribute("course", course);
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "course/content";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("courses", courseManager.getAll());//边栏最新文章
        model.addAttribute("total", courseManager.count());
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "course/list";
    }

    @RequestMapping(value = "list.json", method = RequestMethod.GET)
    @ResponseBody
    public List<Course> ajax(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return courseManager.getAll(offset, limit);
    }

    @RequiresPermissions("course:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("courses", courseManager.getAll2());
        model.addAttribute("total", courseManager.countAll());
        return "dashboard/course/listAll";
    }

    @RequiresPermissions("course:list")
    @RequestMapping(value = "listAll.json")
    @ResponseBody
    public List<Course> ajaxAll(@RequestParam("offset") int offset, @RequestParam("limit") int limit, String sort, String direction) {
        if (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(direction)) {
            return courseManager.getAll2(offset, limit, sort, direction);
        } else {
            return courseManager.getAll2(offset, limit);
        }
    }

    @RequiresPermissions("course:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("course", new Course());
        model.addAttribute("action", "create");
        return "dashboard/course/edit";
    }

    @RequiresPermissions("course:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(Course course, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        //是否置顶
        if (null == request.getParameter("top")) {
            course.setTop(false);
        } else {
            course.setTop(true);
        }

        //是否允许评论
        if (null == request.getParameter("allowApply")) {
            course.setAllowApply(false);
        } else {
            course.setAllowApply(true);
        }

        // 保存
        if (courseManager.save(course) <= 0) {
            redirectAttributes.addFlashAttribute("error", "创建课程失败");
            return "redirect:/course/create";
        } else {
            redirectAttributes.addFlashAttribute("info", "创建课程成功");
            return "redirect:/course/listAll";
        }
    }

    @RequiresPermissions("course:update")
    @RequestMapping(value = {"update/{id}"}, method = RequestMethod.GET)
    public String updateForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Course course = courseManager.get(id);

        // 编辑不存在的文章，给出提示
        if (null == course) {
            redirectAttributes.addFlashAttribute("error", "课程不存在.");
            return "redirect:/course/listAll";
        }

        // 反解析，否则编辑器会显示HTML代码
        //course.setMessage(Encodes.unescapeHtml(course.getMessage()));

        model.addAttribute("course", course);
        model.addAttribute("action", "update");
        return "dashboard/course/edit";
    }

    @RequiresPermissions("course:save")
    @RequestMapping(value = "top/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage top(@PathVariable("id") Long id) {
        if (courseManager.top(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("课程 " + id + " 置顶失败.");
        }
    }

    @RequiresPermissions("course:save")
    @RequestMapping(value = "open/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage open(@PathVariable("id") Long id) {
        if (courseManager.open(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("课程 " + id + " 开课开关失败.");
        }
    }

    @RequiresPermissions("course:save")
    @RequestMapping(value = "allow/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage allow(@PathVariable("id") Long id) {
        if (courseManager.allowApply(id)) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("课程 " + id + " 报名开关失败.");
        }
    }

    @RequiresPermissions("course:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage delete(@PathVariable("id") Long id) {
        if (courseManager.delete(id) > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("删除课程 " + id + " 失败.");
        }
    }

    @RequiresPermissions("course:save")
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public String batchDelete(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的课程.");
            return "redirect:/course/listAll";
        } else {
            courseManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除课程成功.");
            return "redirect:/course/listAll";
        }
    }

}
