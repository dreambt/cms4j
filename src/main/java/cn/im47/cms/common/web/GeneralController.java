package cn.im47.cms.common.web;

import cn.im47.cms.common.service.article.ArticleManager;
import cn.im47.cms.common.service.image.ImageManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 通用控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-3-18
 * Time: 下午8:57
 */
@Controller
public class GeneralController {

    @Autowired
    private ImageManager imageManager;

    @Autowired
    private ArticleManager articleManager;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        model.addAttribute("images", imageManager.findByShowIndex());
        model.addAttribute("news1", articleManager.getByCategoryId(3L, 0, 6));
        model.addAttribute("news2", articleManager.getByCategoryId(4L, 0, 8));
        model.addAttribute("infos", articleManager.getByCategoryIds(ids, 0, 7));
        model.addAttribute("posts", articleManager.getByCategoryId(1L, 0, 6));
        return "index";
    }

    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String contactUs() {
        return "contact";
    }

    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String ahout() {
        return "about";
    }

    @RequestMapping(value = "/aboutUs", method = RequestMethod.GET)
    public String ahoutUs() {
        return "aboutUs";
    }

    @RequestMapping(value = "/error/404", method = RequestMethod.GET)
    public String notFound() {
        return "error/404";
    }

    @RequestMapping(value = "/story/{page}")
    public String story(@PathVariable("page") String page) {
        return "story/" + page;
    }

    /**
     * 跨域名Mashup
     *
     * @return
     */
    @RequestMapping(value = "/web/mashup-client")
    public String mashupClient() {
        return "web/mashup-client";
    }

}
