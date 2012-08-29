package cn.im47.cms.common.service.image;

import cn.im47.cms.common.dao.image.ImageMapper;
import org.junit.Before;
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
    private ImageMapper mockImageMapper;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);

        imageManager = new ImageManagerImpl();
        imageManager.setImageMapper(mockImageMapper);
    }

}
