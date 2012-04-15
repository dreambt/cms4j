package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.article.ShowTypeEnum;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * 类功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-29
 * Time: 下午5:50
 */
@Controller
@RequestMapping(value = "/category/")
public class CategoryDetailController {

    private CategoryManager categoryManager;

    /**
     * 修改分类
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public String edit(@Valid @ModelAttribute("category") Category category, Model model) {
        if(null == category) {
            model.addAttribute("error", "该分类不存在，请刷新重试.");
            return "dashboard/category/listAll";
        }
        model.addAttribute("category", category);
        model.addAttribute("showTypes", ShowTypeEnum.values());
        model.addAttribute("fatherCategories", categoryManager.getNavCategory());
        return "dashboard/category/edit";
    }

    /**
     * 修改保存分类
     *
     * @param category
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String save(@Valid @ModelAttribute("category") Category category, RedirectAttributes redirectAttributes) {
        if(null == category) {
            redirectAttributes.addFlashAttribute("error", "该菜单不存在，请刷新重试.");
        }
        if (categoryManager.update(category)>0) {
            redirectAttributes.addFlashAttribute("info", "修改菜单成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "修改菜单失败.");
        }
        return "redirect:/category/listAll";
    }

    @ModelAttribute("category")
    public Category getCategory(@PathVariable("id") Long id) {
        return categoryManager.get(id);
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}