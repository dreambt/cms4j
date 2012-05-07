package cn.edu.sdufe.cms.common.service.agency;

import cn.edu.sdufe.cms.common.dao.agency.TeacherDao;
import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.article.ArticleManager;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.utilities.upload.UploadFile;
import org.apache.shiro.SecurityUtils;
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

    private ArticleManager articleManager;
    private TeacherDao teacherDao;
    private ArticleDao articleDao;
    private CategoryDao categoryDao;
    private String UPLOAD_DIR = "static/uploads/teacher/";

    /**
     * 根据编号获得老师信息
     *
     * @param id
     * @return
     */
    public Teacher getTeacher(Long id) {
        return teacherDao.getTeacher(id);
    }

    /**
     * 根据编号获得对应文章
     *
     * @param id
     * @return
     */
    public Long getArticleId(Long id) {
        return teacherDao.getArticleId(id);
    }

    /**
     * 获得所有teacher
     *
     * @return
     */
    public List<Teacher> getAllTeacher() {
        return teacherDao.getAllTeacher();

    }

    /**
     * @param id
     */
    @Transactional(readOnly = false)
    public int delete(long id) {
        return teacherDao.updateTeacherBool(id, "deleted");
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
            teacherDao.updateTeacherBool(Long.parseLong(id), "deleted");
        }
    }

    /**
     * @param file
     * @param request
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public int updateTeacher(MultipartFile file, HttpServletRequest request, Teacher teacher) {
        // 保存文章
        articleManager.update(teacher.getArticle(), request);

        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, request, UPLOAD_DIR);
            teacher.setImageUrl(fileName);
        }
        return teacherDao.updateTeacher(teacher);
    }

    /**
     * @param id
     */
    @Transactional(readOnly = false)
    public void showIndex(Long id) {
        teacherDao.updateTeacherBool(id, "top");
    }

    /**
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public int save(MultipartFile file, Teacher teacher, HttpServletRequest request) {
        Article article = teacher.getArticle();
        article.setCategory(categoryDao.findOne(13L));
        article.setSubject(teacher.getTeacherName());
        article.setStatus(true);
        if (articleManager.save(article, request) > 0) {
            if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
                UploadFile uploadFile = new UploadFile();
                String fileName = uploadFile.uploadFile(file, request, UPLOAD_DIR);
                teacher.setImageUrl(fileName);
            }
            teacher.setArticle(article);
            return teacherDao.save(teacher);
        }
        return 0;
    }

    @Autowired
    public void setArticleManager(ArticleManager articleManager) {
        this.articleManager = articleManager;
    }

    @Autowired
    public void setTeacherDao(TeacherDao teacherDao) {
        this.teacherDao = teacherDao;
    }

    @Autowired
    public void setArticleDao(ArticleDao articleDao) {
        this.articleDao = articleDao;
    }

    @Autowired
    public void setCategoryDao(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }
}
