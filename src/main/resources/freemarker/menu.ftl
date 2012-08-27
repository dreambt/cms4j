<%@ page contentType="text/html;charset=UTF-8" %>
<#escape x as x?html>
<!-- 导航菜单 -->
<div class="row">
    <div class="span13">
        <div id="top-header">
            <div class="logo"><a href="index.html"><img src="${ctx}/static/images/logo.jpg" alt="" style="vertical-align:middle;margin-right: 10px;margin-bottom:0px;" /><h1>山东省金融信息工程技术研究中心</h1></a></div>
        </div>
        <div class="navbar">
            <div class="navbar-inner">
                <ul class="nav" role="navigation">
                    <li class="active"><a href="${ctx}">首页</a></li>
                    <#list categories as category>
                        <#assign showType=category.showType />
                        <#if (showType = 'NONE')>
                            <li class="dropdown"><a id="drop${category.id}" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'LIST')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/article/list/${category.id}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'DIGEST')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/article/digest/${category.id}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'GALLERY')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/gallery/photo/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'ALBUM')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/gallery/album/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'CONTENT')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/article/content/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'FULL')>
                            <li class="dropdown"><a id="drop${category.id}" href="${ctx}/article/content/full/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a>
                        <#elseif (showType = 'LINK')>
                            <li><a href="${category.url}" role="button">${category.categoryName}</a></li>
                        </#if>
                        <#if (category.subCategories?size > 0)>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop${category.id}">
                            <#list category.subCategories as subCategory>
                                <#assign showType=subCategory.showType />
                                <#if (showType = 'NONE')>
                                    <li><a tabindex="-1" href="${ctx}/${subCategory.url}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'LIST')>
                                    <li><a tabindex="-1" href="${ctx}/article/list/${subCategory.id}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'DIGEST')>
                                    <li><a tabindex="-1" href="${ctx}/article/digest/${subCategory.id}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'GALLERY')>
                                    <li><a tabindex="-1" href="${ctx}/gallery/photo/${subCategory.url}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'ALBUM')>
                                    <li><a tabindex="-1" href="${ctx}/gallery/album/${subCategory.url}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'CONTENT')>
                                    <li><a tabindex="-1" href="${ctx}/article/content/${subCategory.url}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'FULL')>
                                    <li><a tabindex="-1" href="${ctx}/article/content/full/${subCategory.url}">${subCategory.categoryName}</a></li>
                                <#elseif (showType = 'LINK')>
                                    <li><a tabindex="-1" href="${subCategory.url}">${subCategory.categoryName}</a></li>
                                </#if>
                            </#list>
                            </ul>
                        </#if>
                        </li>
                    </#list>
                </ul>
            </div>
        </div>
    </div>
</div>
</#escape>