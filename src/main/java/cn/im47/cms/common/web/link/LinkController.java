package cn.im47.cms.common.web.link;

import cn.im47.cms.common.entity.link.Link;
import cn.im47.cms.common.service.link.LinkManager;
import cn.im47.cms.common.vo.ResponseMessage;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * link控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午5:02
 */
@Controller
@RequestMapping(value = "/link")
public class LinkController {

    private LinkManager linkManager;

    @RequiresPermissions("link:list")
    @RequestMapping(value = {"", "listAll"})
    public String listAll(Model model) {
        List<Link> links = linkManager.getAll();
        model.addAttribute("links", links);
        model.addAttribute("total", links.size());
        return "dashboard/link/listAll";
    }

    @RequiresPermissions("link:list")
    @RequestMapping(value = "listAll/ajax")
    @ResponseBody
    public List<Link> ajaxAllUser(@RequestParam("offset") int offset, @RequestParam("limit") int limit, String sort, String direction) {
        if (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(direction)) {
            return linkManager.getAll(offset, limit, sort, direction);
        } else {
            return linkManager.getAll(offset, limit);
        }
    }

    @RequiresPermissions("link:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("link", new Link());
        model.addAttribute("action", "create");
        return "dashboard/link/edit";
    }

    @RequiresPermissions("link:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(Link link, RedirectAttributes redirectAttributes) {
        if (linkManager.save(link) > 0) {
            redirectAttributes.addFlashAttribute("info", "链接新建成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "链接新建失败");
        }
        return "redirect:/link/listAll";
    }

    @RequiresPermissions("link:update")
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String updateForm(@PathVariable Long id, Model model) {
        Link link = linkManager.get(id);
        model.addAttribute("link", link);
        model.addAttribute("action", "update");
        return "dashboard/link/edit";
    }

    @RequiresPermissions("link:save")
    @RequestMapping(value = "audit/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage audit(@PathVariable("id") Long id) {
        if (null == linkManager.get(id)) {
            return new ResponseMessage("该链接不存在，请刷新重试");
        }
        if (linkManager.updateBool(id, "status") > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("审核链接" + id + " 失败.");
        }
    }

    @RequiresPermissions("link:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage delete(@PathVariable Long id) {
        if (linkManager.delete(id) > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("删除链接" + id + "失败.");
        }
    }

    @RequiresPermissions("link:save")
    @RequestMapping(value = "batchAudit", method = RequestMethod.GET)
    public String batchAuditLink(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的链接.");
            return "redirect:/link/listAll";
        } else {
            linkManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除链接成功.");
            return "redirect:/link/listAll";
        }
    }

    @RequiresPermissions("link:save")
    @RequestMapping(value = "batchDelete", method = RequestMethod.GET)
    public String batchDeleteLink(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的链接.");
            return "redirect:/link/listAll";
        } else {
            linkManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除链接成功.");
            return "redirect:/link/listAll";
        }
    }

    @Autowired
    public void setLinkManager(LinkManager linkManager) {
        this.linkManager = linkManager;
    }

}
