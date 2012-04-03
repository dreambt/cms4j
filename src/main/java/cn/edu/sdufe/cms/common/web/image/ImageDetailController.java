package cn.edu.sdufe.cms.common.web.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * image指定id的控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-3
 * Time: 下午1:01
 */
@Controller
@RequestMapping(value = "/image")
public class ImageDetailController {
    private ImageManager imageManager;

    /**
     * 打开修改image的页面
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("image", imageManager.getImage(id));
        return "dashboard/image/edit";
    }

    /**
     * 保存编号为id的image
     *
     * @param id
     * @param image
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save/{id}")
    public String save(@PathVariable Long id, @Valid @ModelAttribute("image") Image image, RedirectAttributes redirectAttributes) {
        if(null == imageManager.update(image)) {
            redirectAttributes.addFlashAttribute("error", "修改" + id + "图片信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改" + id + "图片信息成功");
        }
        return "redirect:/image/listAll";
    }

    /**
     * 删除编号为id的image
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Image image = imageManager.delete(id);
        if(image.isDeleted() == true) {
            redirectAttributes.addFlashAttribute("info", "删除" + id + "图片信息成功");
        } else {
            redirectAttributes.addFlashAttribute("info", "恢复" + id + "图片信息成功");
        }
        return "redirect:/image/listAll";
    }

    @ModelAttribute("image")
    public Image getImage(@PathVariable Long id) {
        return imageManager.getImage(id);
    }

    @Autowired
    public void setImageManager(@Qualifier("imageManager") ImageManager imageManager) {
        this.imageManager = imageManager;
    }
}
