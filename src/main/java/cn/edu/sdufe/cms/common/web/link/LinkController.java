package cn.edu.sdufe.cms.common.web.link;

import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @RequestMapping(value = "listAll")
    public String listAll(Model model) {
        model.addAttribute("links", linkManager.getAllLink());
        return "dashboard/link/listAll";
    }

    @Autowired
    public void setLinkManager(@Qualifier("linkManager") LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}
