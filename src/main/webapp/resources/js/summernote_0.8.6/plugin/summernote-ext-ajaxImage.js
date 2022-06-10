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
    'ajaxImage': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      
      // add hello button
      context.memo('button.ajaxImage', function () {
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
		        '						<input multiple="multiple" id="imageFile" type="file" name="imageFile" />' +
		       	'						<input type="hidden" name="group1Id" id="group1Id" value="' + $('#group1Id').val() + '"/>' +
		       	'						<input type="hidden" name="group2Id" id="group2Id" value="' + $('#group2Id').val() + '"/>' +
		       	'					</span>' +
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
             
     		 //닫기
     		 $('button.cla-close').on('click', function(){
                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
                 
     			$(".pop-layer").hide();
     			return false;
//     			$('.pop-layer').attr('style', 'display: none !important');
     		 });
             
     		 //취소
     		 $('button.bodrb').on('click', function(){
                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서

                 $(".pop-layer").hide(); 
     			return false;
//     			$('.pop-layer').attr('style', 'display: none !important');
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
     				 self.ajaxFileUpload();
     			 }
     		 });
          }
        }).render();
      });

      this.ajaxFileUpload = function () {
    	  var fileObj = $('#imageFile').val();
    	  var fileInput = document.getElementById("imageFile"); 
    	  var files = fileInput.files; 	
    	  var validCheck = true;
    	  var maxSize = 10 * 1024 * 1024 // 10MB
    	  var fileSize = 0;
    	  for(var i=0; i<files.length; i++) {
    		  var file = files[i];
    		  var fileObj = file.name;
  			  fileSize = file.size;
  	    	  var pathHeader ;
  	    	  var pathMiddle; 
  	    	  var pathEnd ;
  	    	  var fileName ;
  	    	  var extName;
  	    	  var allFilename;
   			  var regex = /^[0-9a-zA-Zㄱ-힣._\[\]]*$/;
  			  if (fileObj != "") {
  		            pathHeader = fileObj.lastIndexOf("\\");
  		            pathMiddle = fileObj.lastIndexOf(".");
  		            pathEnd = fileObj.length;
  		            fileName = fileObj.substring(pathHeader+1, pathMiddle);
  		            extName = fileObj.substring(pathMiddle+1, pathEnd).toLowerCase();
  		            allFilename = fileName+"."+extName;

  		  			 if(!extName){
  		  		 		alert('파일을 선택해 주세요.');
  		  		 		validCheck = false;
  		  				return false;
  		  			 }else if($.inArray(extName, ['gif', 'png', 'jpg', 'jpeg', 'bmp']) == -1){		//파일 유효성 검사
  		  				alert('gif, png, jpg, jpeg, bmp 파일만 업로드 할 수 있습니다.');
  		  				validCheck = false;
  		  				return false;
  		  	         }else if(!regex.test(fileName)){
  		  	 			alert('올바른 파일 형식이 아닙니다.');
  		  	 			validCheck = false;
  		  				return false;
  		  	         } else if (fileSize > maxSize) {
  		  	        	alert('파일 용량을 초과했습니다. 파일크기는 10MB까지 가능합니다.');
  		  	        	validCheck = false;
						return;
  		  	         }
  			 }
    	  }
		 if(validCheck) {
	    	var callCtx = $('#callCtx').val();
	    	var formData = new FormData();

	    	  formData.append("group1Id", $('#group1Id').val());
	    	  formData.append("group2Id", $('#group2Id').val());
	    	  
	    		var imageFile = document.querySelector('input[id=imageFile]');
	    		for (var i = 0, l = imageFile.files.length; i < l; i++) {
	    			formData.append('uploadImageFiles', imageFile.files[i]);
	    		}

				$.ajax({
				    url: callCtx + "/editor/imgFileUploadAjax",
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					beforeSend : function(){
						//마우스 커서를 로딩 중 커서로 변경
					    $('html').css("cursor", "wait");
					},
					success : function(data) {
						if(data.resultCode == "UPLOAD_FAIL"){
							alert('파일 저장에 실패했습니다.');
							return;
						}else if(data.resultCode == "NOT_KEY"){
							alert('파일 저장에 필요한 정보가 부족합니다.');
							return;
						}else if(data.resultCode == "MAX_SIZE"){
							alert('파일 용량을 초과했습니다. 파일크기는 10MB까지 가능합니다.');
							return;
						}
						var fileHtml = '';
						var imgtag = '';
						var fileList = data.fileList;
						for (var i=0; i<fileList.length; i++) {
							var val = fileList[i];
							imgtag += '<img class="lazy _summernoteImage" src="'+val.fileURL+val.fileName+'" alt="'+val.fileName+'" />';
						}
						context.invoke('editor.restoreRange');
						context.invoke('editor.focus');
						context.invoke('editor.pasteHTML', imgtag);
		                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
						$(".pop-layer").hide(); 
					},error:function(xhr, textStatus) {
						$('html').css("cursor", "auto"); 
						alert('파일 저장에 실패했습니다.');
					},complete : function(result) {
						$('html').css("cursor", "auto"); 
					}
		  		});
         } 
   }

      this.show = function () {
          context.invoke('editor.saveRange');
          this.showImageDialog().then(function (data) {
            // [workaround] hide dialog before restore range for IE range focus
            ui.hideDialog(self.jQuerydialog);
            context.invoke('editor.restoreRange');
            //console.log(data);
            if (typeof data === 'string') { // image url
              context.invoke('editor.insertImage', data);
            } else { // array of files
            	
              //context.invoke('editor.insertImagesOrCallback', data);
            	self.ajaxFileUpload();
//            	ajaxFileUpload();
            	
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
      this.showImageDialog = function () {
        return jQuery.Deferred(function (deferred) {
          var jQueryimageInput = self.jQuerydialog.find('.note-ajax-image-input'),
              jQueryimageUrl = self.jQuerydialog.find('.note-image-url'),
              jQueryimageBtn = self.jQuerydialog.find('.note-image-btn');

          ui.onDialogShown(self.jQuerydialog, function () {
            context.triggerEvent('dialog.shown');

            // Cloning imageInput to clear element.
            jQueryimageInput.replaceWith(jQueryimageInput.clone()
              .on('change', function () {
                deferred.resolve(this.files || this.value);
              })
              .val('')
            );

            jQueryimageBtn.click(function (event) {
              event.preventDefault();

              deferred.resolve(jQueryimageUrl.val());
            });

            jQueryimageUrl.on('keyup paste', function () {
              var url = jQueryimageUrl.val();
              ui.toggleBtn(jQueryimageBtn, url);
            }).val('').trigger('focus');
            self.bindEnterKey(jQueryimageUrl, jQueryimageBtn);
          });

          ui.onDialogHidden(self.jQuerydialog, function () {
            jQueryimageInput.off('change');
            jQueryimageUrl.off('keyup paste keypress');
            jQueryimageBtn.off('click');

            if (deferred.state() === 'pending') {
              deferred.reject();
            }
          });

          ui.showDialog(self.jQuerydialog);
        });
      };

    }
  });
}));