package cn.im47.cms.common.web.image;

import cn.im47.cms.common.entity.image.Image;
import cn.im47.cms.common.service.image.ImageManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * image指定id的控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-3
 * Time: 下午1:01
 */
@Controller
@RequestMapping(value = "/gallery/")
public class ImageDetailController {

    private ImageManager imageManager;

    @RequiresPermissions("gallery:update")
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
                         @Valid @ModelAttribute("image") Image image, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors() || null == image) {
            redirectAttributes.addFlashAttribute("error", "该图片不存在，请刷新重试");
            return "redirect:/image/listAll";
        }
        if (imageManager.update(file, request, image) <= 0) {
            redirectAttributes.addFlashAttribute("error", "修改图片信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "修改图片信息成功");
        }
        return "redirect:/gallery/listAll";
    }

    @ModelAttribute("image")
    public Image getImage(@RequestParam(value = "id", required = false) Long id) {
        if (id != null) {
            return imageManager.get(id);
        }
        return null;
    }

    @Autowired
    public void setImageManager(ImageManager imageManager) {
        this.imageManager = imageManager;
    }

}
