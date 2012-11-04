<%--
  名师风采
  Created by IntelliJ IDEA.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-14
  Time: 下午5:07
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="scrolllist" id="teacher">
    <a class="abtn aleft" href="#left" title="左移"></a>
    <div class="imglist_w">
        <ul class="imglist">
            <li>
                <a target="_self" href="${ctx}/article/74" title="聂培尧"><img width="120" height="166" alt="聂培尧" src="${ctx}/static/uploads/teacher/pic_niepeiyao.jpg"></a>
                <p>聂培尧</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/73" title="中心主任徐如志"><img width="120" height="166" alt="徐如志" src="${ctx}/static/uploads/teacher/pic_xuruzhi.jpg"></a>
                <p>徐如志</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/75" title="中心副主任郭建峰"><img width="120" height="166" alt="郭建峰" src="${ctx}/static/uploads/teacher/pic_guojianfeng.jpg"></a>
                <p>郭建峰</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/70" title="山东舜德数据管理软件工程有限公司总经理"><img width="120" height="166" alt="田茂圣" src="${ctx}/static/uploads/teacher/pic_tianmaosheng.jpg"></a>
                <p>田茂圣</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/72" title="赵志崑副教授，工学博士，硕士生导师"><img width="120" height="166" alt="赵志崑" src="${ctx}/static/uploads/teacher/pic_zhaozhikun.jpg"></a>
                <p>赵志崑</p>
            </li>
            <li>
                <a target="_self" href="" title="张抗抗副教授，工学博士，硕士生导师"><img width="120" height="166" alt="张抗抗" src="${ctx}/static/uploads/teacher/pic_zhangkangkang.jpg"></a>
                <p>张抗抗</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/66" title="盛秋戬"><img width="120" height="166" alt="盛秋戬" src="${ctx}/static/uploads/teacher/pic_shengqiujian.jpg"></a>
                <p>盛秋戬</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/71" title="林培光副教授"><img width="120" height="166" alt="林培光" src="${ctx}/static/uploads/teacher/pic_linpeiguang.jpg"></a>
                <p>林培光</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/68" title="刘文金"><img width="120" height="166" alt="刘文金" src="${ctx}/static/uploads/teacher/pic_liuwenjin.jpg"></a>
                <p>刘文金</p>
            </li>
            <li>
                <a target="_self" href="${ctx}/article/69" title="王帅强"><img width="120" height="166" alt="王帅强" src="${ctx}/static/uploads/teacher/pic_wangshuaiqiang.jpg"></a>
                <p>王帅强</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/67" title="万海山"><img width="120" height="166" alt="万海山" src="${ctx}/static/uploads/teacher/pic_wanhaishan.jpg"></a>
                <p>万海山</p>
            </li>
            <li>
                <a target="_self" href="" title="杨峰"><img width="120" height="166" alt="杨峰" src="${ctx}/static/uploads/teacher/pic_yangfeng.jpg"></a>
                <p>杨峰</p>
            </li>
            <li>
                <a target="_self" href="" title="张燕"><img width="120" height="166" alt="张燕" src="${ctx}/static/uploads/teacher/pic_zhangyan.jpg"></a>
                <p>张燕</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/62" title="赵华伟"><img width="120" height="166" alt="赵华伟" src="${ctx}/static/uploads/teacher/pic_zhaohuawei.jpg"></a>
                <p>赵华伟</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/64" title="聂秀山博士， 副教授"><img width="120" height="166" alt="聂秀山" src="${ctx}/static/uploads/teacher/pic_niexiushan.jpg"></a>
                <p>聂秀山</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/65" title="王倩"><img width="120" height="166" alt="王倩" src="${ctx}/static/uploads/teacher/pic_wangqian.jpg"></a>
                <p>王倩</p>
            </li>
        </ul>
    </div>
    <a class="abtn aright" href="#right" title="右移"></a>
</div>
<script type="text/javascript" src="${ctx}/static/js/slider.min.js"></script>
<script type="text/javascript">
    $(function(){
        //默认状态下左右滚动
        $("#teacher").Xslider({
            unitdisplayed:5,
            numtoMove:1,
            unitlen:143,
            loop:"cycle",
            autoscroll:3000
        });
    });
</script>