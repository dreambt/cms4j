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

import java.util.List;

/**
 * Urls:
 * List   page        : GET  /account/user/
 * Create page        : GET  /account/user/create
 * Create action      : POST /account/user/save
 * Update page        : GET  /account/user/update/{id}
 * Update action      : POST /account/user/save/{id}
 * Delete action      : POST /account/user/delete/{id}
 * CheckLoginName ajax: GET  /account/user/checkLoginName?oldLoginName=a&loginName=b
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-29
 * Time: 下午17:26
 */
@Controller
@RequestMapping(value = "/account/user")
public class UserController {

    private UserManager userManager;

    private GroupManager groupManager;

    private GroupListEditor groupListEditor;

    @InitBinder
    public void initBinder(WebDataBinder b) {
        b.registerCustomEditor(List.class, "groupList", groupListEditor);
    }

    /**
     * 显示所有用户
     *
     * @param model
     * @return
     */
    @RequiresPermissions("user:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model) {
        model.addAttribute("users", userManager.getAllUser());
        model.addAttribute("user", new User());
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/list";
    }

    /**
     * 获取编号为id的用户AJAX
     *
     * @param id
     * @return
     */
    @RequiresPermissions("user:view")
    @RequestMapping(value = "get")
    @ResponseBody
    public User get(@RequestParam("id") Long id) {
        return userManager.getUser(id);
    }

    /**
     * 添加用户
     *
     * @param model
     * @return
     */
    @RequiresPermissions("user:create")
    @RequestMapping(value = "create")
    public String createForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/edit";
    }

    /**
     * 保存新建用户
     *
     * @param user
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("user:save")
    @RequestMapping(value = "save")
    public String save(User user, RedirectAttributes redirectAttributes, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return createForm(model);
        }

        try {
            userManager.saveUser(user);
            redirectAttributes.addFlashAttribute("message", "创建用户" + user.getEmail() + "成功, 密码已邮件的方式发送到" + user.getEmail() + ".");
            return "redirect:/account/user/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "创建用户" + user.getEmail() + "失败");
            return "dashboard/account/user/edit";
        }
    }

    /**
     * 删除指定id的用户
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("user:delete")
    @RequestMapping(value = "delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        userManager.deleteUser(id);
        redirectAttributes.addFlashAttribute("message", "删除用户成功");
        return "redirect:/account/user/list";
    }

    @RequestMapping(value = "checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("oldEmail") String oldEmail,
                             @RequestParam("email") String email) {
        if (email.equals(oldEmail)) {
            return "true";
        } else if (userManager.findUserByEmail(email) == null) {
            return "true";
        }

        return "false";
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