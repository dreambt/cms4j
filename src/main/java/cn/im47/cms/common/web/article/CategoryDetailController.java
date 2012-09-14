package cn.im47.cms.common.web.article;

import cn.im47.cms.common.entity.article.Category;
import cn.im47.cms.common.service.article.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * 类功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-29
 * Time: 下午5:50
 */
@Controller
@RequestMapping(value = "/category")
public class CategoryDetailController {

    private CategoryManager categoryManager;

    @RequiresPermissions("category:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("category") Category category, RedirectAttributes redirectAttributes) {
        if (null == category) {
            redirectAttributes.addFlashAttribute("error", "该菜单不存在，请刷新重试.");
            return "redirect:/category/listAll";
        }
        if (categoryManager.update(category) > 0) {
            redirectAttributes.addFlashAttribute("info", "修改菜单成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "修改菜单失败.");
        }
        return "redirect:/category/listAll";
    }

    @ModelAttribute("category")
    public Category getCategory(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return categoryManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}