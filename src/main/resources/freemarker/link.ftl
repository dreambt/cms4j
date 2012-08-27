<%@ page contentType="text/html;charset=UTF-8" %>
<#escape x as x?html>
<!-- 友情链接 -->
<div class="row">
    <span class="span13">
        <ul id="friLnk" class="nav nav-pills">
            <li class="friLnkT"><strong>友情链接</strong></li>
            <#list links as link>
            <li><a href="${link.url}" target="_blank">${link.title}</a></li>
            </#list>
        </ul>
    </span>
</div>
</#escape>