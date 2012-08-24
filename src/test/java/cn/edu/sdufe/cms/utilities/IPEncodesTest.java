package cn.edu.sdufe.cms.utilities;

import cn.edu.sdufe.cms.utilities.encoder.IPEncodes;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * IP地址转换测试类
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午4:31
 */
public class IPEncodesTest {

    private static String HOSTNAME = "8.8.8.8";
    private static Long address = 134744072L;

    private IPEncodes ipEncodes;

    @Before
    public void setUp() {
        ipEncodes = new IPEncodes();
    }

    @Test(timeout = 50)
    public void testIpToLong() throws Exception {
        assertEquals(address, ipEncodes.ipToLong(HOSTNAME));
    }

    @Test(timeout = 50)
    public void testLongToIp() throws Exception {
        assertEquals(HOSTNAME, ipEncodes.longToIp(address));
    }
}