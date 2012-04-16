package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.entity.article.Comment;
import cn.edu.sdufe.cms.common.service.article.CommentManager;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

    /**
     * 添加评论
     *
     * @param comment
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("comment:create")
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String createComment(Comment comment, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        // 获取用户输入的验证码
        String validateCode = request.getParameter("captcha");

        // 获取系统生成的验证码
        HttpSession session = request.getSession();
        String storedValidateCode = (String) session.getAttribute("PATCHCA");

        // 验证验证码是否正确
        if (validateCode == null || validateCode.equals("") ||
                storedValidateCode == null || storedValidateCode.equals("") || !validateCode.equals(storedValidateCode)) {
            redirectAttributes.addFlashAttribute("error", "请检查您输入的验证码是否正确.");
        } else {
            // 设置留言者IP
            comment.setPostHostIP(request.getRemoteAddr());   //TODO 获得ip

            if (commentManager.save(comment) > 0) {
                redirectAttributes.addFlashAttribute("info", "添加评论成功.");
            } else {
                redirectAttributes.addFlashAttribute("error", "添加评论失败.");
            }
        }
        return "redirect:/article/content/" + comment.getArticle().getId();
    }

    /**
     * 添加评论 AJAX
     *
     * @param comment
     * @return
     */
    @RequiresPermissions("comment:create")
    @RequestMapping(value = "createAjax")
    @ResponseBody
    public String createCommentAjax(Comment comment, HttpServletRequest request) {
        // TODO AJAX评论
        // 获取用户输入的验证码
        String validateCode = request.getParameter("captcha");

        // 获取系统生成的验证码
        HttpSession session = request.getSession();
        String storedValidateCode = (String) session.getAttribute("PATCHCA");

        // 验证验证码是否正确
        if (validateCode == null || validateCode.equals("") ||
                storedValidateCode == null || storedValidateCode.equals("") || !validateCode.equals(storedValidateCode)) {
            return "请检查您输入的验证码是否正确.";
        } else {
            // 设置留言者IP
            comment.setPostHostIP(request.getRemoteAddr());   //TODO 获得ip

            if (commentManager.save(comment) > 0) {
                return "添加评论成功.";
            } else {
                return "添加评论失败.";
            }
        }
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
        model.addAttribute("comments", commentManager.getAll());
        return "dashboard/comment/listAll";
    }

    /**
     * 审核编号为id的评论
     *
     * @return
     */
    @RequestMapping(value = "audit/{id}", method = RequestMethod.GET)
    public String auditComment(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (null == commentManager.get(id)) {
            redirectAttributes.addAttribute("error", "该评论不存在，请刷新重试.");
            return "redirect:/comment/listAll";
        }
        if (commentManager.update(id, "status") > 0) {
            redirectAttributes.addFlashAttribute("info", "审核评论 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "审核评论 " + id + " 失败.");
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
        if (commentManager.update(id, "deleted") > 0) {
            redirectAttributes.addFlashAttribute("info", "删除评论 " + id + " 成功.");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除评论 " + id + " 失败.");
        }
        return "redirect:/comment/listAll";
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
            redirectAttributes.addFlashAttribute("error", "请选择要操作的评论.");
        } else {
            commentManager.batchAudit(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量操作评论成功.");
        }
        return "redirect:/comment/listAll";
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
            redirectAttributes.addFlashAttribute("error", "请选择要操作的评论.");
        } else {
            commentManager.batchDelete(isSelected);
            redirectAttributes.addFlashAttribute("info", "批量操作评论成功.");
        }
        return "redirect:/comment/listAll";
    }

    @Autowired
    public void setCommentManager(@Qualifier("commentManager") CommentManager commentManager) {
        this.commentManager = commentManager;
    }

}