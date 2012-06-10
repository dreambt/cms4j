package cn.edu.sdufe.cms.common.service.article;

import cn.edu.sdufe.cms.common.dao.article.ArchiveMapper;
import cn.edu.sdufe.cms.common.dao.article.ArticleMapper;
import cn.edu.sdufe.cms.common.entity.article.Archive;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;
import org.springside.modules.utils.Collections3;

import java.util.List;
import java.util.Map;

/**
 * 归类业务逻辑层实现类
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-3-31
 * Time: 下午4:46
 */
@Component
@Transactional(readOnly = true)
public class ArchiveManagerImpl implements ArchiveManager {

    private static final Logger logger = LoggerFactory.getLogger(ArchiveManagerImpl.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private ArchiveMapper archiveMapper;
    private ArticleMapper articleMapper;

    @Override
    public Archive get(Long id) {
        Archive archive = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.ARCHIVE.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            archive = archiveMapper.get(id);
            jsonString = jsonMapper.toJson(archive);
            spyMemcachedClient.set(key, MemcachedObjectType.ARCHIVE.getExpiredTime(), jsonString);
        } else {
            archive = jsonMapper.fromJson(jsonString, Archive.class);
        }
        long end = System.currentTimeMillis();
        logger.debug("获取归档 #{} 用时：{}ms. key: " + key, id, end - start);
        return archive;
    }

    @Override
    public List<Archive> getTopTen() {
        Map<String, Object> parameters = Maps.newHashMap();
        parameters.put("offset", 0);
        parameters.put("limit", 10);

        List<Archive> archiveList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.ARCHIVE.getPrefix() + "topten";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            archiveList = archiveMapper.list(parameters);
            jsonString = jsonMapper.toJson(archiveList);
            spyMemcachedClient.set(key, MemcachedObjectType.ARCHIVE.getExpiredTime(), jsonString);
        } else {
            archiveList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Archive.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取 Top 10 归档用时：{}ms. key: " + key, end - start);
        return archiveList;
    }

    @Override
    @Transactional(readOnly = false)
    public long save(Archive object) {
        logger.info("保存 archive={}.", object.toString());
        return archiveMapper.save(object);
    }

    @Override
    @Transactional(readOnly = false)
    public long save(DateTime dateTime) {
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();

        String title = String.format("%04d年%02d月", year, month);
        logger.info("保存 archive.title={}.", title);
        if (null != archiveMapper.getByTitle(title)) {
            return this.updateByMonth(dateTime);
        }

        //获得指定月份的所有文章
        List<Long> ids = articleMapper.getIdByMonth(new DateTime(year, month, 1, 0, 0).toDate(), new DateTime(year, month + 1, 1, 0, 0).minusMillis(1).toDate());
        if (ids.size() > 0) {
            Archive archive = new Archive();
            archive.setTitle(title);
            archiveMapper.save(archive);
            archive = archiveMapper.getByTitle(title);

            //加入归档文章对应表
            for (Long id : ids) {
                archiveMapper.addArticle(archive.getId(), id);
            }
            return ids.size();
        } else {
            return 0;
        }
    }

    @Override
    @Transactional(readOnly = false)
    public long updateLastMonth() {
        DateTime dateTime = new DateTime().plusMonths(-1);
        logger.info("更新归档 archive.dateTime={}.", dateTime.toString());
        return this.updateByMonth(dateTime);
    }

    @Override
    public long updateByMonth(DateTime dateTime) {
        int year = dateTime.getYear();
        int month = dateTime.getMonthOfYear();

        String title = String.format("%04d年%02d月", year, month);
        Archive archive = archiveMapper.getByTitle(title);
        if (null == archive) {
            return this.save(dateTime);
        }

        logger.info("整理归档 archive.dateTime={}.", title);

        List<Long> ids = archiveMapper.getArticleIdByTitle(title);
        List<Long> eids = articleMapper.getIdByMonth(new DateTime(year, month, 1, 0, 0).toDate(), new DateTime(year, month + 1, 1, 0, 0).minusMillis(1).toDate());

        // 待删除id
        List<Long> deleteId = Collections3.subtract(ids, eids);
        logger.info("删除 archive.id={}.", deleteId.toString());
        for (Long id : deleteId) {
            archiveMapper.deleteArticle(id);
        }

        // 待新增id
        List<Long> addId = Collections3.subtract(eids, ids);
        logger.info("保存 archive.id={}.", addId.toString());
        for (Long id : addId) {
            archiveMapper.addArticle(archive.getId(), id);
        }
        return 1;
    }

    @Override
    @Transactional(readOnly = false)
    public long update(Archive archive) {
        logger.info("更新归档 archive={}.", archive.toString());
        if (0 == archive.getArticleList().size()) {
            return this.delete(archive.getId());
        } else {
            return archiveMapper.update(archive);
        }
    }

    @Override
    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除归档 archive.id={}.", id);
        archiveMapper.delete(id);
        archiveMapper.deleteArticle(id);
        return 0;
    }

    @Deprecated
    @Override
    public List<Archive> search(Map<String, Object> parameters) {
        return archiveMapper.search(parameters);
    }

    @Deprecated
    @Override
    public List<Archive> search(Map<String, Object> parameters, int offset, int limit) {
        parameters.put("offset", offset);
        parameters.put("limit", limit);
        return this.search(parameters);
    }

    @Autowired
    public void setArchiveMapper(ArchiveMapper archiveMapper) {
        this.archiveMapper = archiveMapper;
    }

    @Autowired
    public void setArticleMapper(ArticleMapper articleMapper) {
        this.articleMapper = articleMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

}
