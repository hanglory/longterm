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
    'cafeImage': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      
      // add hello button
      context.memo('button.cafeImage', function () {
    	  return ui.button({
//          contents: '<i class="note-icon-picture"/> 팍스넷이미지삽입',
  	      contents: ui.icon(options.icons.picture),
          tooltip: '이미지',
          click: function () {
        	  
        	  context.invoke('editor.saveRange');
        	  
        	  var body = '' +
        	    '	<div class="pop-inner">'+
	        	'	<div class="popup-wrap wid-m">' +
	        	'		<div class="pop-tit"><span>이미지 삽입</span></div>' +
	        	'		<form id="summernoteForm" name="summernoteForm" onsubmit="return false;">' +
	        	'		<div class="pop-cont">' +
	        	'				<div class="poll-pop">' +
	        	'					<p class="tit-h2"><label for="subj">파일선택</label></p>' +
	        	'					<span class="input-style">' +
	        	'						<input type="text" id="summernoteImageFileText" placeholder="이미지 등록" title="이미지 등록" readonly>' +
				'					</span>' +
				'						<button type="button" class="btn-t gray _summernoteImageFileButton">찾아보기</button>' +
	        	'					<br>' +
	        	'					<p class="tit-h2"><label for="subj">이미지 URL</label></p>' +
	        	'					<div class="subj-w">' +
	        	'						<span class="input-style">' +
	        	'							<input type="text" id="imageUrl" placeholder="이미지 URL을 입력하세요"/>' +
	        	'							<button type="button" class="delete">삭제</button>' +
	        	'						<span>' +
	        	'					</div> ' +
	        	'			</div> ' +
    	'					<div class="pop-btn">' +
    	'						<button type="button" class="btn-s bodrb">취소</button>' +
    	'						<button type="button" class="btn-s red">확인</button>' +
    	'					</div> ' +
    			'		</form> '+
	        	'		</div> ' +
	        	'		<button class="cla-close">닫기</button> ' +
	        	'	</div> '+
	        	'	</div> ';
  			 
             $('#popArea').html(body);

             $('body').addClass('open-modal');//모바일에서 위로 올리기 위해
             $('#popArea').show();
             
     		 //파일찾기
     		 $('#summernoteImageFileText').on('click', function(){
				$("#popArea").append('<input type="file" class="summernote_imageFile" name="summernoteImageFiles" style="display:none; accept="image/*""/>');
 				$("#popArea .summernote_imageFile").last().click();
     			return false;
     		 });
             
     		$('._summernoteImageFileButton').click(function(e) {
//				e.preventDefault();
				$("#summernoteImageFileText").click();
    		});
     		
    		$(document).on('change', '.summernote_imageFile', function(){
    			if ($(this).val() != "") {
    				$("#summernoteImageFileText").val($(this).val());
    			}
    		});
     		 
     		 //닫기
     		 $('button.cla-close').on('click', function(){
                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
     			 $(".pop-layer").hide();
     			 return false;
     		 });
     		 
     		 //취소
     		 $('button.bodrb').on('click', function(){
                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
     			$(".pop-layer").hide(); 
     			return false;
     		 });
             
     		 //등록
     		 $('button.red').on('click', function(){
     			 if($('#imageUrl').val()){
     				context.invoke('editor.restoreRange');
     				context.invoke('editor.focus');
     				context.invoke('editor.insertImage', $('#imageUrl').val());
     				
	                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
     				$(".pop-layer").hide(); 
     			 }else{
     				var file = $("#popArea .summernote_imageFile").last().get(0).files[0];
     				
     				var reader = new FileReader();
     				reader.onload = function (event) {
						var imgtag = '<img class="summernoteImage" data-filename="' + file.name + '" src="' + event.target.result + '" />';
	     				context.invoke('editor.restoreRange');
	     				context.invoke('editor.focus');
						context.invoke('editor.pasteHTML', imgtag);

						$('body').removeClass('open-modal');//모바일에서 원복하기 위해서
						$(".pop-layer").hide(); 
     				};
     				
     				reader.readAsDataURL(file);

     				//실제 파일 객체 remove
    				$("#popArea .summernote_imageFile").remove();
     			 }
     		 });
          }
        }).render();
      });
   }

  });
}));