package cn.edu.sdufe.cms.common.service.agency;

import cn.edu.sdufe.cms.common.dao.agency.TeacherDao;
import cn.edu.sdufe.cms.common.dao.article.CategoryDao;
import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.dao.article.ArticleDao;
import cn.edu.sdufe.cms.common.entity.account.User;
import cn.edu.sdufe.cms.common.entity.agency.Teacher;
import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.security.ShiroDbRealm;
import cn.edu.sdufe.cms.utilities.upload.UploadFile;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Validator;
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
     *
     * @param id
     *
     */
   @Transactional(readOnly =false)
   public int delete(long id){
          return teacherDao.updateTeacherBool(id,"deleted") ;
  }

    /**
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            if (id.length() == 0) {
                continue;
            }
            teacherDao.updateTeacherBool(Long.parseLong(id),"deleted");
        }
    }

    /**
     *
     * @param file
     * @param request
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public int updateTeacher(MultipartFile file,Article article, HttpServletRequest request,Teacher teacher){
         if(file.getOriginalFilename()!=null && !file.getOriginalFilename().equals("")){
             UploadFile uploadFile = new UploadFile();
             String fileName = uploadFile.uploadFile(file, request, UPLOAD_DIR);
             teacher.setImageUrl(fileName);
         }
        if(articleDao.update(article)>0){
            return teacherDao.updateTeacher(teacher);
        } else{
            return 0;
        }


    }

    /**
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void showIndex(Long id){
        teacherDao.updateTeacherBool(id, "top");
    }

    /**
     * @param teacher
     * @return
     */
    @Transactional(readOnly = false)
    public int save(MultipartFile file,Teacher teacher, Article article, HttpServletRequest request) {

        // 文章作者

        ShiroDbRealm.ShiroUser shiroUser = (ShiroDbRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
        article.setUser(new User(shiroUser.getId()));
        article.setCategory(categoryDao.findOne(13L));

        article.setSubject(teacher.getTeacherName());
        article.setMessage(article.getMessage());
        article.setImageName("");
        article.setDigest("");
        article.setKeyword("");
        article.setStatus(true);
        article.setRate(0);
        if (articleDao.save(article) > 0) {
            if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
                UploadFile uploadFile = new UploadFile();
                String fileName = uploadFile.uploadFile(file, request, UPLOAD_DIR);
                teacher.setImageUrl(fileName);
            }else{
                teacher.setImageUrl("");
            }
            teacher.setArticleId(article.getId());
            if( teacherDao.save(teacher)>0){
                    return 1;
            }else{
                return 0;
            }

        } else {
            return 0;
        }
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
