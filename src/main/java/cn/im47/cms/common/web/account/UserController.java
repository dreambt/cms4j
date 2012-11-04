package cn.im47.cms.common.web.account;

import cn.im47.cms.common.entity.account.User;
import cn.im47.cms.common.service.account.GroupManager;
import cn.im47.cms.common.service.account.UserManager;
import cn.im47.cms.common.vo.ResponseMessage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
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
    public String create(User user, RedirectAttributes redirectAttributes, BindingResult bindingResult, Model model, HttpServletRequest request) {
        if (bindingResult.hasErrors()) {
            return createForm(model);
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
    public String updateForm(@ModelAttribute("user") User user, Model model) {
        if (null == user) {
            model.addAttribute("info", "该用户不存在，请刷新重试");
            return "redirect:/account/user/list";
        }
        model.addAttribute("user", user);
        model.addAttribute("action", "update");
        model.addAttribute("allGroups", groupManager.getAllGroup());
        return "dashboard/account/user/edit";
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

    @RequestMapping(value = "checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("oldEmail") String oldEmail, @RequestParam("email") String email) {
        if (email.equals(oldEmail)) {
            return "true";
        } else if (userManager.findUserByEmail(email) == null) {
            return "true";
        }
        return "false";
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
