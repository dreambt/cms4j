package cn.im47.cms.common.web.category;

import cn.im47.cms.common.entity.category.Category;
import cn.im47.cms.common.entity.category.ShowTypeEnum;
import cn.im47.cms.common.service.category.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
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

    @Autowired
    private CategoryManager categoryManager;

    @RequestMapping(value = {"", "listAll"}, method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("categories", categoryManager.getNavCategory());
        return "dashboard/category/listAll";
    }

    @RequiresPermissions("category:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("category", new Category());
        model.addAttribute("fatherCategories", categoryManager.getNavCategory());
        model.addAttribute("action", "create");
        return "dashboard/category/edit";
    }

    @RequiresPermissions("category:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(@Valid Category category, RedirectAttributes redirectAttributes) {
        if (categoryManager.save(category) > 0) {
            redirectAttributes.addFlashAttribute("error", "添加菜单失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "添加菜单成功");
        }
        return "redirect:/category/listAll";
    }

    @RequiresPermissions("category:update")
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String updateForm(@PathVariable("id") Long id, Model model) {
        Category category = categoryManager.get(id);
        if (null == category) {
            model.addAttribute("error", "该分类不存在，请刷新重试.");
            return "dashboard/category/listAll";
        }
        model.addAttribute("category", category);
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("fatherCategories", categoryManager.getNavCategory());
        model.addAttribute("action", "update");
        return "dashboard/category/edit";
    }

    @RequiresPermissions("category:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (null == categoryManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该菜单已经删除，请刷新查看");
        }
        long result = categoryManager.delete(id);
        if (result == 0) {
            redirectAttributes.addFlashAttribute("info", "删除菜单成功！");
        } else if (result == 1) {
            redirectAttributes.addFlashAttribute("error", "该菜单非空，不能删除！");
        } else if (result == 2) {
            redirectAttributes.addFlashAttribute("error", "该菜单下有子菜单非空，不能删除！");
        } else {
            redirectAttributes.addFlashAttribute("error", "指定的菜单不存在！");
        }
        return "redirect:/category/listAll";
    }

    @RequestMapping(value = "nav", method = RequestMethod.GET)
    @ResponseBody
    public List<Category> nav() {
        return categoryManager.getNavCategory();
    }

}
