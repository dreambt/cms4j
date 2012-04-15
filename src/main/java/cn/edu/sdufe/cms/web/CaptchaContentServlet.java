package cn.edu.sdufe.cms.web;

import org.patchca.color.ColorFactory;
import org.patchca.color.SingleColorFactory;
import org.patchca.filter.predefined.*;
import org.patchca.service.CaptchaService;
import org.patchca.service.ConfigurableCaptchaService;
import org.patchca.utils.encoder.EncoderHelper;
import org.patchca.word.RandomWordFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

/**
 * 验证码生成Servlet
 * <p/>
 * User: baitao.jibt@gmail.com
 * Date: 12-4-15
 * Time: 下午7:37
 */
public class CaptchaContentServlet extends HttpServlet {

    private static ConfigurableCaptchaService captchaService = null;
    private static ColorFactory cf = null;                   // 颜色
    private static RandomWordFactory wf = null;              // 字体
    private static Random r = new Random();
    private static CurvesRippleFilterFactory crff = null;    // 曲线波纹加干扰线
    private static MarbleRippleFilterFactory mrff = null;    //
    private static DoubleRippleFilterFactory drff = null;    // 双干扰线
    private static WobbleRippleFilterFactory wrff = null;    //
    private static DiffuseRippleFilterFactory dirff = null;  //
    private static final int WIDTH = 160;                   // 默认160
    private static final int HEIGHT = 70;                   // 默认70

    private static final Color TEXT_COLOR = new Color(0, 27, 220);
    private static final Color BACKGROUND_COLOR = new Color(25, 60, 170);

    @Override
    public void init() throws ServletException {
        super.init();
        this.captchaService = new ConfigurableCaptchaService();
        this.crff = new CurvesRippleFilterFactory(captchaService.getColorFactory());
        this.drff = new DoubleRippleFilterFactory();
        this.wrff = new WobbleRippleFilterFactory();
        this.dirff = new DiffuseRippleFilterFactory();
        this.mrff = new MarbleRippleFilterFactory();
        this.cf = new SingleColorFactory(TEXT_COLOR);

        // 设置字体
        this.wf = new RandomWordFactory();
        this.wf.setMaxLength(6);
        this.wf.setMinLength(4);

        this.captchaService.setWordFactory(wf);
        this.captchaService.setColorFactory(cf);
        this.captchaService.setWidth(WIDTH);
        this.captchaService.setHeight(HEIGHT);
    }

    @Override
    public void destroy() {
        this.captchaService = null;

        this.crff = null;
        this.drff = null;
        this.wrff = null;
        this.dirff = null;
        this.mrff = null;
        this.cf = null;
        this.wf = null;
        super.destroy();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("image/png");
        resp.setHeader("cache", "no-cache");
        HttpSession session = req.getSession(true);
        OutputStream outputStream = resp.getOutputStream();

        // 随机设置干扰样式
        switch (r.nextInt(5)) {
            case 0:
                captchaService.setFilterFactory(crff);
                break;
            case 1:
                captchaService.setFilterFactory(mrff);
                break;
            case 2:
                captchaService.setFilterFactory(drff);
                break;
            case 3:
                captchaService.setFilterFactory(wrff);
                break;
            case 4:
                captchaService.setFilterFactory(dirff);
                break;
        }

        String patchca = EncoderHelper.getChallangeAndWriteImage(captchaService, "png", outputStream);
        session.setAttribute("PATCHCA", patchca);
        outputStream.flush();
        outputStream.close();
    }
}
