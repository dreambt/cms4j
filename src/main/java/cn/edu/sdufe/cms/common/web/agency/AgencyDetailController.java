package cn.edu.sdufe.cms.common.web.agency;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.common.service.agency.AgencyManager;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.link.LinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 研究所制定id控制器
 * User: lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/agency/")
public class AgencyDetailController {

    private AgencyManager agencyManager;

    /**
     * 打开研究所更新页面
     * @param agency
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}")
    public String edit(@Valid @ModelAttribute Agency agency, Model model) {
        if(null == agency) {
            model.addAttribute("error", "该研究所不存在，请刷新重试");
            return "redirect:/agency/listAll";
        }
        model.addAttribute("agency", agency);
        return "dashboard/agency/edit";
    }

    /**
     * 更新研究所
     * @param file
     * @param request
     * @param id
     * @param agency
     * @param bindingResult
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String update(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
                         @PathVariable Long id, @Valid @ModelAttribute("agency") Agency agency, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || null == agency) {
            redirectAttributes.addFlashAttribute("error", "该研究所不存在，请刷新重试");
            return "redirect:/agency/listAll";
        }
        if (agencyManager.updateAgency(file, request, agency) <= 0) {
            redirectAttributes.addFlashAttribute("error", "修改研究所信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改" + id + "研究所信息成功");
        }
        return "redirect:/agency/listAll";
    }

    @ModelAttribute("agency")
    public Agency getAgency(@PathVariable Long id) {
        return agencyManager.getAgency(id);
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }
}
