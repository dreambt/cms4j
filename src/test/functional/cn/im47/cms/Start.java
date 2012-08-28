package cn.im47.cms;

import org.eclipse.jetty.server.Server;
import org.springside.modules.test.jetty.JettyFactory;

/**
 * 使用Jetty运行调试Web应用, 在Console输入回车停止服务.
 */
public class Start {

    public static final int PORT = 8080;
    public static final int TEST_PORT = 8082;
    public static final String CONTEXT = "/CMS";
    public static final String BASE_URL = "http://localhost:8080/CMS";
    public static final String TEST_BASE_URL = "http://localhost:8082/CMS";

    public static void main(String[] args) throws Exception {
        Server server = JettyFactory.createServerInSource(PORT, CONTEXT);
        server.start();
        System.out.println("Server running at " + BASE_URL);
        System.out.println("Hit Enter in console to stop server");
        if (System.in.read() != 0) {
            server.stop();
            System.out.println("Server stopped");
        }
    }
}
