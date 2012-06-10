package cn.edu.sdufe.cms.schedule;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

/**
 * 类功能
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-7-3
 * Time: 上午9:18
 */
@ContextConfiguration(locations = {"/applicationContext.xml", "/applicationContext-other.xml"})
public class QuartzJobTest extends SpringTransactionalTestCase {

    private QuartzJob quartzJob;

    @Test
    public void testExecute() throws Exception {
        quartzJob.execute();
    }

    @Autowired
    public void setQuartzJob(QuartzJob quartzJob) {
        this.quartzJob = quartzJob;
    }

}
