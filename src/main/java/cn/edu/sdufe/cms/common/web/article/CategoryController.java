package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.article.ShowTypeEnum;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 分类控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-22
 * Time: 上午11:36
 */
@Controller
@RequestMapping(value = "/category")
public class CategoryController {

    private CategoryManager categoryManager;

    /**
     * 返回所有顶级分类
     *
     * @param model
     * @return
     */
    @RequiresPermissions("category:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
    public String listOfCategory(Model model) {
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("categories", categoryManager.getSubCategory(0L));
        return "dashboard/category/listAll";
    }

    /**
     * 保存菜单
     *
     * @param category
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("category:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Category category, RedirectAttributes redirectAttributes) {
        if (null == categoryManager.save(category)) {
            redirectAttributes.addFlashAttribute("error", "添加菜单失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "添加菜单成功");
        }
        return "redirect:/category/listAll";
    }

    /**
     * 添加分类
     *
     * @param model
     * @return
     */
    @RequiresPermissions("category:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createCategory(Model model) {
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("category", new Category());
        model.addAttribute("fatherCategories", categoryManager.getAllFatherCategory());
        return "dashboard/category/edit";
    }

    /**
     * 获取导航栏
     *
     * @return
     */
    @RequestMapping(value = "nav", method = RequestMethod.GET)
    @ResponseBody
    public List<Category> nav() {
        return categoryManager.getNavCategory();
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}
