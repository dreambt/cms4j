package cn.edu.sdufe.cms.common.service.agency;

import cn.edu.sdufe.cms.common.dao.agency.AgencyDao;
import cn.edu.sdufe.cms.common.entity.agency.Agency;
import cn.edu.sdufe.cms.common.entity.article.Category;
import cn.edu.sdufe.cms.common.entity.article.ShowTypeEnum;
import cn.edu.sdufe.cms.common.service.article.CategoryManager;
import cn.edu.sdufe.cms.utilities.upload.UploadFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 用途
 * User: lirong.songlr(1158633726@qq.com)
 * Date: 12-4-23
 * Time: 下午1:15
 */
@Component
@Transactional(readOnly = true)
public class AgencyManager {

    private static final Logger logger = LoggerFactory.getLogger(AgencyManager.class);

    private AgencyDao agencyDao = null;
    private CategoryManager categoryManager = null;

    @Value("${path.upload.base}")
    private String UPLOAD_PATH;

    /**
     * 根据编号获得组织机构
     *
     * @param id
     * @return
     */
    public Agency getAgency(Long id) {
        return agencyDao.getAgency(id);
    }

    /**
     * 获得所有的组织机构
     *
     * @return
     */
    public List<Agency> getAllAgency() {
        return (List<Agency>) agencyDao.getAllAgency();
    }

    /**
     * 删除组织机构
     *
     * @param id
     * @return
     */
    @Transactional(readOnly = false)
    public int deleteAgency(Long id) {
        return agencyDao.updateAgencyBool(id, "deleted");
    }

    /**
     * 保存组织机构
     *
     * @param agency
     * @return
     */
    @Transactional(readOnly = false)
    public int saveAgency(MultipartFile file, HttpServletRequest request, Agency agency) {
        //构造研究所对应的分类
        Category category = new Category();
        category.setFatherCategoryId(18L);
        category.setCategoryName(agency.getTitle());
        category.setAllowComment(false);
        category.setDisplayOrder(47);
        category.setUrl("");
        category.setShowNav(true);
        category.setDeleted(false);
        category.setDescription(agency.getTitle());
        category.setAllowPublish(false);
        category.setShowType(ShowTypeEnum.NONE);
        categoryManager.save(category);

        //上传图片
        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, request, UPLOAD_PATH);
            agency.setImageUrl(fileName);
        } else {
            agency.setImageUrl("");
        }
        agency.setCategoryId(category.getId());
        return agencyDao.save(agency);

    }

    /**
     * 更新组织机构
     *
     * @param file
     * @param request
     * @param agency
     * @return
     */
    @Transactional(readOnly = false)
    public int updateAgency(MultipartFile file, HttpServletRequest request, Agency agency) {
        //实现上传
        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
            //存储旧图片名
            String oldFileName = agency.getImageUrl();
            UploadFile uploadFile = new UploadFile();
            String fileName = uploadFile.uploadFile(file, request, UPLOAD_PATH);
            agency.setImageUrl(fileName);
        }
        return agencyDao.updateAgency(agency);
    }

    @Autowired
    public void setAgencyDao(AgencyDao agencyDao) {
        this.agencyDao = agencyDao;
    }

    @Autowired
    public void setCategoryManager(CategoryManager categoryManager) {
        this.categoryManager = categoryManager;
    }
}
