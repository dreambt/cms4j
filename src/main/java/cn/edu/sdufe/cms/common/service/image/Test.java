package cn.edu.sdufe.cms.common.service.image;

import java.io.File;

/**
 * 类功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-4
 * Time: 下午1:42
 */
public class Test {

    public void deletePic(String fileName) {
        //上传路径static/uploads/gallery
        String path = this.getClass().getResource("/").getPath();
        System.out.println(path);
        new File(path, fileName).delete();
    }

    public static void main(String[] args) {
        Test test = new Test();
        test.deletePic("1333515520453sD4WAn.jpg");
    }
}
