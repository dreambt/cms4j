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
 * <p />
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-4-2
 * Time: 下午17:59
 */
@Controller
@RequestMapping(value = "/album")
public class AlbumController {

    private CategoryManager categoryManager;

    /**
     * 获取菜单编号为id的所有图片
     *
     * @return
     */
    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String list(@PathVariable("id") Long id, Model model) {
        model.addAttribute("categories", categoryManager.getAllFatherCategory());
        // TODO 获取菜单编号为id的所有图片
        return "album";
    }

    @Autowired(required = false)
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}