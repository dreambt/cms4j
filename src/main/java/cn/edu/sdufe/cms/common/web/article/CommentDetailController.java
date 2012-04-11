package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import cn.edu.sdufe.cms.common.service.article.CommentManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 评论详细控制器
 * User: pengfei.dongpf@gmail.com
 * baitao.jibt dreambt@gmail.com
 * Date: 12-3-29
 * Time: 下午16:40
 */
@Controller
@RequestMapping(value = "/comment/")
public class CommentDetailController {

    private CommentManager commentManager;

    /**
     * 显示编号为id的评论
     *
     * @return
     */
    @Deprecated
    @RequestMapping(value = "{id}")
    public String getComment() {
        return "dashboard/comment/{id}";
    }

    /**
     * 审核编号为id的评论
     *
     * @return
     */
    @RequestMapping(value = "audit/{id}", method = RequestMethod.GET)
    public String auditComment(@PathVariable("id") Long id, @ModelAttribute("comment") Comment comment, RedirectAttributes redirectAttributes) {
        if(null == commentManager.get(id)) {
            redirectAttributes.addFlashAttribute("error", "该评论不存在，请刷新重试");
            return "redirect:/comment/listAll";
        }
        comment.setStatus(!comment.isStatus());
        if (null == commentManager.update(comment)) {
            redirectAttributes.addFlashAttribute("error", "操作评论 " + id + " 失败.");
            return "redirect:/comment/listAll";
        }
        if (comment.isStatus()) {
            redirectAttributes.addFlashAttribute("info", "审核评论 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "反审核评论 " + id + " 成功.");
        }
        return "redirect:/comment/listAll";
    }

    /**
     * 删除编号为id的评论
     *
     * @return
     */
    @RequiresPermissions("comment:delete")
    @RequestMapping(value = "delete/{id}")
    public String deleteComment(@PathVariable("id") Long id, @ModelAttribute("comment") Comment comment, RedirectAttributes redirectAttributes) {
        comment.setDeleted(!comment.isDeleted());
        if (null == commentManager.update(comment)) {
            redirectAttributes.addFlashAttribute("error", "操作评论 " + id + " 失败.");
            return "redirect:/comment/listAll";
        }

        if (comment.isDeleted()) {
            redirectAttributes.addFlashAttribute("info", "删除评论 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("info", "恢复评论 " + id + " 成功.");
        }
        return "redirect:/comment/listAll";
    }

    @ModelAttribute("comment")
    public Comment getComment(@PathVariable("id") Long id) {
        return commentManager.get(id);
    }

    @Autowired
    public void setCommentManager(@Qualifier("commentManager") CommentManager commentManager) {
        this.commentManager = commentManager;
    }
}