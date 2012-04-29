package cn.edu.sdufe.cms.functional;

import cn.edu.sdufe.cms.Start;
import org.eclipse.jetty.server.Server;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.springside.modules.test.data.DataFixtures;
import org.springside.modules.test.functional.JettyFactory;
import org.springside.modules.test.spring.SpringContextHolder;

import javax.sql.DataSource;

/**
 * 功能测试基类.
 * <p/>
 * 在整个测试期间启动一次Jetty Server, 并在每个TestCase执行前中重新载入默认数据.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 上午00:12
 */
@Ignore
public class BaseFunctionalTestCase {

    protected static Server jettyServer;

    protected static DataSource dataSource;

    @BeforeClass
    public static void startAll() throws Exception {
        startJetty();
        reloadSampleData();
    }

    /**
     * 启动Jetty服务器, 仅启动一次.
     */
    protected static void startJetty() throws Exception {
        if (jettyServer == null) {
            jettyServer = JettyFactory.createServerInSource(Start.TEST_PORT, Start.CONTEXT);
            jettyServer.start();
            dataSource = SpringContextHolder.getBean("dataSource");
        }
    }

    /**
     * 载入默认数据.
     */
    protected static void reloadSampleData() throws Exception {
        DataFixtures.reloadData(dataSource, "/data/sample-data.xml");
    }
}