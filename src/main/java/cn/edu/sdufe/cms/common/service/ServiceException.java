package cn.edu.sdufe.cms.common.service;

/**
 * Service层公用的Exception.
 * <p/>
 * 继承自RuntimeException, 从由Spring管理事务的函数中抛出时会触发事务回滚.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-4-6
 * Time: 下午14:55
 */
public class ServiceException extends RuntimeException {

    private static final long serialVersionUID = 3583566093089790852L;

    public ServiceException() {
        super();
    }

    public ServiceException(String message) {
        super(message);
    }

    public ServiceException(Throwable cause) {
        super(cause);
    }

    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}