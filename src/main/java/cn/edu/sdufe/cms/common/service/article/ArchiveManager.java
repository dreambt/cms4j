package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.entity.article.Archive;
import cn.edu.sdufe.cms.common.service.GenericManager;
import org.joda.time.DateTime;

import java.util.List;
import java.util.Map;

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
    List<Archive> getTopTen();

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

    /**
     * 保存指定月份的归档
     *
     * @param dateTime
     */
    long save(DateTime dateTime);

    List<Archive> search(Map<String, Object> parameters);

    List<Archive> search(Map<String, Object> parameters, int offset, int limit);

}
