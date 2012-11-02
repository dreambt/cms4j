package cn.im47.cms.common.data;

import cn.im47.cms.common.entity.category.Category;
import org.springside.modules.test.data.RandomData;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-27
 * Time: 下午9:41
 */
public class CategoryData {

    private static final String UserSuffix = "User";

    public static Category getRandomCategory() {
        String name = RandomData.randomName(UserSuffix);

        Category category = new Category();
        category.setId(1L);
        category.setCategoryName(name);

        return category;
    }

}
