package cn.im47.cms.utilities;

import org.apache.ibatis.ognl.OgnlRuntime;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SaeInitListener implements ServletContextListener, HttpSessionListener, HttpSessionAttributeListener {

    public void contextInitialized(ServletContextEvent sce) {
            OgnlRuntime.setSecurityManager(null);
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent arg0) {
        
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent arg0) {
        
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent arg0) {
        
    }

    @Override
    public void sessionCreated(HttpSessionEvent arg0) {
        
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent arg0) {
        
    }

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {
        
    }

}
