package cn.im47.cms.common.service.link;

import cn.im47.cms.common.entity.link.Link;
import cn.im47.cms.common.service.GenericManager;

import java.util.List;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-13
 * Time: 上午9:23
 */
public interface LinkManager extends GenericManager<Link, Long> {

    /**
     * 获取 link 数
     *
     * @return
     */
    long count();

    /**
     * 获得所有 link
     *
     * @return
     */
    List<Link> getAll();

    /**
     * 使用默认的排序方式指定偏移的所有 link
     *
     * @param offset
     * @param limit
     * @return
     */
    List<Link> getAll(int offset, int limit);

    /**
     * 按指定的排序方式指定偏移的所有 link
     *
     * @param offset
     * @param limit
     * @param sort
     * @param direction
     * @return
     */
    List<Link> getAll(int offset, int limit, String sort, String direction);

    long updateBool(Long id, String column);

    /**
     * 批量审核 link
     *
     * @param ids
     */
    void batchAudit(String[] ids);

    /**
     * 批量删除 link
     *
     * @param ids
     */
    void batchDelete(String[] ids);

}
