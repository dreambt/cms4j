/*!
 * jQuery Loading Plugin
 * https://github.com/tjgupta/jQuery-Loading-Plugin
 *
 * Copyright 2012, Tim Gupta
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
 */
(function($) {
    // Ajax request loading widget
    $.fn.loading = function(options) {

        // private properties

        // private methods
        var getDimensions = function(elem) {
            var width = elem.width(),
                height = elem.height();
            return {'width': width, 'height': height};
        };


        return this.each(function() {
            var $this = $(this),
                settings = $.extend({
                    'stop' : false,
                    'loadingClass': 'loading',
                    'loadingContent': '<p>Loading...</p>'
                }, options);

            if (!settings.stop) {
                var containerDims = getDimensions($this),
                    loadingDiv = $('<div class="' + settings.loadingClass + '">' + settings.loadingContent + '</div>'),
                    offset = $this.offset();
                $('body').append(loadingDiv);
                var loaderDims = getDimensions(loadingDiv);
                loadingDiv.css({
                    'left': offset.left,
                    'top': offset.top + ((containerDims.height - loaderDims.height) / 2) + 'px',
                    'position': 'absolute',
                    'height': loaderDims.height,
                    'width': containerDims.width,
                    'text-align': 'center'
                });
            } else {
                $('.' + settings.loadingClass).remove();
            }
        });
    }
})(jQuery);