package cn.edu.sdufe.cms.common.web.account;

import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.service.account.GroupManager;
import cn.edu.sdufe.cms.common.service.account.UserManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

    @RequiresPermissions("user:view")
    @RequestMapping(value = {"list", ""})
    public String list(Model model) {
        model.addAttribute("users", userManager.getAllUser());
        model.addAttribute("user", new User());
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/list";
    }

    @RequiresPermissions("user:view")
    @RequestMapping(value = "get")
    @ResponseBody
    public User get(@RequestParam("id") Long id) {
        return userManager.getUser(id);
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "create")
    public String createForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/userForm";
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "save")
    public String save(User user, RedirectAttributes redirectAttributes) {
        userManager.saveUser(user);
        redirectAttributes.addFlashAttribute("message", "创建用户" + user.getEmail() + "成功");
        return "redirect:/dashboard/account/user/";
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        userManager.deleteUser(id);
        redirectAttributes.addFlashAttribute("message", "删除用户成功");
        return "redirect:/dashboard/account/user/";
    }

    @RequestMapping(value = "checkLoginName")
    @ResponseBody
    public String checkLoginName(@RequestParam("oldLoginName") String oldLoginName,
                                 @RequestParam("loginName") String loginName) {
        if (loginName.equals(oldLoginName)) {
            return "true";
        } else if (userManager.findUserByEmail(loginName) == null) {
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