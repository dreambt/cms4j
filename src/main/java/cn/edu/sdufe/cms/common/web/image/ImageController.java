package cn.edu.sdufe.cms.common.web.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * image控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午8:10
 */
@Controller
@RequestMapping(value = "/image")
public class ImageController {
    private ImageManager imageManager;

    /**
     * 后台显示所有图片
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "listAll")
    public String listAllImage(Model model) {
        model.addAttribute("images", imageManager.getAllImage());
        return "dashboard/image/listAll";
    }

    /**
     * 前台显示图片
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String listImage(Model model) {
        model.addAttribute("images", imageManager.getAllImage());
        return "image/list";
    }

    /**
     * test
     * @return
     */
    @RequestMapping(value = "create")
    public String create() {
        return "dashboard/image/upload";
    }

    /**
     * 保存图片信息
     *
     * @param image
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Image image, RedirectAttributes redirectAttributes) {
        if(null == imageManager.save(image)) {
            redirectAttributes.addFlashAttribute("error", "图片信息添加失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "图片信息添加成功");
        }
        return "dashboard/image/listAll";
    }

    @Autowired
    public void setImageManager(@Qualifier("imageManager") ImageManager imageManager) {
        this.imageManager = imageManager;
    }
}
