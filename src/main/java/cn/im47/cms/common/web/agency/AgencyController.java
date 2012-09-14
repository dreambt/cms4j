package cn.im47.cms.common.web.agency;

import cn.im47.cms.common.entity.agency.Agency;
import cn.im47.cms.common.entity.article.Category;
import cn.im47.cms.common.service.agency.AgencyManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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

    @RequiresPermissions("agency:list")
    @RequestMapping(value = {"", "listAll"})
    public String listOfAgency(Model model) {
        model.addAttribute("agencies", agencyManager.getAllAgency());
        return "dashboard/agency/listAll";
    }

    @RequestMapping(value = "show/{id}")
    public String indexOfAgency(@PathVariable Long id, Model model) {
        model.addAttribute("agency", agencyManager.get(id));
        return "index-research";
    }

    @RequiresPermissions("agency:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("agency", new Agency());
        model.addAttribute("category", new Category());
        model.addAttribute("action", "create");
        return "dashboard/agency/edit";
    }

    @RequiresPermissions("agency:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, Agency agency, RedirectAttributes redirectAttributes) {
        if (agencyManager.saveAgency(file, request, agency) > 0) {
            redirectAttributes.addFlashAttribute("info", "机构添加成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "机构添加失败");
        }
        return "redirect:/agency/listAll";
    }

    @RequiresPermissions("agency:update")
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String updateForm(@PathVariable Long id, Model model) {
        Agency agency = agencyManager.get(id);
        if (null == agency) {
            model.addAttribute("error", "该研究所不存在，请刷新重试");
            return "redirect:/agency/listAll";
        }
        model.addAttribute("agency", agency);
        model.addAttribute("action", "update");
        return "dashboard/agency/edit";
    }

    @RequiresPermissions("agency:save")
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
