package cn.edu.sdufe.cms.common.service.link;

import cn.edu.sdufe.cms.common.dao.link.LinkJpaDao;
import cn.edu.sdufe.cms.common.entity.link.Link;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
    private static Logger logger = LoggerFactory.getLogger(LinkManager.class);

    private LinkJpaDao linkJpaDao;

    /**
     * 获得所有link
     * @return
     */
    public List<Link> getAll() {
        return (List<Link>)linkJpaDao.findAll();
    }

    /**
     * 获得所有未删除的link
     *
     * @return
     */
    public List<Link> getAllLink() {
        return linkJpaDao.findByDeleted(false);
    }

    /**
     * 获得指定id的link
     *
     * @param id
     * @return
     */
    public Link getLink(Long id) {
        return linkJpaDao.findOne(id);
    }

    /**
     * 保存新建link
     * @param link
     */
    @Transactional(readOnly = false)
    public Link save(Link link) {
        link.setDeleted(false);
        link.setCreateTime(null);
        link.setModifyTime(null);
        return linkJpaDao.save(link);
    }

    /**
     * 保存修改link
     * @param link
     * @return
     */
    @Transactional(readOnly = false)
    public Link update(Link link) {
        link.setModifyTime(null);
        return linkJpaDao.save(link);
    }

    /**
     * 设置编号为id的link的删除标记
     *
     * @param id
     */
    @Transactional(readOnly = false)
    public void delete(Long id) {
        Link link = this.getLink(id);
        link.setDeleted(!link.isDeleted());
        this.update(link);
    }

    /**
     * 删除link
     * @param link
     */
    @Transactional(readOnly = false)
    public void delete(Link link) {
        link.setDeleted(!link.isDeleted());
        this.update(link);
    }

    /**
     * 批量删除link
     * @param ids
     */
    @Transactional(readOnly = false)
    public void batchDelete(String[] ids) {
        for(String id: ids) {
            Link link = this.getLink(Long.parseLong(id));
            link.setDeleted(true);
            this.update(link);
        }
    }

    @Autowired
    public void setLinkJpaDao(LinkJpaDao linkJpaDao) {
        this.linkJpaDao = linkJpaDao;
    }


}
