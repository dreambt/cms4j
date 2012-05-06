package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * 研究所控制器
 * User: lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/research")
public class ResearchController {

    /**
     * 根据编号打开对应的研究所首页
     * @param id
     * @return
     */
    @RequestMapping(value = "{id}")
    public String indexOfAgency(@PathVariable Long id) {
        return "research" + id;
    }
}
