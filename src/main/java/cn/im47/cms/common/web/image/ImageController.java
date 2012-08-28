package cn.im47.cms.common.web.image;

import cn.im47.cms.common.entity.image.Image;
import cn.im47.cms.common.service.image.ImageManager;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
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

    /**
     * 后台显示所有图片
     *
     * @param model
     * @return
     */
    @RequiresPermissions("gallery:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
    public String listAll(Model model) {
        model.addAttribute("images", imageManager.getAll());
        model.addAttribute("total", imageManager.count());
        return "dashboard/image/listAll";
    }

    /**
     * 后台获取所有文章图片
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    @RequiresPermissions("gallery:list")
    @RequestMapping(value = "listAll/ajax")
    @ResponseBody
    public List<Image> ajaxListAll(@RequestParam("offset") int offset, @RequestParam("limit") int limit, String sort, String direction) {
        if (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(direction)) {
            return imageManager.getAll(offset, limit, sort, direction);
        } else {
            return imageManager.getAll(offset, limit);
        }
    }

    /**
     * 前台显示图片
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "album", method = RequestMethod.GET)
    public String album(Model model) {
        model.addAttribute("images", imageManager.getAll(0, 10));
        model.addAttribute("total", imageManager.count());
        return "album";
    }

    /**
     * 获得分页image
     *
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "album/ajax", method = RequestMethod.GET)
    @ResponseBody
    public List<Image> ajaxAlbumPaged(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        List<Image> images = imageManager.getAll(offset, limit);
        return images;
    }

    /**
     * 前台显示图片
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "photo", method = RequestMethod.GET)
    public String gallery(Model model) {
        List<Image> images = imageManager.getAll(0, 12);
        model.addAttribute("images", images);
        model.addAttribute("total", imageManager.count());
        return "photo";
    }

    /**
     * 获得分页image
     *
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "photo/ajax", method = RequestMethod.GET)
    @ResponseBody
    public List<Image> ajaxPhotoPaged(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
        List<Image> images = imageManager.getAll(offset, limit);
        return images;
    }

    /**
     * 打开新建image的页面
     *
     * @return
     */
    @RequiresPermissions("gallery:create")
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("image", new Image());
        return "dashboard/image/edit";
    }

    /**
     * 保存图片信息
     *
     * @param image
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("gallery:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@RequestParam(value = "file", required = false) MultipartFile file,
                       HttpServletRequest request, Image image, RedirectAttributes redirectAttributes) {
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

    /**
     * 删除编号为id的image
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("gallery:save")
    @RequestMapping(value = "delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (imageManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("info", "删除图片 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除图片 " + id + " 失败.");
        }

        return "redirect:/gallery/listAll";
    }

    /**
     * 批量删除
     *
     * @return
     */
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

    /**
     * 首页显示
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("gallery:edit")
    @RequestMapping(value = "showIndex/{id}")
    public String showIndex(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (imageManager.update(id, "show_index") > 0) {
            redirectAttributes.addFlashAttribute("info", "首页显示" + id + "成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "首页显示" + id + "失败");
        }
        return "redirect:/gallery/listAll";
    }

    @Autowired
    public void setImageManager(ImageManager imageManager) {
        this.imageManager = imageManager;
    }

}
