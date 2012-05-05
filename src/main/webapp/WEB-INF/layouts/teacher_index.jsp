<%--
  名师风采
  Created by IntelliJ IDEA.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-14
  Time: 下午5:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="scrolllist_index" id="teacher">
    <a class="abtn aleft" href="#left" title="左移"></a>
    <div class="imglist_w_index">
        <ul class="imglist_index">
            <li>
                <a target="_self" href="" title="聂培尧"><img width="120" height="166" alt="聂培尧" src="${ctx}/static/uploads/teacher/pic_niepeiyao.jpg"></a>
                <p>聂培尧</p>
            </li>
            <li>
                <a target="_self" href="" title="中心主任徐如志，博士、教授、博士生导师，美国Arizona State University访问教授，IEEE会员，中国云计算专家委员会委员，山东省计算机学会、管理学会常务理事。"><img width="120" height="166" alt="徐如志" src="${ctx}/static/uploads/teacher/pic_xuruzhi.jpg"></a>
                <p>徐如志</p>
            </li>
            <li>
                <a target="_self" href="" title="中心副主任郭建峰，国家“千人计划”特聘专家，多伦多大学Rotman学院研究员；英国雷丁大学研究员，承担ICMA国际资本协会高频交易研究课题；山东财经大学计算金融研究所所长、特聘教授，山东财经大学金融学院金融学硕士生导师。"><img width="120" height="166" alt="郭建峰" src="${ctx}/static/uploads/teacher/pic_guojianfeng.jpg"></a>
                <p>郭建峰</p>
            </li>
            <li>
                <a target="_self" href="" title="山东舜德数据管理软件工程有限公司总经理。"><img width="120" height="166" alt="田茂圣" src="${ctx}/static/uploads/teacher/pic_tianmaosheng.jpg"></a>
                <p>田茂圣</p>
            </li>
            <li>
                <a target="_self" href="" title="赵志崑副教授，工学博士，硕士生导师。澳大利亚中昆士兰大学博士后。多年来一直从事软件体系结构、智能Agent系统、金融信息系统等方面的研究。"><img width="120" height="166" alt="赵志崑" src="${ctx}/static/uploads/teacher/pic_zhaozhikun.jpg"></a>
                <p>赵志崑</p>
            </li>
            <li>
                <a target="_self" href="" title="张抗抗副教授，工学博士，硕士生导师，美国Arizona State University访问学者。多年来一直从事服务计算、信息集成与应用集成及金融云计算综合服务平台等方面的研究。"><img width="120" height="166" alt="张抗抗" src="${ctx}/static/uploads/teacher/pic_zhangkangkang.jpg"></a>
                <p>张抗抗</p>
            </li>
            <li>
                <a target="_self" href="" title="林培光副教授，2006年毕业于北京理工大学，获工学博士学位，硕士生导师，香港科技大学访问学者。多年来一直从事Web数据集成及其相关应用以及金融信息管理系统、金融数据挖掘等方面的研究。"><img width="120" height="166" alt="林培光" src="${ctx}/static/uploads/teacher/pic_linpeiguang.jpg"></a>
                <p>林培光</p>
            </li>
            <li>
                <a target="_self" href="" title="王帅强"><img width="120" height="166" alt="王帅强" src="${ctx}/static/uploads/teacher/pic_wangshuaiqiang.jpg"></a>
                <p>王帅强</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/content1" title="万海山"><img width="120" height="166" alt="万海山" src="${ctx}/static/uploads/teacher/pic_wanhaishan.jpg"></a>
                <p>万海山</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/content2" title="赵华伟"><img width="120" height="166" alt="赵华伟" src="${ctx}/static/uploads/teacher/pic_zhaohuawei.jpg"></a>
                <p>赵华伟</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/content3" title="聂秀山博士， 副教授，毕业于山东大学信息科学与工程学院。近年来主持国家自然基金一项，省两化融合研究课题一项，参与国家973项目和国家自然基金项目多项。主要研究方向为金融信息安全、信息内容安全认证等。"><img width="120" height="166" alt="聂秀山" src="${ctx}/static/uploads/teacher/pic_niexiushan.jpg"></a>
                <p>聂秀山</p>
            </li>
            <li>
                <a target="_blank" href="${ctx}/article/content4" title="王倩"><img width="120" height="166" alt="王倩" src="${ctx}/static/uploads/teacher/pic_wangqian.jpg"></a>
                <p>王倩</p>
            </li>
            <!--
            <li>
                <a target="_blank" href="${ctx}/article/content4" title="谭璐"><img width="120" height="166" alt="谭璐" src="${ctx}/static/uploads/teacher/pic_tanlu.jpg"></a>
                <p>谭璐</p>
            </li>   -->
        </ul>
    </div>
    <a class="abtn aright" href="#right" title="右移"></a>
</div>
<script type="text/javascript" src="${ctx}/static/js/slider.js"></script>
<script type="text/javascript">
    $(function(){
        //默认状态下左右滚动
        $("#teacher").Xslider({
            unitdisplayed:5,
            numtoMove:1,
            unitlen:126,
            loop:"cycle",
            autoscroll:3000
        });
    });
</script>