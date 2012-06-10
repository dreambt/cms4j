package cn.edu.sdufe.cms.common.web.dashboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * DashboardController负责打开后台页面
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-18
 * Time: 上午10:26
 */
@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController {

    /**
     * 后台页面
     *
     * @return
     */
    @RequestMapping(value = {"{file}", ""}, method = RequestMethod.GET)
    public String defaultPage(@PathVariable("file") String file) {
        return "dashboard/" + file;
    }

}
