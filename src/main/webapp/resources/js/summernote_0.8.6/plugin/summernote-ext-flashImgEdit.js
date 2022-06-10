(function (factory) {
  /* global define */
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else if (typeof module === 'object' && module.exports) {
    // Node/CommonJS
    module.exports = factory(require('jquery'));
  } else {
    // Browser globals
    factory(window.jQuery);
  }
}(function ($) {

  // Extends plugins for adding hello.
  //  - plugin is external module for customizing.
  $.extend($.summernote.plugins, {
    /**
     * @param {Object} context - context object has status of editor.
     */
    'flashImgEdit': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;
        var body ='';

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      // add hello button
      context.memo('button.flashImgEdit', function () {
    	 return ui.button({
     	      contents: ui.icon(options.icons.picture),
//              contents: '<i class="glyphicon glyphicon-edit"/> Image-Editor',
              tooltip: '이미지',
              click: function () {
            	  openFlash();
              }
            }).render();
      });
      
      this.initialize = function () {

      };
      
      this.destroy = function () {
      };
      this.bindEnterKey = function (jQueryinput, jQuerybtn) {
          jQueryinput.on('keypress', function (event) {
            if (event.keyCode === 13) { //13은 키코드 엔터값임
              jQuerybtn.trigger('click');
            }
          });
      };
      
      
    }
  });
}))
