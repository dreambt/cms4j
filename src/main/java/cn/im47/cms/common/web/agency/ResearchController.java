package cn.im47.cms.common.web.agency;

import cn.im47.cms.common.service.agency.AgencyManager;
import cn.im47.cms.common.service.article.ArticleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 静态研究所控制器
 * User: dongpengfei, baitao.jibt@gmail.com
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/research")
public class ResearchController {

    private ArticleManager articleManager;
    private AgencyManager agencyManager;

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String indexOfAgency(@PathVariable Long id, Model model) {
        model.addAttribute("infos", articleManager.getByCategoryId(agencyManager.get(id).getCategoryId(), 0, 6));
        return "research" + id;
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
