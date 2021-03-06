<#--

    Solo - A small and beautiful blogging system written in Java.
    Copyright (c) 2010-2018, b3log.org & hacpai.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

-->
<#include "macro-head.ftl">
<!DOCTYPE html>
<html>
<head>
<@head title="${allTagsLabel} - ${blogTitle}">
    <meta name="keywords" content="${metaKeywords},${allTagsLabel}"/>
    <meta name="description" content="<#list tags as tag>${tag.tagTitle}<#if tag_has_next>,</#if></#list>"/>
</@head>
</head>
<body>
<#include "header.ftl">
<#include "nav.ftl">
<div class="main">
<#if noticeBoard??>
    <div class="board">
    ${noticeBoard}
    </div>
</#if>
    <div class="wrapper content">
        <div class="module__title">
            <span>
                ${tags?size}
                    <span class="ft-green ft-12">${tagLabel}</span>
            </span>
        </div>
        <div id="tags">
        <#list tags as tag>
            <a rel="tag" data-count="${tag.tagPublishedRefCount}" class="tag"
               href="${servePath}/tags/${tag.tagTitle?url('UTF-8')}">
            ${tag.tagTitle}
                <span class="ft-green ft-12">${tag.tagPublishedRefCount} ${countLabel}</span>
            </a>
        </#list>
        </div>
    </div>
<#include "bottom.ftl">
</div>
<#include "footer.ftl">
<script>
    (function () {
        var $tags = $('#tags');
        var tagsArray = $tags.find('.tag')
        // 根据引用次数添加样式，产生云效果
        var max = parseInt(tagsArray.first().data('count'));
        var distance = Math.ceil(max / 5);
        for (var i = 0; i < tagsArray.length; i++) {
            var count = parseInt($(tagsArray[i]).data('count'));
            // 算出当前 tag 数目所在的区间，加上 class
            for (var j = 0; j < 5; j++) {
                if (count > j * distance && count <= (j + 1) * distance) {
                    tagsArray[i].className = 'tag tag__level' + j;
                    break;
                }
            }
        }

        // 按字母或者中文拼音进行排序
        $tags.html(tagsArray.get().sort(function (a, b) {
            var valA = $(a).text().toLowerCase();
            var valB = $(b).text().toLowerCase();
            // 对中英文排序的处理
            return valA.localeCompare(valB);
        }));
    })();
</script>
</body>
</html>
