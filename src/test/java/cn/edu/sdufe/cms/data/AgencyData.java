package cn.edu.sdufe.cms.data;

import cn.edu.sdufe.cms.common.entity.agency.Agency;
import org.springside.modules.test.data.RandomData;

import java.util.Date;
import java.util.Random;

/**
 * 组织机构的测试数据
 * User: pengfei.dongpf(pengfei.dong@gmail.com)
 * Date: 12-4-26
 * Time: 下午1:16
 */
public class AgencyData {

    public static Agency getRandomAgency() {
        Agency agency = new Agency();
        agency.setTitle("title");
        agency.setCategoryId(1L);
        agency.setImageUrl("title.jpg");
        agency.setIntroduction("introduction");

        return agency;
    }

}
