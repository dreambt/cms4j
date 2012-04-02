package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 相册控制器
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-19
 * Time: 下午17:59
 */
@Controller
public class GalleryController {

    private CategoryManager categoryManager;

    /**
     * 获取菜单编号为id的所有图片
     *
     * @return
     */
    @RequestMapping(value = "/gallery/{id}", method = RequestMethod.GET)
    public String listOfArticle(@PathVariable("id") Long id, Model model) {
        model.addAttribute("categories", categoryManager.getAllFatherCategory());
        // TODO 获取菜单编号为id的所有图片
        return "gallery";
    }

    /**
     * 获取菜单编号为id的所有图片
     *
     * @return
     */
    @RequestMapping(value = "/gallery2/{id}", method = RequestMethod.GET)
    public String listOfArticle2(@PathVariable("id") Long id, Model model) {
        model.addAttribute("categories", categoryManager.getAllFatherCategory());
        // TODO 获取菜单编号为id的所有图片
        return "gallery2";
    }

    @Autowired(required = false)
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}