package cn.im47.cms.common.web.agency;

import cn.im47.cms.common.entity.agency.Agency;
import cn.im47.cms.common.service.agency.AgencyManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 研究所制定id控制器
 * User: lirong.songlr(1158633726@qq.com), baitao.jibt@gmail.com
 * Date: 12-4-23
 * Time: 下午1:26
 */
@Controller
@RequestMapping(value = "/agency")
public class AgencyDetailController {

    private AgencyManager agencyManager;

    @RequiresPermissions("agency:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
                         @Valid @ModelAttribute("agency") Agency agency, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || null == agency) {
            redirectAttributes.addFlashAttribute("error", "该研究所不存在，请刷新重试");
            return "redirect:/agency/listAll";
        }
        if (agencyManager.updateAgency(file, request, agency) <= 0) {
            redirectAttributes.addFlashAttribute("error", "修改研究所信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改研究所信息成功");
        }
        return "redirect:/agency/listAll";
    }

    @ModelAttribute("agency")
    public Agency getAgency(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return agencyManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setAgencyManager(AgencyManager agencyManager) {
        this.agencyManager = agencyManager;
    }

}
