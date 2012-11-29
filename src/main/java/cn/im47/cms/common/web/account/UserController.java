package cn.im47.cms.common.web.account;

import cn.im47.cms.common.entity.account.Group;
import cn.im47.cms.common.entity.account.User;
import cn.im47.cms.common.service.account.GroupManager;
import cn.im47.cms.common.service.account.UserManager;
import cn.im47.cms.common.vo.ResponseMessage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

/**
 * User: baitao.jibt@gmail.com
 * Date: 12-3-29
 * Time: 下午17:26
 */
@Controller
@RequestMapping(value = "/account/user")
public class UserController {

    private UserManager userManager;
    private GroupManager groupManager;

    @RequiresPermissions("user:list")
    @RequestMapping(value = {"list", ""}, method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("users", userManager.getAll(0, 10, "id", "DESC"));
        model.addAttribute("total", userManager.count());
        return "dashboard/account/user/listAll";
    }

    @RequiresPermissions("article:list")
    @RequestMapping(value = "listAll.json")
    @ResponseBody
    public List<User> ajaxAllUser(@RequestParam("offset") int offset, @RequestParam("limit") int limit, @RequestParam(value = "sort", defaultValue = "id") String sort, @RequestParam(value = "direction", defaultValue = "DESC") String direction) {
        return userManager.getAll(offset, limit, sort, direction);
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("allGroups", groupManager.getAllGroup());
        model.addAttribute("action", "create");
        return "dashboard/account/user/edit";
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(User user, @RequestParam(value = "groupList") List<Long> checkedGroupList,
                         RedirectAttributes redirectAttributes, Model model, HttpServletRequest request) {
        // bind groupList
        user.getGroupList().clear();
        for (Long groupId : checkedGroupList) {
            Group group = new Group(groupId);
            user.getGroupList().add(group);
        }
        try {
            user.setLastLoginIP(request.getRemoteAddr());   //TODO 获得ip
            userManager.save(user);
            redirectAttributes.addFlashAttribute("info", "创建用户" + user.getEmail() + "成功, 密码已邮件的方式发送到" + user.getEmail() + ".");
            return "redirect:/account/user/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "创建用户" + user.getEmail() + "失败");
            return createForm(model);
        }
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("user", userManager.get(id));
        model.addAttribute("action", "update");
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/edit";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("preloadUser") User user,
                         @RequestParam(value = "groupList") List<Long> checkedGroupList,
                         RedirectAttributes redirectAttributes) {
        // bind groupList
        user.getGroupList().clear();
        for (Long groupId : checkedGroupList) {
            Group group = new Group(groupId);
            user.getGroupList().add(group);
        }

        userManager.update(user);
        redirectAttributes.addFlashAttribute("info", "保存用户成功");
        return "redirect:/account/user/list";
    }

    // TODO 找回密码时发送确认邮件，点击邮件再修改密码！
    @RequiresPermissions("user:save")
    @RequestMapping(value = "repass/{id}")
    public String repass(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            long num = userManager.repass(id);
            if (1 == num) {
                redirectAttributes.addFlashAttribute("error", "您选择的用户不存在，请刷新重试");
                return "redirect:/account/user/list";
            }
            redirectAttributes.addFlashAttribute("info", "重置密码成功, 新密码已邮件的方式通知对方.");
            return "redirect:/account/user/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "重置密码失败.");
            return "redirect:/account/user/list";
        }
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "audit/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage auditArticle(@PathVariable("id") Long id) {
        if (userManager.update(id, "status") > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("审核用户 " + id + " 失败.");
        }
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage deleteArticle(@PathVariable("id") Long id) {
        if (userManager.update(id, "deleted") > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("删除用户 " + id + " 失败.");
        }
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "batchAudit", method = RequestMethod.POST)
    public String batchAuditUser(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要审核的用户.");
            return "redirect:/account/user/list";
        } else {
            userManager.batchAudit(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量审核用户成功.");
            return "redirect:/account/user/list";
        }
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public String batchDeleteUser(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的用户.");
            return "redirect:/account/user/list";
        } else {
            userManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除用户成功.");
            return "redirect:/account/user/list";
        }
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("oldEmail") String oldEmail, @RequestParam("email") String email) {
        if (email.equals(oldEmail)) {
            return "true";
        } else if (userManager.findUserByEmail(email) == null) {
            return "true";
        }
        return "该邮箱已存在";
    }

    /**
     * 不自动绑定对象中的roleList属性，另行处理。
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("groupList");
    }

    @ModelAttribute("preloadUser")
    public User getAccount(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return userManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setUserManager(UserManager userManager) {
        this.userManager = userManager;
    }

    @Autowired
    public void setGroupManager(GroupManager groupManager) {
        this.groupManager = groupManager;
    }

}
