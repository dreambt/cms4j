<%@ page contentType="text/html;charset=UTF-8" %>
<#escape x as x?html>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="max-age=604800">
    <meta http-equiv="Last-Modified" content="Fri, 12 May 2012 18:53:33 GMT">
    <meta name="robots" content="index, follow">
    <meta name="keywords" content="${article.keyword}">
    <meta name="title" content="${article.subject}">
    <meta name="description" content="${article.digest}">
    <title>${article.subject}</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon">
    <link href="${ctx}/main.min.css" rel="stylesheet" type="text/css">
    <script src="${ctx}/main.min.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <#include "menu.ftl" />
<!-- 文章导航 -->
<div class="row">
    <div class="span12">
        <ul class="breadcrumb">
            <li><a href="${ctx}">首页</a> <span class="divider">/</span></li>
            <li><a href="${ctx}/article/list/3">新闻动态</a> <span class="divider">/</span></li>
            <li class="active">${article.subject}</li>
        </ul>
    </div>
</div>
<div class="row">
    <!-- 正文 -->
    <div class="span9">
        <div class="blog-post">
            <h3>${article.subject}</h3>
            <div class="blog-posted-inner">
                作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: ${article.createdDate} &nbsp; | &nbsp; 浏览次数: ${article.views}
            </div>
        ${article.message}
        </div>
        <!-- Duoshuo Comment BEGIN -->
        <div class="ds-thread" data-thread-key="" data-title="" data-author-key="" data-url="" id="ds-thread"><div class="ds-waiting" style="display: none;"><img width="16" height="11" alt="..." src="data:image/gif;base64,R0lGODlhEAALAPQAAP///z2LqeLt8dvp7u7090GNqz2LqV+fuJ/F1IW2ycrf51aatHWswaXJ14i4ys3h6FmctUCMqniuw+vz9eHs8fb5+meku+Tu8vT4+cfd5bbT3tbm7PH2+AAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCwAAACwAAAAAEAALAAAFLSAgjmRpnqSgCuLKAq5AEIM4zDVw03ve27ifDgfkEYe04kDIDC5zrtYKRa2WQgAh+QQJCwAAACwAAAAAEAALAAAFJGBhGAVgnqhpHIeRvsDawqns0qeN5+y967tYLyicBYE7EYkYAgAh+QQJCwAAACwAAAAAEAALAAAFNiAgjothLOOIJAkiGgxjpGKiKMkbz7SN6zIawJcDwIK9W/HISxGBzdHTuBNOmcJVCyoUlk7CEAAh+QQJCwAAACwAAAAAEAALAAAFNSAgjqQIRRFUAo3jNGIkSdHqPI8Tz3V55zuaDacDyIQ+YrBH+hWPzJFzOQQaeavWi7oqnVIhACH5BAkLAAAALAAAAAAQAAsAAAUyICCOZGme1rJY5kRRk7hI0mJSVUXJtF3iOl7tltsBZsNfUegjAY3I5sgFY55KqdX1GgIAIfkECQsAAAAsAAAAABAACwAABTcgII5kaZ4kcV2EqLJipmnZhWGXaOOitm2aXQ4g7P2Ct2ER4AMul00kj5g0Al8tADY2y6C+4FIIACH5BAkLAAAALAAAAAAQAAsAAAUvICCOZGme5ERRk6iy7qpyHCVStA3gNa/7txxwlwv2isSacYUc+l4tADQGQ1mvpBAAIfkECQsAAAAsAAAAABAACwAABS8gII5kaZ7kRFGTqLLuqnIcJVK0DeA1r/u3HHCXC/aKxJpxhRz6Xi0ANAZDWa+kEAA7AAAAAAAAAAAA" style="margin:0 0 3px 5px"></div><div id="ds-reset"><div class="ds-meta"><a href="javascript:void(0)" class="ds-like-thread-button"><span class="ds-ui-icon"></span> <span class="ds-thread-like-text">喜欢</span><span class="ds-thread-cancel-like">取消喜欢</span></a><span class="ds-like-panel"></span></div><div class="ds-comments-info"><select class="ds-sort"><option value="desc">从新到旧排序</option><option value="asc">从旧到新排序</option></select><ul class="ds-comments-tabs"><li class="ds-tab"><a class="ds-comments-tab-duoshuo ds-current" href="javascript:void(0);"><span class="ds-highlight">0</span>条评论</a></li></ul></div><ul class="ds-comments"></ul><div class="ds-paginator" style="display: none;"><div class="ds-border"></div><a data-page="1" href="javascript:void(0);" class="ds-current">1</a></div><div class="ds-toolbar"><div class="ds-border-highlight"></div><div class="ds-visitor"><span class="ds-visitor-avatar"><img src="./article_files/50"></span><a class="ds-visitor-name" href="http://weibo.com/im47cn" target="_blank">思奇</a><a class="ds-unread-comments-count" href="javascript:void(0);" title="新回复"></a><span><a style="vertical-align:baseline" target="_blank" rel="nofollow" href="http://duoshuo.com/settings/">设置</a></span></div><div class="ds-account-control"><span class="ds-ui-icon"></span> <span>帐号管理</span><ul><li><a class="ds-bind-more" href="javascript:void(0);" style="border-top: none">绑定更多</a></li><li><a target="_blank" href="http://duoshuo.com/settings/">设置</a></li><li><a rel="nofollow" href="http://sdfie.duoshuo.com/logout/" style="border-bottom: none">登出</a></li></ul></div></div><div style="height:0px;"><a name="respond">&nbsp;</a></div><div class="ds-replybox"><form method="post" action="" onsubmit="return false;"><input type="hidden" name="thread_id" value="1400785510368018459"><input type="hidden" name="parent_id" value=""><div class="ds-replybox-main"><div class="ds-textarea-wrapper"><textarea name="message" title="Ctrl+Enter快捷提交" placeholder="说点什么吧 ..."></textarea><pre class="ds-hidden-text"></pre></div><div class="ds-post-toolbar"><div class="ds-post-options"><span class="ds-sync"><input id="ds-sync-checkbox" type="checkbox" name="repost" checked="checked" value="weibo,qzone,renren,douban"> <label for="ds-sync-checkbox">同时分享到:</label> <span class="ds-connected-sites"><a href="javascript:void(0)" class="ds-service-icon ds-weibo ds-weibo-active" data-service="weibo" title="新浪微博"></a></span><span class="ds-connected-sites"><a href="javascript:void(0)" class="ds-service-icon ds-qqt" data-service="qqt" title="腾讯微博"></a></span><span class="ds-connected-sites"><a href="javascript:void(0)" class="ds-service-icon ds-qzone ds-qzone-active" data-service="qzone" title="QQ空间"></a></span><span class="ds-connected-sites"><a href="javascript:void(0)" class="ds-service-icon ds-renren ds-renren-active" data-service="renren" title="人人网"></a></span><span class="ds-connected-sites"><a href="javascript:void(0)" class="ds-service-icon ds-douban ds-douban-active" data-service="douban" title="豆瓣网"></a></span></span></div><button class="ds-post-button" type="submit">发 布</button><div class="ds-toolbar-buttons"><a class="ds-toolbar-button ds-add-emote" title="插入表情"></a></div></div></div></form></div><p class="ds-powered-by"><a href="http://duoshuo.com/" target="_blank" rel="nofollow">山东省金融信息工程技术研究中心正在使用多说</a></p></div></div>
        <script type="text/javascript">
        var duoshuoQuery = {short_name:"sdfie"};
        (function() {
            var ds = document.createElement('script');
            ds.type = 'text/javascript';ds.async = true;
            ds.src = 'http://static.duoshuo.com/embed.js';
            ds.charset = 'UTF-8';
            (document.getElementsByTagName('head')[0]
            || document.getElementsByTagName('body')[0]).appendChild(ds);
        })();
        </script>
        <!-- Duoshuo Comment END -->
    </div>
    <!-- 边栏 -->
    <div class="span3">
        <div class="well sidebar-nav">
            <ul class="nav nav-list">
                <li class="nav-header">相关分类</li>
                <li><a href="http://localhost/cms4j/article/list/3">新闻动态</a></li>
                <li><a href="http://localhost/cms4j/article/list/4">行业资讯</a></li>
                <li><a href="http://localhost/cms4j/article/list/5">学术交流</a></li>
            </ul>
        </div>
        <div class="well sidebar-nav">
            <ul class="nav nav-list">
                <li class="nav-header">最新文章</li>

                <li><a href="http://localhost/cms4j/article/76">研究中心与山东中孚公司战略合作签约仪...</a></li>

                <li><a href="http://localhost/cms4j/article/76">张抗抗</a></li>

                <li><a href="http://localhost/cms4j/article/75">郭建峰</a></li>

                <li><a href="http://localhost/cms4j/article/74">聂培尧</a></li>

                <li><a href="http://localhost/cms4j/article/73">徐如志</a></li>

                <li><a href="http://localhost/cms4j/article/72">赵志崑</a></li>

                <li><a href="http://localhost/cms4j/article/71">林培光</a></li>

                <li><a href="http://localhost/cms4j/article/70">田茂圣</a></li>

            </ul>
        </div>
        <div class="well sidebar-nav">
            <ul class="nav nav-list">
                <li class="nav-header">存档分类</li>

                <li><a href="http://localhost/cms4j/archive/list/4">2012年06月&nbsp;(1)</a></li>

                <li><a href="http://localhost/cms4j/archive/list/3">2012年05月&nbsp;(32)</a></li>

                <li><a href="http://localhost/cms4j/archive/list/1">2012年04月&nbsp;(36)</a></li>

                <li><a href="http://localhost/cms4j/archive/list/2">2012年03月&nbsp;(2)</a></li>

                <li><a href="http://localhost/cms4j/archive/list">更多存档...</a></li>
            </ul>
        </div>
        <div class="well sidebar-nav">
            <ul class="nav nav-list">
                <li class="nav-header">QR 码</li>
                <li id="qrcode"></li>
            </ul>
        </div>
    </div>
</div>
    <#include "menu.ftl" />
<!-- 页脚 -->
<footer class="footer">
        <p>地址: 山东省济南市市中区舜耕路40号山东财经大学 | 电话: 0531-82917318 | <a href="http://localhost/cms4j/login" target="_blank">后台登录</a> | <a href="http://localhost/cms4j/aboutUs">开发团队</a> | <a href="mailto:baitao.jibt@gmail.com">日常维护</a> | <script type="text/javascript">
            var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
            document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5dedfd149fac273672919728590e3322' type='text/javascript'%3E%3C/script%3E"));
        </script></p>
        <p>Copyright © 2012 <a href="http://dreambt.github.com/cms4j" target="_blank">cms4j</a> Build 20121130. All Rights Reserved.</p>
</footer>
<script type="text/javascript">
    $(function(){
        $("#qrcode").MyQRCode();

        //设置图片宽度最大为676px
        $('.blog-post img').each(function(i){
            //alert($(this).width());
            if($(this).width()>676){
                var b=676/($(this).width());
                $(this).width(676);
                $(this).height($(this).height()*b);
            }
        });

        //totop
        $().UItoTop({ easingType:'easeOutQuart' });
        //$("#ads").responsiveSlides();
        //var el=$i("nav_"+navid); if(el!=null) el.className="ahover";
    });
</script>
</div><a href="http://localhost/cms4j/article/77#" id="toTop" style="display: none;"><span id="toTopHover"></span>To Top</a><iframe name="easyXDM_default904_provider" id="easyXDM_default904_provider" style="position: absolute; top: -2000px; left: 0px;" frameborder="0" src="./article_files/index.htm"></iframe><div id="ds-notify" class="ds-top-right" style="display: none;"></div><div id="ds-indicator"><img src="./article_files/loading.gif"></div></body></html>
</#escape>