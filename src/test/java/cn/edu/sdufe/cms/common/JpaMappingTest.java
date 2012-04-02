package cn.edu.sdufe.cms.common;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springside.modules.test.data.H2Fixtures;
import org.springside.modules.test.spring.SpringTxTestCase;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.metamodel.EntityType;
import javax.persistence.metamodel.Metamodel;

/**
 * 遍历所有Entity，执行一次select操作看entity上的JPA annotation有没有问题
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午17:12
 */
@ContextConfiguration(locations = {"/applicationContext.xml"})
@TransactionConfiguration()
public class JpaMappingTest extends SpringTxTestCase {

    private static Logger logger = LoggerFactory.getLogger(JpaMappingTest.class);

    @PersistenceContext
    private EntityManager em;

    @Test
    public void allClassMapping() throws Exception {
        H2Fixtures.reloadAllTable(dataSource, "/data/sample-data.xml");
        Metamodel model = em.getEntityManagerFactory().getMetamodel();
        for (EntityType entityType : model.getEntities()) {
            String entityName = entityType.getName();
            em.createQuery("select o from " + entityName + " o").getFirstResult();
            logger.info("ok: " + entityName);
        }
    }
}
