package cn.edu.sdufe.cms.common.service.link;

import cn.edu.sdufe.cms.common.dao.link.LinkMapper;
import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import cn.edu.sdufe.cms.utilities.freemarker.FreemakerHelper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;

import java.util.List;
import java.util.Map;

/**
 * link业务逻辑层
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:57
 */
@Component
@Transactional(readOnly = false)
public class LinkManagerImpl implements LinkManager {

    private static final Logger logger = LoggerFactory.getLogger(LinkManager.class);

    private JsonMapper jsonMapper = JsonMapper.nonDefaultMapper();

    private SpyMemcachedClient spyMemcachedClient;

    private FreemakerHelper freemakerHelper;

    private LinkMapper linkMapper;

    @Value("${paged.link.limit}")
    public int LIMIT;

    @Override
    public long count() {
        long num = 0L;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.LINK.getPrefix() + "count:all";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            num = linkMapper.count();
            jsonString = jsonMapper.toJson(num);
            spyMemcachedClient.set(key, MemcachedObjectType.LINK.getExpiredTime(), jsonString);
        } else {
            num = jsonMapper.fromJson(jsonString, Long.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取友情链接数 用时：{}ms. key: {}.", end - start, key);
        return num;
    }

    @Override
    public List<Link> getAll() {
        return this.getAll(0, LIMIT, "id", "DESC");
    }

    @Override
    public List<Link> getAll(int offset, int limit) {
        return this.getAll(offset, limit, "id", "DESC");
    }

    @Override
    public List<Link> getAll(int offset, int limit, String sort, String direction) {
        List<Link> linkList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.LINK.getPrefix() + "all:" + offset + ":" + limit + ":" + sort + ":" + direction;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            linkList = linkMapper.getAll(offset, limit, sort, direction);
            jsonString = jsonMapper.toJson(linkList);
            spyMemcachedClient.set(key, MemcachedObjectType.LINK.getExpiredTime(), jsonString);
        } else {
            linkList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Link.class));
        }
        long end = System.currentTimeMillis();
        logger.info("获取所有友情链接 {} 用时：{}ms. key: " + key, end - start);
        return linkList;
    }

    public Link get(Long id) {
        Link link = null;
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.LINK.getPrefix() + "id:" + id;
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            link = linkMapper.get(id);
            jsonString = jsonMapper.toJson(link);
            spyMemcachedClient.set(key, MemcachedObjectType.LINK.getExpiredTime(), jsonString);
        } else {
            link = jsonMapper.fromJson(jsonString, Link.class);
        }
        long end = System.currentTimeMillis();
        logger.info("获取友情链接 #{} 用时：{}ms. key: " + key, id, end - start);
        return link;
    }

    @Transactional(readOnly = false)
    public long save(Link link) {
        logger.info("保存友情链接 link={}.", link.toString());
        long num = linkMapper.save(link);
        generateContent();
        return num;
    }

    @Transactional(readOnly = false)
    public long update(Link link) {
        logger.info("保存友情链接 link={}.", link.toString());
        long num = linkMapper.update(link);
        generateContent();
        return num;
    }

    @Override
    @Transactional(readOnly = false)
    public long updateBool(Long id, String column) {
        logger.info("保存友情链接 #{} 的属性 {}.", id, column);
        long num = linkMapper.updateBool(id, column);
        generateContent();
        return num;
    }

    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除友情链接 #{}.", id);
        long num = linkMapper.delete(id);
        generateContent();
        return num;
    }

    @Override
    @Transactional(readOnly = false)
    public void batchAudit(String[] ids) {
        logger.info("批量审核友情链接 #{}.", ids.toString());
        for (String id : ids) {
            this.updateBool(Long.parseLong(id), "status");
        }
    }

    @Override
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        logger.info("批量删除友情链接 #{}.", ids.toString());
        for (String id : ids) {
            this.delete(Long.parseLong(id));
        }
    }

    /**
     * 生成 link 静态页面
     */
    private void generateContent() {
        Map context = Maps.newHashMap();
        List<Link> links = this.getAll(0, Integer.MAX_VALUE);
        try {
            context.put("links", links);
            freemakerHelper.generateContent(context, "link.ftl", "/layouts/link.html");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Autowired
    public void setLinkMapper(LinkMapper linkMapper) {
        this.linkMapper = linkMapper;
    }

    @Autowired
    public void setSpyMemcachedClient(@Qualifier("spyMemcachedClient") SpyMemcachedClient spyMemcachedClient) {
        this.spyMemcachedClient = spyMemcachedClient;
    }

    @Autowired
    public void setFreemakerHelper(FreemakerHelper freemakerHelper) {
        this.freemakerHelper = freemakerHelper;
    }

}
