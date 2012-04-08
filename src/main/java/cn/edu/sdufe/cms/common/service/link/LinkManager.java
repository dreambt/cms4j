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
     * 获得所有未删除的link
     *
     * @return
     */
    public List<Link> getAllLink() {
        return linkJpaDao.findByDeleted(false);
    }

    @Autowired
    public void setLinkJpaDao(LinkJpaDao linkJpaDao) {
        this.linkJpaDao = linkJpaDao;
    }
}
