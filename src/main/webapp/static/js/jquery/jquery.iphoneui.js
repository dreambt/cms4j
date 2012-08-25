/**
 * .addTouch();
 *
 * .addTouch is a plugin for jQuery to convert touch events into simulated mouse events
 * Most of jQuery UI is supported. See the proof of concept here:
 *
 *		http://spaceyraygun.net/mobile/jquery-ui-iphone.html
 *
 * The original code was altered slightly because it would simulate mouse events on every
 * element which blocked native events like scrolling and zooming.
 *
 * To use this, simply call .addTouch() to a jQuery object and the events will be attached
 * to those results only.
 *
 * @plugin_author: jason kuhn (http://jasonkuhn.net)
 * @original_author: ross boucher (http://rossboucher.com/2008/08/19/iphone-touch-events-in-javascript/)
 */

;(function($){
	$.iPhone = {
		init: function()
		{
			$(window).bind('orientationchange',$.iPhone.updateOrientation);
			this.updateOrientation();
			$('body').css({'min-height':'420px','min-width': '320px'});
		},
		
		orientation: 'portrait',
		updateOrientation: function()
		{
			this.orientation = (window.orientation === 0 || window.orientation == null || window.orientation === 180) ?  'portrait' : 'landscape';
			$('body').attr('orient',this.orientation);
			setTimeout($.iPhone.hideURL,100);
		},
		
		hideURL: function()
		{
			window.scrollTo(0, 1);
			setTimeout(function(){
				window.scrollTo(0, 0);
			}, 0);
		},
		
		preloadImages: function(images)
		{		
			$(images).each(function(key,val){
				(new Image()).src = val;			
			});
		}
	};

	$.fn.addTouch = function()
	{
		this.each(function(i,el){
			$(el).bind('touchstart touchmove touchend touchcancel',function(){
				//we pass the original event object because the jQuery event
				//object is normalized to w3c specs and does not provide the TouchList
				handleTouch(event);
			});
		});
		
		var handleTouch = function(event)
		{
			var touches = event.changedTouches,
			first = touches[0],
			type = '';
			
			switch(event.type)
			{
				case 'touchstart':
					type = 'mousedown';
					break;
					
				case 'touchmove':
					type = 'mousemove';
					break;        
					
				case 'touchend':
					type = 'mouseup';
					break;
					
				default:
					return;
			}
			
			var simulatedEvent = document.createEvent('MouseEvent');
			simulatedEvent.initMouseEvent(type, true, true, window, 1, first.screenX, first.screenY, first.clientX, first.clientY, false, false, false, false, 0/*left*/, null);
																 
			first.target.dispatchEvent(simulatedEvent);
			
			event.preventDefault();
		};
	};
})(jQuery);

$(document).ready(function(){
	$.iPhone.init();
});