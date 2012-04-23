package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 用途
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/agency/")
public class AgencyController {

    private AgencyManager agencyManager;

    private CategoryManager categoryManager;

    private LinkManager linkManager;

    /**
     * 显示所有组织机构
     * @param model
     * @return
     */
    @RequestMapping(value = {"", "list"})
    public String listOfAgency(Model model) {
        model.addAttribute("agencies", agencyManager.getAllAgency());
        return "listAll";
    }

    /**
     * 根据编号打开对应的研究所首页
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id}")
    public String indexOfAgency(@PathVariable Long id, Model model) {
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("agency", agencyManager.getAgency(id));
        model.addAttribute("links", linkManager.getLinkByCategory(LinkCategoryEnum.LINK));
        model.addAttribute("companies", linkManager.getLinkByCategory(LinkCategoryEnum.COMPANY));
        return "index-research";
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

    @Autowired
    public void setLinkManager(LinkManager linkManager) {
        this.linkManager = linkManager;
    }
}
