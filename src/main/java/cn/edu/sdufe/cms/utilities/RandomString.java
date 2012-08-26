package cn.edu.sdufe.cms.utilities;

import java.util.Random;

/**
 * 随机生成字符串
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-4-2
 * Time: 下午2:44
 */
public class RandomString {

    private static final int MAX_NUM = 62;

    public static final String get(int pwdLen) {
        int i;
        int count = 0;
        String table = "AaBbCc0DdEeFf9GgHhIi1JjKkLl8MmNnOo2PpQqRr7SsTtUu3VvWwXx6Yy5Zz4";
        char[] str = table.toCharArray();

        StringBuffer pwd = new StringBuffer("");
        Random r = new Random();
        while (count < pwdLen) {
            i = Math.abs(r.nextInt(MAX_NUM));

            if (i >= 0 && i < str.length) {
                pwd.append(str[i]);
                count++;
            }
        }
        return pwd.toString();
    }

}
