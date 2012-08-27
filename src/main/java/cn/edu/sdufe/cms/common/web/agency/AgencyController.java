package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
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
 * 用途
 * User: lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/agency")
public class AgencyController {

    private AgencyManager agencyManager;

    /**
     * 显示所有组织机构
     *
     * @param model
     * @return
     */
    @RequestMapping(value = {"", "listAll"})
    public String listOfAgency(Model model) {
        model.addAttribute("agencies", agencyManager.getAllAgency());
        return "dashboard/agency/listAll";
    }

    /**
     * 根据编号打开对应的研究所首页
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "show/{id}")
    public String indexOfAgency(@PathVariable Long id, Model model) {
        model.addAttribute("agency", agencyManager.getAgency(id));
        return "index-research";
    }

    /**
     * 打开新建研究所页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create")
    public String create(Model model) {
        model.addAttribute("agency", new Agency());
        model.addAttribute("category", new Category());
        return "dashboard/agency/edit";
    }

    /**
     * 保存研究所
     *
     * @param file
     * @param request
     * @param agency
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, Agency agency, RedirectAttributes redirectAttributes) {

        if (agencyManager.saveAgency(file, request, agency) > 0) {
            redirectAttributes.addFlashAttribute("info", "机构添加成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "机构添加失败");
        }
        return "redirect:/agency/listAll";
    }

    /**
     * 删除研究所
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (agencyManager.deleteAgency(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "删除成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除失败");
        }
        return "redirect:/agency/listAll";
    }


    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

}
