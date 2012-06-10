package cn.edu.sdufe.cms.common.service.link;

import cn.edu.sdufe.cms.common.dao.link.LinkMapper;
import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import cn.edu.sdufe.cms.memcached.MemcachedObjectType;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;
import org.springside.modules.memcached.SpyMemcachedClient;

import java.util.List;

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

    private LinkMapper linkMapper;

    @Override
    public List<Link> getAll() {
        List<Link> linkList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.LINK.getPrefix() + "all";
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            linkList = linkMapper.getAll();
            jsonString = jsonMapper.toJson(linkList);
            spyMemcachedClient.set(key, MemcachedObjectType.LINK.getExpiredTime(), jsonString);
        } else {
            linkList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Link.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取所有友情链接 {} 用时：{}ms. key: " + key, end - start);
        return linkList;
    }

    @Override
    public List<Link> getByCategory(LinkCategoryEnum category) {
        List<Link> linkList = Lists.newArrayList();
        long start = System.currentTimeMillis();
        String key = MemcachedObjectType.LINK.getPrefix() + "category:" + category.toString();
        String jsonString = spyMemcachedClient.get(key);

        if (StringUtils.isBlank(jsonString)) {
            linkList = linkMapper.getLinkByCategory(category);
            jsonString = jsonMapper.toJson(linkList);
            spyMemcachedClient.set(key, MemcachedObjectType.LINK.getExpiredTime(), jsonString);
        } else {
            linkList = jsonMapper.fromJson(jsonString, jsonMapper.createCollectionType(List.class, Link.class));
        }
        long end = System.currentTimeMillis();
        logger.debug("获取类型为 {} 的友情链接用时：{}ms. key: " + key, category.toString(), end - start);
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
        logger.debug("获取友情链接 {} 用时：{}ms. key: " + key, id, end - start);
        return link;
    }

    @Transactional(readOnly = false)
    public long save(Link link) {
        logger.info("保存友情链接 link={}.", link.toString());
        return linkMapper.save(link);
    }

    @Transactional(readOnly = false)
    public long update(Link link) {
        logger.info("保存友情链接 link={}.", link.toString());
        return linkMapper.update(link);
    }

    @Override
    @Transactional(readOnly = false)
    public long update(Long id, String column) {
        logger.info("保存友情链接 link.id={} 的属性 {}.", id, column);
        return linkMapper.updateBool(id, column);
    }

    @Transactional(readOnly = false)
    public long delete(Long id) {
        logger.info("删除友情链接 link.id={}.", id);
        return linkMapper.delete(id);
    }

    @Override
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        logger.info("批量删除友情链接 link.id={}.", ids.toString());
        for (String id : ids) {
            this.delete(Long.parseLong(id));
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

}
