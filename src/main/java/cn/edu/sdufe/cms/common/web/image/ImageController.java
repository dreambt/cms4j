package cn.edu.sdufe.cms.common.web.image;

import cn.edu.sdufe.cms.common.entity.image.Image;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.common.service.image.ImageManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

    private CategoryManager categoryManager;

    /**
     * 后台显示所有图片
     *
     * @param model
     * @return
     */
    @RequiresPermissions("gallery:list")
    @RequestMapping(value = "listAll", method = RequestMethod.GET)
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
    @RequestMapping(value = "album", method = RequestMethod.GET)
    public String album(Model model) {
        Long total = imageManager.count().longValue();
        int limit = 4;
        Long pageCount = 1L;
        if (total % limit == 0) {
            pageCount = total / limit;
        } else {
            pageCount = total / limit + 1;
        }
        model.addAttribute("images", imageManager.getPagedImage(0, limit));
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
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
        List<Image> images = imageManager.getPagedImage(offset, limit);
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
        Long total = imageManager.count().longValue();
        int limit = 12;
        Long pageCount = 1L;
        if (total % limit == 0) {
            pageCount = total / limit;
        } else {
            pageCount = total / limit + 1;
        }
        model.addAttribute("images", imageManager.getPagedImage(0, limit));
        model.addAttribute("categories", categoryManager.getNavCategory());
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
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
        List<Image> images = imageManager.getPagedImage(offset, limit);
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
        if (file == null) {
            redirectAttributes.addFlashAttribute("error", "请选择上传的图片");
        }

        if (imageManager.save(file, request, image) <= 0) {
            redirectAttributes.addFlashAttribute("error", "添加图片信息失败");
        } else {
            redirectAttributes.addFlashAttribute("info", "添加" + image.getId() + "图片信息成功");
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
    @RequiresPermissions("gallery:delete")
    @RequestMapping(value = "delete/{id}")
    public String delete(@PathVariable Long id, @ModelAttribute("image") Image image, RedirectAttributes redirectAttributes) {
        if (imageManager.delete(id) > 0) {
            redirectAttributes.addFlashAttribute("error", "删除图片 " + id + " 成功.");
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
    @RequiresPermissions("gallery:delete")
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
    public void setImageManager(@Qualifier("imageManager") ImageManager imageManager) {
        this.imageManager = imageManager;
    }

    @Autowired
    public void setCategoryManager(@Qualifier("categoryManager") CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }

}