package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.article.ShowTypeEnum;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
    @RequiresPermissions("category:edit")
    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("category", categoryManager.get(id));
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
    @RequiresPermissions("category:save")
    @RequestMapping(value = "save/{id}")
    public String save(@Valid @ModelAttribute("category") Category category, RedirectAttributes redirectAttributes) {
        if (null == categoryManager.update(category)) {
            redirectAttributes.addFlashAttribute("error", "修改菜单失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改菜单成功");
        }
        return "redirect:/category/listAll";
    }

    /**
     * 删除分类
     *
     * @param category
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("category:delete")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@Valid @ModelAttribute("category") Category category, RedirectAttributes redirectAttributes) {

        if(category.getFatherCategoryId()!=1L) {
            if (category.getArticleList().size() <= 0) {
                category.setDeleted(!category.isDeleted());
            }
        } else {
            if (category.getArticleList().size() <= 0) {
                boolean flag = true;
                for(Category subCategory:category.getSubCategories()) {
                    if(subCategory.getArticleList().size() > 0) {
                        flag = false;
                    }
                }
                if(flag) {
                    category.setDeleted(!category.isDeleted());
                } else {
                    redirectAttributes.addFlashAttribute("error", "该菜单下有子菜单非空，不能删除！");
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "该菜单非空，不能删除！");
            }
        }
        categoryManager.update(category);
        if (category.isDeleted()) {
            redirectAttributes.addFlashAttribute("info", "删除菜单成功");
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