/*!
 * Buttons helper for fancyBox
 * version: 1.0.3
 * @requires fancyBox v2.0 or later
 *
 * Usage:
 *     $(".fancybox").fancybox({
 *         helpers : {
 *             buttons: {
 *                 position : 'top'
 *             }
 *         }
 *     });
 *
 * Options:
 *     tpl - HTML template
 *     position - 'top' or 'bottom'
 *
 */
(function(b){var a=b.fancybox;a.helpers.buttons={tpl:'<div id="fancybox-buttons"><ul><li><a class="btnPrev" title="Previous" href="javascript:;"></a></li><li><a class="btnPlay" title="Start slideshow" href="javascript:;"></a></li><li><a class="btnNext" title="Next" href="javascript:;"></a></li><li><a class="btnToggle" title="Toggle size" href="javascript:;"></a></li><li><a class="btnClose" title="Close" href="javascript:jQuery.fancybox.close();"></a></li></ul></div>',list:null,buttons:null,beforeLoad:function(c,d){if(c.skipSingle&&d.group.length<2){d.helpers.buttons=false;d.closeBtn=true;return}d.margin[c.position==="bottom"?2:0]+=30},onPlayStart:function(){if(this.buttons){this.buttons.play.attr("title","Pause slideshow").addClass("btnPlayOn")}},onPlayEnd:function(){if(this.buttons){this.buttons.play.attr("title","Start slideshow").removeClass("btnPlayOn")}},afterShow:function(d,e){var c=this.buttons;if(!c){this.list=b(d.tpl||this.tpl).addClass(d.position||"top").appendTo("body");c={prev:this.list.find(".btnPrev").click(a.prev),next:this.list.find(".btnNext").click(a.next),play:this.list.find(".btnPlay").click(a.play),toggle:this.list.find(".btnToggle").click(a.toggle)}}if(e.index>0||e.loop){c.prev.removeClass("btnDisabled")}else{c.prev.addClass("btnDisabled")}if(e.loop||e.index<e.group.length-1){c.next.removeClass("btnDisabled");c.play.removeClass("btnDisabled")}else{c.next.addClass("btnDisabled");c.play.addClass("btnDisabled")}this.buttons=c;this.onUpdate(d,e)},onUpdate:function(d,e){var c;if(!this.buttons){return}c=this.buttons.toggle.removeClass("btnDisabled btnToggleOn");if(e.canShrink){c.addClass("btnToggleOn")}else{if(!e.canExpand){c.addClass("btnDisabled")}}},beforeClose:function(){if(this.list){this.list.remove()}this.list=null;this.buttons=null}}}(jQuery));