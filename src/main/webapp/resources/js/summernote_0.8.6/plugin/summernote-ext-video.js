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

    var videoUrl = '';
  // Extends plugins for adding hello.
  //  - plugin is external module for customizing.
  $.extend($.summernote.plugins, {
  
    /**
     * @param {Object} context - context object has status of editor.
     */
    'paxvideo': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
        var jQueryvideo;
	  
	  context.memo('button.paxvideo', function () {
	      return ui.button({
	        contents: ui.icon(options.icons.video),
	        tooltip: '동영상',
	        click: function(){
	        	
	        	 context.invoke('editor.saveRange');
	        	  var body = '' +
	        	  	'	<div class="pop-inner">'+
		        	'	<div class="popup-wrap wid-m">' +
		        	'		<div class="pop-tit"><span>동영상 삽입</span></div>' +
		        	'		<form id="imageFileUpload" name="imageFileUpload" method="post" enctype="multipart/form-data" onsubmit="return false;">' +
		        	'		<div class="pop-cont">' +
		        	'				<div class="poll-pop">' +
		        	'					<p class="tit-h2"><label for="subj">동영상 URL</label></p>' +
		        	'					<div class="subj-w">' +
		        	'						<span class="input-style">' +
		        	'							<input type="text" id="videoUrl" placeholder="동영상 URL을 입력하세요"/>' +
		        	'							<button type="button" class="delete">삭제</button>' +
		        	'						</span>' +
		        	'					</div> ' +
		        	'					<br> ' +
		        	'					<p class="small">YouTube, 네이버TV, 카카오TV 의 공유 URL 주소를 입력하세요.' +
		        	'					</p> ' +
		        	'			</div> ' +
	    	'					<div class="pop-btn">' +
	    	'						<button type="button" class="btn-s bodrb">취소</button>' +
	    	'						<button type="button" class="btn-s red">확인</button>' +
	    	'					</div> ' +
	    			'		</form> '+
		        	'		</div> ' +
		        	'		<button class="cla-close">닫기</button> ' +
		        	'	</div> ' +
		        	'	</div> ' ;
	  			 
	             $('#popArea').html(body);

	             $('body').addClass('open-modal');//모바일에서 위로 올리기 위해
	             $('#popArea').show();
	             $('#videoUrl').trigger('focus');
	             
	     		 //닫기
	     		 $('button.cla-close').on('click', function(){
	                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
	     			$(".pop-layer").hide(); 
	     		 });
	             
	     		 //취소
	     		 $('button.bodrb').on('click', function(){
	                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
	     			$(".pop-layer").hide(); 
	     		 });
	             
	     		 //등록
	     		 $('button.red').on('click', function(){
	     			 var url = $('#videoUrl').val();
//		     			self.createVideoNode(url);
		     			var preHtml = '<div class="iframe-style">';
		     			var videoHtml = self.createVideoNode(url);
		     			var postHtml = '</div>';
		     			var node = preHtml+videoHtml+postHtml;
//		     			var node = videoHtml;
		    	        if (videoHtml) {
		    	        	// insert video node
		     				context.invoke('editor.restoreRange');
//		     				context.invoke('editor.focus');
		    	        	context.invoke('editor.pasteHTML', node);
			                $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
	    	        	$(".pop-layer").hide(); 
	    		    }
	     		 });	        	
	        	
	     		 //지우기
	     		 $('button.delete').on('click', function(){
	     			 $(this).siblings().val('');
	     		 })
	     		 
	        }
	      }).render();
	    });

	    this.initialize = function () {
	      var jQuerycontainer = options.dialogsInBody ? jQuery(document.body) : jQueryeditor;

	      var body = '<div class="form-group row-fluid">' +
	          '<label>' + lang.video.url + ' <small class="text-muted">' + lang.video.providers + '</small></label>' +
	          '<form id="videoForm">' +
	          '<input class="note-video-url form-control span12" type="text" name="videoUrl"/>' +
	          '</form>';
	          '</div>';
	      var footer = '<button href="#" class="btn btn-primary note-video-btn disabled" disabled>' + lang.video.insert + '</button>';

	      this.jQuerydialog = ui.dialog({
	        title: lang.video.insert,
	        fade: options.dialogsFade,
	        body: body,
	        footer: footer
	      }).render().appendTo(jQuerycontainer);
	    };

	    this.destroy = function () {
	      ui.hideDialog(this.jQuerydialog);
	      this.jQuerydialog.remove();
	    };


	    this.createVideoNode = function (url) {
	      var ytRegExp = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
	      var ytMatch = url.match(ytRegExp);

	      //	http://tv.naver.com/v/1818438
	      var naverRegExp = /^http:\/\/tv.naver.com\/v\/([0-9]{7,9})+$/;
	      var naverMatch = url.match(naverRegExp);

	      //     http://tv.kakao.com/v/374626657
	      var daumRegExp = /^http:\/\/tv.kakao.com\/v\/(.[a-zA-Z0-9]*)/;
	      var daumMatch = url.match(daumRegExp);
	      var html = null

	      if(!url.trim()){
	    	  alert('동영상 URL을 입력해 주세요.')
	    	  return false;
	      }else{
	    	  if (ytMatch && ytMatch[1].length === 11) {
	    		  self.getVideoTag(url);
	    		  html = self.setIframeTag(videoUrl);
	    	  } else if (naverMatch && naverMatch[0].length) {
	    		  self.getVideoTag(url);
	    		  html = self.setIframeTag(videoUrl);
	    	  } else if (daumMatch && daumMatch[1].length) {
	    		  self.getVideoTag(url);
	    		  html = self.setIframeTag(videoUrl);
	    	  } else {
	    		  alert('지원하지 않는 동영상 서비스입니다.')
	    		  return false;
	    	  }
	      }
	      
//	      jQueryvideo.addClass('note-video-clip');
//	      return jQueryvideo[0];
	      return html;
//	      return jQueryvideo;
	    };
	    
	    this.setIframeTag = function(url){
	    	if(url != null && url != ''){
//	    		jQueryvideo = jQuery('<iframe>')
//	    		.attr('frameborder', 0)
//	    		.attr('src', url)
//	    		.attr('style', 'position:absolute;top:0;left:0;width:100%;height:100%')
//	    		.attr('width', '640').attr('height', '360')
//	    		var videoHtml = '<iframe frameborder="0" src="'+url+'" style="position:absolute;top:0;left:0;width:100%;height:100%"></iframe>'
//	    		var videoHtml = '<iframe frameborder="0" src="'+url+'" width="640" height="360"></iframe>'
	    		var videoHtml = '<iframe src="'+url+'"></iframe>'
	    		console.log(videoHtml);
	    		return videoHtml;

	    	}else{
	    		alert('지원하지 않는 동영상 서비스입니다.')
	    		return false;
	    	}
	    }
	    
	    this.getVideoTag = function(inputUrl){
	    	var callCtx = $('#callCtx').val();

	    	$.ajax({
	    		url: callCtx + '/editor/videoAjax',
	    		data: {'url': inputUrl},
	    		method: "POST",
	    		async: false,
	    		success: function(data){
					if(data.resultCode == "URL_FAIL"){
						alert("해당URL [" + inputUrl + "]은 접근이 불가합니다.");
						videoUrl = "";
						return;
					} else if(data.resultCode == "NO_VIDEO"){
						alert("해당URL [" + inputUrl + "]은 동영상이 아닙니다.");
						videoUrl = "";
						return;
					} else if(data.resultCode == "FAIL_KAKAO_URL"){
						alert("시스템 설정이 잘못되었습니다.");
						videoUrl = "";
						return;
					}
					
					videoUrl = data.videoUrl;
	    			console.log('url>>>> ' + videoUrl)
	    		}, 
	    	});
	    }
	    
	    this.show = function () {
	      var text = context.invoke('editor.getSelectedText');
	      context.invoke('editor.saveRange');
	      this.showVideoDialog(text).then(function (url) {
	        // [workaround] hide dialog before restore range for IE range focus
	       // ui.hideDialog(self.jQuerydialog);
	        context.invoke('editor.restoreRange');

	        // build node
	        var jQuerynode = self.createVideoNode(url);
	        
	        if (jQuerynode) {
	          // insert video node
	          context.invoke('editor.insertNode', jQuerynode);
	        	
	        }
	      }).fail(function () {
	        context.invoke('editor.restoreRange');
	      });
	    };    
    
	    /**
	     * show image dialog
	     *
	     * @param {jQuery} jQuerydialog
	     * @return {Promise}
	     */
	    this.showVideoDialog = function (text) {
	      return jQuery.Deferred(function (deferred) {
	        var jQueryvideoUrl = self.jQuerydialog.find('.note-video-url'),
	            jQueryvideoBtn = self.jQuerydialog.find('.note-video-btn');

	        ui.onDialogShown(self.jQuerydialog, function () {
	          context.triggerEvent('dialog.shown');

	          jQueryvideoUrl.val(text).on('input', function () {
	            ui.toggleBtn(jQueryvideoBtn, jQueryvideoUrl.val());
	          }).trigger('focus');

	          jQueryvideoBtn.click(function (event) {
	            event.preventDefault();

	            deferred.resolve(jQueryvideoUrl.val());
	          });

//	          self.bindEnterKey(jQueryvideoUrl, jQueryvideoBtn);
	           
	        });

	        ui.onDialogHidden(self.jQuerydialog, function () {
	          jQueryvideoUrl.off('input');
	          jQueryvideoBtn.off('click');

	          if (deferred.state() === 'pending') {
	            deferred.reject();
	          }
	        });

	        ui.showDialog(self.jQuerydialog);
	      });
	    };
	  }
//	  }	        
  });
}));

