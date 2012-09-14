package cn.im47.cms.common.web.image;

import cn.im47.cms.common.entity.image.Image;
import cn.im47.cms.common.service.image.ImageManager;
import cn.im47.cms.common.vo.ResponseMessage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

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

    @RequiresPermissions("gallery:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("images", imageManager.getAll(0, 6, "id", "DESC"));
        model.addAttribute("total", imageManager.count());
        return "dashboard/image/listAll";
    }

    @RequiresPermissions("gallery:list")
    @RequestMapping(value = "listAll/ajax", method = RequestMethod.GET)
    @ResponseBody
    public List<Image> ajaxListAll(@RequestParam("offset") int offset, @RequestParam("limit") int limit,
                                   @RequestParam(value = "sort", defaultValue = "id") String sort,
                                   @RequestParam(value = "direction", defaultValue = "DESC") String direction) {
        return imageManager.getAll(offset, limit, sort, direction);
    }

    @RequestMapping(value = "album", method = RequestMethod.GET)
    public String album(Model model) {
        model.addAttribute("images", imageManager.getAll(0, 6, "id", "DESC"));
        model.addAttribute("total", imageManager.count());
        return "album";
    }

    @RequestMapping(value = "album/ajax", method = RequestMethod.GET)
    @ResponseBody
    public List<Image> ajaxAlbumPaged(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        List<Image> images = imageManager.getAll(offset, limit, "id", "DESC");
        return images;
    }

    @RequestMapping(value = "photo", method = RequestMethod.GET)
    public String gallery(Model model) {
        List<Image> images = imageManager.getAll(0, 12, "id", "DESC");
        model.addAttribute("images", images);
        model.addAttribute("total", imageManager.count());
        return "photo";
    }

    @RequestMapping(value = "photo/ajax", method = RequestMethod.GET)
    @ResponseBody
    public List<Image> ajaxPhotoPaged(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        List<Image> images = imageManager.getAll(offset, limit, "id", "DESC");
        return images;
    }

    @RequiresPermissions("gallery:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("image", new Image());
        model.addAttribute("action", "create");
        return "dashboard/image/edit";
    }

    @RequiresPermissions("gallery:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(@Valid Image image, @RequestParam(value = "file", required = false) MultipartFile file,
                         HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (null == file) {
            redirectAttributes.addFlashAttribute("error", "请选择上传的图片");
            return "redirect:/gallery/listAll";
        }

        // 是否首页显示
        if (null == request.getParameter("showIndex")) {
            image.setShowIndex(false);
        } else {
            image.setShowIndex(true);
        }

        // 保存
        if (imageManager.save(file, image) <= 0) {
            redirectAttributes.addFlashAttribute("error", "添加图片信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "添加图片信息成功");
        }
        return "redirect:/gallery/listAll";
    }

    @RequiresPermissions("gallery:update")
    @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
    public String updateForm(@PathVariable Long id, Model model) {
        Image image = imageManager.get(id);
        model.addAttribute("image", image);
        model.addAttribute("action", "update");
        return "dashboard/image/edit";
    }

    @RequiresPermissions("gallery:save")
    @RequestMapping(value = "showIndex/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage showIndex(@PathVariable Long id) {
        if (imageManager.update(id, "show_index") > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("首页显示 " + id + " 失败");
        }
    }

    @RequiresPermissions("gallery:save")
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseMessage delete(@PathVariable Long id) {
        if (imageManager.delete(id) > 0) {
            return new ResponseMessage();
        } else {
            return new ResponseMessage("删除图片 " + id + " 失败.");
        }
    }

    @RequiresPermissions("gallery:save")
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public String batchDeleteComment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的图片.");
        } else {
            imageManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除图片成功.");
        }
        return "redirect:/gallery/listAll";
    }

    @Autowired
    public void setImageManager(ImageManager imageManager) {
        this.imageManager = imageManager;
    }

}
