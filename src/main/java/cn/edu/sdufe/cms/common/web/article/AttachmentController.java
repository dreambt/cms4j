package cn.edu.sdufe.cms.common.web.article;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-30
 * Time: 上午11:22
 */
@Controller
@RequestMapping(value = "/attachment")
public class AttachmentController {

    /**
     * 后台获取所有附件列表
     *
     * @param model
     * @return
     */
    @RequiresPermissions("attachment:listAll")
    @RequestMapping(value = {"list", ""})
    public String listAllArticle(Model model) {
        // TODO
        return "dashboard/attachment/list";
    }

}