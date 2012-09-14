/*!
 * Thumbnail helper for fancyBox
 * version: 1.0.6
 * @requires fancyBox v2.0 or later
 *
 * Usage:
 *     $(".fancybox").fancybox({
 *         helpers : {
 *             thumbs: {
 *                 width  : 50,
 *                 height : 50
 *             }
 *         }
 *     });
 *
 * Options:
 *     width - thumbnail width
 *     height - thumbnail height
 *     source - function to obtain the URL of the thumbnail image
 *     position - 'top' or 'bottom'
 *
 */
(function(b){var a=b.fancybox;a.helpers.thumbs={wrap:null,list:null,width:0,source:function(d){var c;if(d.element){c=b(d.element).find("img").attr("src")}if(!c&&d.type==="image"&&d.href){c=d.href}return c},init:function(f,i){var e=this,g,c=f.width||50,h=f.height||50,d=f.source||this.source;g="";for(var j=0;j<i.group.length;j++){g+='<li><a style="width:'+c+"px;height:"+h+'px;" href="javascript:jQuery.fancybox.jumpto('+j+');"></a></li>'}this.wrap=b('<div id="fancybox-thumbs"></div>').addClass(f.position||"bottom").appendTo("body");this.list=b("<ul>"+g+"</ul>").appendTo(this.wrap);b.each(i.group,function(l){var k=d(i.group[l]);if(!k){return}b("<img />").load(function(){var q=this.width,m=this.height,p,n,o;if(!e.list||!q||!m){return}p=q/c;n=m/h;o=e.list.children().eq(l).find("a");if(p>=1&&n>=1){if(p>n){q=Math.floor(q/n);m=h}else{q=c;m=Math.floor(m/p)}}b(this).css({width:q,height:m,top:Math.floor(h/2-m/2),left:Math.floor(c/2-q/2)});o.width(c).height(h);b(this).hide().appendTo(o).fadeIn(300)}).attr("src",k)});this.width=this.list.children().eq(0).outerWidth(true);this.list.width(this.width*(i.group.length+1)).css("left",Math.floor(b(window).width()*0.5-(i.index*this.width+this.width*0.5)))},beforeLoad:function(c,d){if(d.group.length<2){d.helpers.thumbs=false;return}d.margin[c.position==="top"?0:2]+=((c.height||50)+15)},afterShow:function(c,d){if(this.list){this.onUpdate(c,d)}else{this.init(c,d)}this.list.children().removeClass("active").eq(d.index).addClass("active")},onUpdate:function(c,d){if(this.list){this.list.stop(true).animate({left:Math.floor(b(window).width()*0.5-(d.index*this.width+this.width*0.5))},150)}},beforeClose:function(){if(this.wrap){this.wrap.remove()}this.wrap=null;this.list=null;this.width=0}}}(jQuery));