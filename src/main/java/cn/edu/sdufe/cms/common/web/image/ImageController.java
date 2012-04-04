package cn.edu.sdufe.cms.common.web.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * image控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 下午8:10
 */
@Controller
@RequestMapping(value = "/gallery")
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
        return "dashboard/gallery/listAll";
    }

    /**
     * 前台显示图片
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String listImage(Model model) {
        model.addAttribute("images", imageManager.getAllImageByDeleted());
        return "gallery/list";
    }

    /**
     * 打开新建image的页面
     *
     * @return
     */
    @RequestMapping(value = "create")
    public String create(Model model) {
        model.addAttribute("image", new Image());
        return "dashboard/gallery/edit";
    }

    /**
     * 保存图片信息
     *
     * @param image
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, Image image, RedirectAttributes redirectAttributes) {
        if (file == null) {
            redirectAttributes.addFlashAttribute("error", "请选择上传的图片");
        }

        //redirectAttributes.addAttribute("imageUrl", request.getContextPath()+"/upload/"+fileName);
        Image img = imageManager.save(file, request, image);
        if (null == img) {
            redirectAttributes.addFlashAttribute("error", "添加图片信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "添加图片信息成功");
        }
        return "redirect:/gallery/listAll";
    }

    /**
     * 批量删除
     *
     * @return
     */
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public String batchDeleteComment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的评论.");
            return "redirect:/gallery/listAll";
        } else {
            imageManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除评论成功.");
            return "redirect:/gallery/listAll";
        }
    }

    @Autowired
    public void setImageManager(@Qualifier("imageManager") ImageManager imageManager) {
        this.imageManager = imageManager;
    }
}
