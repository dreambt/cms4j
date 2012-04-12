package cn.edu.sdufe.cms.common.web.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.service.account.GroupManager;
import cn.edu.sdufe.cms.common.service.account.UserManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

/**
 * 使用@ModelAttribute, 实现Struts2 Preparable二次绑定的效果。
 * 因为@ModelAttribute被默认执行, 而其他的action url中并没有${id}，所以需要独立出一个Controller.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-18
 * Time: 下午8:57
 */
@Controller
@RequestMapping(value = "/account/user/")
public class UserDetailController {

    private UserManager userManager;

    private GroupManager groupManager;

    private GroupListEditor groupListEditor;

    @InitBinder
    public void initBinder(WebDataBinder b) {
        b.registerCustomEditor(List.class, "groupList", groupListEditor);
    }

    @RequestMapping(value = "edit/{id}")
    public String updateForm(@PathVariable Long id, Model model) {
        if(null == userManager.get(id)) {
            model.addAttribute("info", "该用户不存在，请刷新重试");
            return "redirect:/account/user/list";
        }
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/edit";
    }

    @RequestMapping(value = "save/{id}")
    public String save(@PathVariable Long id, @Valid @ModelAttribute("user") User user, BindingResult bindingResult, Model model,
                       RedirectAttributes redirectAttributes) {
        if(null == userManager.get(id)) {
            redirectAttributes.addFlashAttribute("info", "该用户不存在，请刷新重试");
            return "redirect:/account/user/list";
        }
        if (bindingResult.hasErrors()) {
            return updateForm(id, redirectAttributes);
        }

        userManager.save(user);
        redirectAttributes.addFlashAttribute("info", "保存用户成功");
        return "redirect:/account/user/list";
    }

    /**
     * 审核编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("user:edit")
    @RequestMapping(value = "audit/{id}")
    public String auditArticle(@PathVariable("id") Long id, @ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {
        if(null == userManager.get(id)) {
            redirectAttributes.addFlashAttribute("info", "该用户不存在，请刷新重试");
            return "redirect:/account/user/list";
        }
        user.setStatus(!user.isStatus());
        userManager.update(user);

        if (user.isStatus()) {
            redirectAttributes.addFlashAttribute("info", "审核用户 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "反审核用户 " + id + " 成功.");
        }
        return "redirect:/account/user/list";
    }

    /**
     * 删除编号为id的文章
     *
     * @param id
     * @return
     */
    @RequiresPermissions("user:delete")
    @RequestMapping(value = "delete/{id}")
    public String deleteArticle(@PathVariable("id") Long id, @ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {
        if(null == userManager.get(id)) {
            redirectAttributes.addFlashAttribute("info", "该用户已经不存在，请刷新查看");
            return "redirect:/account/user/list";
        }
        user.setDeleted(!user.isDeleted());
        userManager.update(user);

        if (user.isDeleted()) {
            redirectAttributes.addFlashAttribute("info", "删除用户 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "恢复用户 " + id + " 成功.");
        }
        return "redirect:/account/user/list";
    }

    @ModelAttribute("user")
    public User getAccount(@PathVariable("id") Long id) {
        return userManager.get(id);
    }

    @Autowired
    public void setUserManager(@Qualifier("userManager") UserManager userManager) {
        this.userManager = userManager;
    }

    @Autowired
    public void setGroupManager(@Qualifier("groupManager") GroupManager groupManager) {
        this.groupManager = groupManager;
    }

    @Autowired
    public void setGroupListEditor(@Qualifier("groupListEditor") GroupListEditor groupListEditor) {
        this.groupListEditor = groupListEditor;
    }

}