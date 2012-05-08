package cn.edu.sdufe.cms.utilities.upload;

import cn.edu.sdufe.cms.utilities.RandomString;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;

/**
 * 文件上传类
 * User: User: lirong.songlr(1158633726@qq.com)
 * Date: 12-5-5
 * Time: 下午8:58
 */
public class UploadFile {

    /**
     * 上传文件
     *
     * @param file
     * @param request
     * @return
     */
    public String uploadFile(MultipartFile file, HttpServletRequest request, String upload_dir) {
        // 转型为MultipartHttpRequest：
        //MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        //上传路径
        //String upload_dir = multipartRequest.getSession().getServletContext().getRealPath(upload_dir);

        //原文件名
        String imageName = file.getOriginalFilename();
        String ext = imageName.substring(imageName.lastIndexOf("."), imageName.length());

        //服务器上的文件名
        String fileName = new Date().getTime() + "-" + RandomString.get(6) + ext;
        File targetFile = new File(upload_dir, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }

        //保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }
}
