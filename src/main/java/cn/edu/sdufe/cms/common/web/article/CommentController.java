package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import cn.edu.sdufe.cms.common.service.article.CommentManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 评论控制器
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-25
 * Time: 下午8:43
 */
@Controller
@RequestMapping(value = "/comment")
public class CommentController {

    private CommentManager commentManager;

    private HttpServletRequest request;

    /**
     * 添加评论
     *
     * @param comment
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("comment:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String createComment(Comment comment, RedirectAttributes redirectAttributes) {
        comment.setPostHostIP(request.getRemoteAddr());   //TODO 获得ip
        commentManager.save(comment);
        redirectAttributes.addFlashAttribute("info", "添加评论成功");
        return "redirect:/article/content/" + comment.getArticle().getId();
    }

    /**
     * 显示所有的评论
     *
     * @param model
     * @return
     */
    @RequiresPermissions("comment:list")
    @RequestMapping(value = {"listAll", ""})
    public String listAllComment(Model model) {
        List<Comment> comments = commentManager.getAll();
        model.addAttribute("comments", comments);
        return "dashboard/comment/listAll";
    }

    /**
     * 批量审核
     *
     * @param request
     * @return
     */
    @RequiresPermissions("comment:edit")
    @RequestMapping(value = "batchAudit", method = RequestMethod.POST)
    public String batchAuditComment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要审核的评论.");
            return "redirect:/comment/listAll";
        } else {
            commentManager.batchAudit(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量审核评论成功.");
            return "redirect:/comment/listAll";
        }
    }

    /**
     * 批量删除
     *
     * @return
     */
    @RequiresPermissions("comment:delete")
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public String batchDeleteComment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String[] isSelected = request.getParameterValues("isSelected");
        if (isSelected == null) {
            redirectAttributes.addFlashAttribute("error", "请选择要删除的评论.");
            return "redirect:/comment/listAll";
        } else {
            commentManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量删除评论成功.");
            return "redirect:/comment/listAll";
        }
    }

    @Autowired
    public void setCommentManager(@Qualifier("commentManager") CommentManager commentManager) {
        this.commentManager = commentManager;
    }

    @Autowired(required = false)
    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

}