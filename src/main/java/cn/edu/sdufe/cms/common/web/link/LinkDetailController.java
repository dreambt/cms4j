package cn.edu.sdufe.cms.common.web.link;

import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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



    /**
     * 跳转到修改link页面
     *
     * @param link
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}")
    public String edit(@Valid @ModelAttribute Link link, Model model) {
        model.addAttribute("link", link);
        model.addAttribute("linkCategories", LinkCategoryEnum.values());
        return "dashboard/link/edit";
    }

    /**
     * 保存修改的link
     *
     * @param id
     * @param link
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String save(@PathVariable Long id, @Valid @ModelAttribute Link link, RedirectAttributes redirectAttributes) {
        if (null == link) {
            redirectAttributes.addAttribute("error", "该链接不存在，请刷新重试");
            return "redirect:/link/listAll";
        }
        linkManager.update(link);
        return "redirect:/link/listAll";
    }


    @ModelAttribute("link")
    public Link getLink(@PathVariable Long id) {
        return linkManager.getLink(id);
    }

    @Autowired
    public void setLinkManager(@Qualifier("linkManager") LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}
