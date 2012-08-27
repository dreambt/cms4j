package cn.edu.sdufe.cms.common.web;

import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 通用控制器
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-18
 * Time: 下午8:57
 */
@Controller
public class GeneralController {

    private ImageManager imageManager;
    private ArticleManager articleManager;

    /**
     * 首页显示菜单，静态+动态
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/index{str}", method = RequestMethod.GET)
    public String index(Model model, @PathVariable("str") String str) {
        Long[] ids = {19L, 20L, 21L, 22L, 32L, 33L};
        model.addAttribute("images", imageManager.findByShowIndex());
        model.addAttribute("news1", articleManager.getByCategoryId(3L, 0, 6));
        model.addAttribute("news2", articleManager.getByCategoryId(4L, 0, 8));
        model.addAttribute("infos", articleManager.getByCategoryIds(ids, 0, 7));
        model.addAttribute("posts", articleManager.getByCategoryId(1L, 0, 6));
        return "index" + str;
    }

    /**
     * 联系我们
     *
     * @return
     */
    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String contactUs(Model model) {
        return "contact";
    }

    /**
     * 关于我们专用
     *
     * @return
     */
    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String ahoutUs(Model model) {
        return "about";
    }

    /**
     * 找不到页面
     *
     * @return
     */
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

    @Autowired
    public void setImageManager(ImageManager imageManager) {
        this.imageManager = imageManager;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

}
