package cn.im47.cms.common.service.article;

import cn.im47.cms.common.entity.article.Archive;
import cn.im47.cms.common.service.GenericManager;
import org.joda.time.DateTime;

import java.util.List;

/**
 * 归类业务逻辑层接口
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-2
 * Time: 下午4:35
 */
public interface ArchiveManager extends GenericManager<Archive, Long> {

    /**
     * 获得最新10条的归类
     *
     * @return
     */
    List<Archive> getTop(int limit);

    /**
     * 保存上个月的归类
     */
    long updateLastMonth();

    /**
     * 更新指定月份
     *
     * @param dateTime
     */
    long updateByMonth(DateTime dateTime);

}
