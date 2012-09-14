package cn.im47.cms.common.vo;

/**
 * 相应消息
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-2
 * Time: 上午8:32
 */
public class ResponseMessage {

    private int status;
    private String message;

    public ResponseMessage() {
        this.status = 1;
    }

    // 失败消息构造
    public ResponseMessage(String message) {
        this.status = 0;
        this.message = message;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
