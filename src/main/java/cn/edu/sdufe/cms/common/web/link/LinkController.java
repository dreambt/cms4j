package cn.edu.sdufe.cms.common.web.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

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
     * 显示所有未删除的link
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "listAll")
    public String listAll(Model model) {
        model.addAttribute("links", linkManager.getAll());
        return "dashboard/link/listAll";
    }

    /**
     * 跳转新建link页面
     *
     * @return
     */
    @RequestMapping(value = "create")
    public String create() {
        return "dashboard/link/edit";
    }

    /**
     * 新建link
     *
     * @param link
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save")
    public String save(Link link, RedirectAttributes redirectAttributes) {
        link.setStatus(false);
        linkManager.save(link);
        redirectAttributes.addFlashAttribute("info", "链接新建成功");
        return "redirect:/link/listAll";
    }

    /**
     * 批量删除link
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
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
    public void setLinkManager(@Qualifier("linkManager") LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}
