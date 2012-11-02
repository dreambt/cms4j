package cn.im47.cms.common.service.agency;

import cn.im47.cms.common.dao.agency.TeacherMapper;
import cn.im47.cms.common.dao.category.CategoryMapper;
import cn.im47.cms.common.entity.agency.Teacher;
import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.service.article.impl.ArticleManagerImpl;
import cn.im47.commons.utilities.upload.UploadFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 用途
 * User: meng.hm(Uee2011@126.com)
 * Date: 12-4-23
 * Time: 下午3:52
 */
@Component
@Transactional(readOnly = true)
public class TeacherManager {

    private static final Logger logger = LoggerFactory.getLogger(TeacherManager.class);

    private ArticleManagerImpl articleManagerImpl;
    private TeacherMapper teacherMapper;
    private CategoryMapper categoryMapper;

    private String uploadPath = "static/uploads/teacher/";

    /**
     * 根据编号获得老师信息
     *
     * @param id
     * @return
     */
    public Teacher getTeacher(Long id) {
        return teacherMapper.get(id);
    }

    /**
     * 根据编号获得对应文章
     *
     * @param id
     * @return
     */
    public Long getArticleId(Long id) {
        return teacherMapper.getByArticleId(id);
    }

    /**
     * 获得所有teacher
     *
     * @return
     */
    public List<Teacher> getAllTeacher() {
        return teacherMapper.getAll();

    }

    /**
     * @param id
     */
    @Transactional(readOnly = false)
    public long delete(long id) {
        return teacherMapper.updateBool(id, "deleted");
    }

    /**
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            teacherMapper.updateBool(Long.parseLong(id), "deleted");
        }
    }

    /**
     * @param file
     * @param request
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public long updateTeacher(MultipartFile file, HttpServletRequest request, Teacher teacher) {
        Article article = teacher.getArticle();

        //是否置顶
        if (null == request.getParameter("top")) {
            article.setTop(false);
        } else {
            article.setTop(true);
        }

        //是否允许评论
        if (null == request.getParameter("allowComment")) {
            article.setAllowComment(false);
        } else {
            article.setAllowComment(true);
        }

        // 保存文章
        articleManagerImpl.update(article);

        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, uploadPath);
            teacher.setImageUrl(fileName);
        }
        return teacherMapper.update(teacher);
    }

    /**
     * @param id
     */
    @Transactional(readOnly = false)
    public void showIndex(Long id) {
        teacherMapper.updateBool(id, "top");
    }

    /**
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public long save(MultipartFile file, Teacher teacher, HttpServletRequest request) {
        Article article = teacher.getArticle();
        article.setCategory(categoryMapper.get(13L));
        article.setSubject(teacher.getTeacherName());
        article.setStatus(true);

        //是否置顶
        if (null == request.getParameter("top")) {
            article.setTop(false);
        } else {
            article.setTop(true);
        }

        //是否允许评论
        if (null == request.getParameter("allowComment")) {
            article.setAllowComment(false);
        } else {
            article.setAllowComment(true);
        }

        if (articleManagerImpl.save(article) > 0) {
            if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
                UploadFile uploadFile = new UploadFile();
                String fileName = uploadFile.uploadFile(file, uploadPath);
                teacher.setImageUrl(fileName);
            }
            teacher.setArticle(article);
            return teacherMapper.save(teacher);
        }
        return 0;
    }

    @Autowired
    public void setArticleManagerImpl(ArticleManagerImpl articleManagerImpl) {
        this.articleManagerImpl = articleManagerImpl;
    }

    @Autowired
    public void setTeacherMapper(TeacherMapper teacherMapper) {
        this.teacherMapper = teacherMapper;
    }

    @Autowired
    public void setCategoryMapper(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

}
