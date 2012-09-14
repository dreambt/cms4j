package cn.im47.cms.common.web.account;

import cn.im47.cms.common.entity.account.User;
import cn.im47.cms.common.service.account.UserManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * User: baitao.jibt@gmail.com
 * Date: 12-3-18
 * Time: 下午8:57
 */
@Controller
@RequestMapping(value = "/account/user")
public class UserDetailController {

    private UserManager userManager;

    @RequiresPermissions("user:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || null == user) {
            redirectAttributes.addFlashAttribute("error", "该用户不存在，请刷新重试");
            return "redirect:/agency/listAll";
        }
        userManager.update(user);
        redirectAttributes.addFlashAttribute("info", "保存用户成功");
        return "redirect:/account/user/list";
    }

    @ModelAttribute("user")
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

}
