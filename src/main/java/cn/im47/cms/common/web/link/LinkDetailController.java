package cn.im47.cms.common.web.link;

import cn.im47.cms.common.entity.link.Link;
import cn.im47.cms.common.service.link.LinkManager;
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
 * link 指定id控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午7:03
 */
@Controller
@RequestMapping(value = "/link")
public class LinkDetailController {

    private LinkManager linkManager;

    @RequiresPermissions("link:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute Link link, RedirectAttributes redirectAttributes) {
        if (null == link) {
            redirectAttributes.addAttribute("error", "该链接不存在，请刷新重试");
            return "redirect:/link/listAll";
        }
        linkManager.update(link);
        return "redirect:/link/listAll";
    }

    @ModelAttribute("link")
    public Link getLink(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return linkManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setLinkManager(LinkManager linkManager) {
        this.linkManager = linkManager;
    }

}
