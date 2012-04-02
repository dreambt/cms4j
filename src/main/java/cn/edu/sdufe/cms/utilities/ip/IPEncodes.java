package cn.edu.sdufe.cms.utilities.ip;

/**
 * 实现IP与Long互转
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-21
 * Time: 下午4:01
 */
public class IPEncodes {

    private static final int IP_LENGTH = 4;

    /**
     * 将字符格式的IP地址转化为Long
     *
     * @param hostName
     * @return
     */
    public static Long ipToLong(String hostName) {
        try {
            Long[] ip = new Long[IP_LENGTH];
            int position1 = hostName.indexOf('.');
            int position2 = hostName.indexOf('.', position1 + 1);
            int position3 = hostName.indexOf('.', position2 + 1);
            ip[0] = Long.parseLong(hostName.substring(0, position1));
            ip[1] = Long.parseLong(hostName.substring(position1 + 1, position2));
            ip[2] = Long.parseLong(hostName.substring(position2 + 1, position3));
            ip[3] = Long.parseLong(hostName.substring(position3 + 1));
            return (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3];
        } catch (Exception e) {
            return 0L;
        }
    }

    /**
     * 将Long的IP地址转化为字符格式
     *
     * @param address
     * @return
     */
    public static String longToIp(Long address) {
        try {
            StringBuffer sb = new StringBuffer("");
            sb.append(String.valueOf(address >>> 24));
            sb.append(".");
            sb.append(String.valueOf(address & 0x00FFFFFF >>> 16));
            sb.append(".");
            sb.append(String.valueOf(address & 0x0000FFFF >>> 8));
            sb.append(".");
            sb.append(String.valueOf(address & 0x000000FF));
            return sb.toString();
        } catch (Exception e) {
            return "";
        }
    }
}