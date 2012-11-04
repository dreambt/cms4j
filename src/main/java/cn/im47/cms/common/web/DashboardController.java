package cn.im47.cms.common.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * DashboardController 负责打开后台页面
 * User: baitao.jibt@gmail.com
 * Date: 12-3-18
 * Time: 上午10:26
 */
@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController {

    @RequestMapping(value = {"", "index"}, method = RequestMethod.GET)
    public String defaultPage() {
        return "dashboard/index";
    }

}
