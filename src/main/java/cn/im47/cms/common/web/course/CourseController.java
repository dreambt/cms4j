package cn.im47.cms.common.web.course;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.im47.cms.common.entity.category.Category;
import cn.im47.cms.common.entity.course.Course;
import cn.im47.cms.common.entity.course.CourseTypeEnum;
import cn.im47.cms.common.service.article.ArticleManager;
import cn.im47.cms.common.service.category.CategoryManager;
import cn.im47.cms.common.service.course.CourseManager;
import cn.im47.cms.common.vo.ResponseMessage;

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
    private CategoryManager categoryManager;

    @Autowired
    private ArticleManager articleManager;

    @RequestMapping(value = {"index/{id}"}, method = RequestMethod.GET)
    public String index(@PathVariable("id") Long id, Model model) {
        List<Category> categoryList = categoryManager.getSubCategory(id);
        for (Category category : categoryList) {
            category.getArticleList().addAll(articleManager.getByCategoryIdAndStatusAndDeleted(category.getId(), 0, 5, true, false));
        }
        model.addAttribute("category", categoryManager.get(id));
        model.addAttribute("categories", categoryList);
        model.addAttribute("courses", courseManager.getAll());
        model.addAttribute("freeCourses", courseManager.getFree());
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "course/index";
    }

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
        model.addAttribute("categories", categoryManager.getSubCategory(6L));
        model.addAttribute("courseName", "课程列表");
        model.addAttribute("courses", courseManager.getAll());//边栏最新文章
        model.addAttribute("total", courseManager.countAll());
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "course/list";
    }

    @RequestMapping(value = "list.json", method = RequestMethod.GET)
    @ResponseBody
    public List<Course> ajaxList(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return courseManager.getAll(offset, limit);
    }

    @RequestMapping(value = "free", method = RequestMethod.GET)
    public String free(Model model) {
        model.addAttribute("categories", categoryManager.getSubCategory(6L));
        model.addAttribute("courseName", "免费课程");
        model.addAttribute("courses", courseManager.getFree());//边栏最新文章
        model.addAttribute("total", courseManager.countFree());
        model.addAttribute("newArticles", articleManager.getNewTop(8));
        return "course/list";
    }

    @RequestMapping(value = "free.json", method = RequestMethod.GET)
    @ResponseBody
    public List<Course> ajaxFree(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        return courseManager.getFree(offset, limit);
    }

    @RequiresPermissions("course:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("courses", courseManager.getAll2());
        model.addAttribute("total", courseManager.countAll2());
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
        model.addAttribute("allStatus", CourseTypeEnum.getAll());
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
        if (null == course) {
            redirectAttributes.addFlashAttribute("error", "课程不存在.");
            return "redirect:/course/listAll";
        }

        // 反解析，否则编辑器会显示HTML代码
        //course.setMessage(Encodes.unescapeHtml(course.getMessage()));

        model.addAttribute("course", course);
        model.addAttribute("allStatus", CourseTypeEnum.getAll());
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
