package cn.edu.sdufe.cms.common.service.link;

import cn.edu.sdufe.cms.common.dao.link.LinkMapper;
import cn.edu.sdufe.cms.common.entity.link.Link;
import cn.edu.sdufe.cms.common.entity.link.LinkCategoryEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * link业务逻辑层
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-8
 * Time: 下午4:57
 */
@Component
@Transactional(readOnly = false)
public class LinkManager {

    private static final Logger logger = LoggerFactory.getLogger(LinkManager.class);

    private LinkMapper linkMapper;

    /**
     * 获得所有link
     *
     * @return
     */
    public List<Link> getAllLink() {
        return linkMapper.getAll();
    }

    /**
     * 根据分类获得link
     *
     * @return
     */
    public List<Link> getLinkByCategory(LinkCategoryEnum category) {
        return linkMapper.getLinkByCategory(category);
    }

    /**
     * 获得指定id的link
     *
     * @param id
     * @return
     */
    public Link getLink(Long id) {
        return linkMapper.get(id);
    }

    /**
     * 保存新建link
     *
     * @param link
     */
    @Transactional(readOnly = false)
    public int save(Link link) {
        return linkMapper.save(link);
    }

    /**
     * 保存修改link
     *
     * @param link
     * @return
     */
    @Transactional(readOnly = false)
    public int update(Link link) {
        return linkMapper.update(link);
    }

    /**
     * 保存修改link
     *
     * @param id
     * @param column
     * @return
     */
    @Transactional(readOnly = false)
    public int update(Long id, String column) {
        return linkMapper.updateBool(id, column);
    }

    /**
     * 删除编号为id的link
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public int delete(Long id) {
        return linkMapper.delete(id);
    }

    /**
     * 批量删除link
     *
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for (String id : ids) {
            this.delete(Long.parseLong(id));
        }
    }

    @Autowired
    public void setLinkMapper(@Qualifier("linkMapper") LinkMapper linkMapper) {
        this.linkMapper = linkMapper;
    }

}
