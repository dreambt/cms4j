package cn.edu.sdufe.cms.common.service.image;

import cn.edu.sdufe.cms.common.dao.image.ImageDao;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

/**
 * 图片Manager测试类
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-4-4
 * Time: 下午11:07
 */
public class ImageManagerTest {

    private ImageManager imageManager;

    @Mock
    private ImageDao mockImageDao;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);

        imageManager = new ImageManager();
        imageManager.setImageDao(mockImageDao);
    }

}
