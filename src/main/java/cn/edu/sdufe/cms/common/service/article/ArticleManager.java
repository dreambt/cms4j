package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.entity.article.Article;
import cn.edu.sdufe.cms.common.service.GenericManager;

import java.util.List;
import java.util.Map;

/**
 * 文章 Manager 接口
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-8-11
 * Time: 下午9:50
 */
public interface ArticleManager extends GenericManager<Article, Long> {

    /**
     * 通过id获取文章用于显示，带浏览次数统计
     *
     * @param id
     * @return
     */
    Article getForView(Long id);

    /**
     * 获取分类categoryId的文章数
     *
     * @param categoryId
     * @return
     */
    long count(Long categoryId);

    /**
     * 使用默认的排序方式返回所有文章
     *
     * @return
     */
    List<Article> getAll(int offset, int limit);

    /**
     * 获得最新的10篇文章
     *
     * @return
     */
    List<Article> getTopTen();

    List<Article> getByArchiveId(Long archiveId, int offset, int limit);

    /**
     * 获得社会资讯下的最新文章
     *
     * @return
     */
    List<Article> getInfo();

    /**
     * 通过分类categoryId查找文章列表
     *
     * @param categoryId
     * @return
     */
    List<Article> getByCategoryId(Long categoryId, int offset, int limit);

    /**
     * 批量审核文章
     *
     * @param ids
     */
    void batchAudit(String[] ids);

    /**
     * 批量改变文章的删除标志
     *
     * @param ids
     */
    void batchDelete(String[] ids);

    /**
     * 置顶编号为id的文章
     *
     * @param id
     * @return
     */
    boolean top(Long id);

    /**
     * 审核编号为id的文章
     *
     * @param id
     * @return
     */
    boolean audit(Long id);

    /**
     * 允许评论编号为id的文章
     *
     * @param id
     * @return
     */
    boolean allowComment(Long id);

    /**
     * 任务删除文章
     *
     * @return
     */
    int deleteByTask();

}
