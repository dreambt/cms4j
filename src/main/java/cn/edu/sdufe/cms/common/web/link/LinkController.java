package cn.edu.sdufe.cms.common.web.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
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

    /**
     * 显示所有未删除的 link
     *
     * @param model
     * @return
     */
    @RequiresPermissions("link:list")
    @RequestMapping(value = {"", "listAll"})
    public String listAll(Model model) {
        List<Link> links = linkManager.getAll();
        model.addAttribute("links", links);
        model.addAttribute("total", links.size());
        return "dashboard/link/listAll";
    }

    /**
     * 获取所有 link
     *
     * @param offset
     * @param limit
     * @return
     */
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

    /**
     * 跳转新建link页面
     *
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("link", new Link());
        return "dashboard/link/edit";
    }

    /**
     * 新建link
     *
     * @param link
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Link link, RedirectAttributes redirectAttributes) {
        if (linkManager.save(link) > 0) {
            redirectAttributes.addFlashAttribute("info", "链接新建成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "链接新建失败");
        }
        return "redirect:/link/listAll";
    }

    /**
     * 审核编号为id的评论
     *
     * @return
     */
    @RequestMapping(value = "audit/{id}", method = RequestMethod.GET)
    public String audit(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (null == linkManager.get(id)) {
            redirectAttributes.addAttribute("error", "该链接不存在，请刷新重试");
            return "redirect:/link/listAll";
        }
        if (linkManager.updateBool(id, "status") > 0) {
            redirectAttributes.addFlashAttribute("info", "操作链接" + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "操作链接" + id + " 失败.");
        }
        return "redirect:/link/listAll";
    }

    /**
     * 删除编号为id的link
     *
     * @param id
     */
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (linkManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "删除链接成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除链接失败");
        }
        return "redirect:/link/listAll";
    }

    /**
     * 批量审核 link
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
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

    /**
     * 批量删除 link
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
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
