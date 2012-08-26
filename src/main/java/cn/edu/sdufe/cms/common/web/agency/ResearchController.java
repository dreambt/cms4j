package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 静态研究所控制器
 * User: dongpengfei, baitao.jibt@gmail.com
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/research")
public class ResearchController {

    private CategoryManager categoryManager;
    private LinkManager linkManager;
    private ArticleManager articleManager;
    private AgencyManager agencyManager;

    /**
     * 根据编号打开对应的研究所首页
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id}")
    public String indexOfAgency(@PathVariable Long id, Model model) {
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("infos", articleManager.getByCategoryId(agencyManager.getAgency(id).getCategoryId(), 0, 6));
        return "research" + id;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

    @Autowired
    public void setLinkManager(LinkManager linkManager) {
        this.linkManager = linkManager;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

}
