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
    'openGraph': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      
      // add hello button
      context.memo('button.openGraph', function () {
    	  return ui.button({
//          contents: '<i class="note-icon-link"/> 팍스넷링크삽입',
    		  contents: ui.icon(options.icons.link),
          tooltip: '링크',
          click: function () {

              context.invoke('editor.hasFocus');
        	  context.invoke('editor.saveRange');
        	  
        	  var body = '' +
        	    '	<div class="pop-inner">'+
	        	'	<div class="popup-wrap wid-m">' +
	        	'		<div class="pop-tit"><span>URL 삽입</span></div>' +
	        	'		<form id="imageFileUpload" name="imageFileUpload" method="post" enctype="multipart/form-data" onsubmit="return false;">' +
	        	'		<div class="pop-cont">' +
	        	'				<div class="poll-pop">' +
	        	'					<p class="tit-h2"><label for="textToDisplay">노출문구</label></p>' +
//	        	'					<div class="subj-w">' +
	        	'						<span class="input-style">' +
	        	'							<input type="text" id="textToDisplay" name="textToDisplay"/>' +
	        	'							<button type="button" class="delete">삭제</button>' +
	        	'						</span>' +
//	        	'					</div> ' +
	        	'					<p class="tit-h2"><label for="linkUrl">URL 삽입</label></p>' +
//	        	'					<div class="subj-w">' +
	        	'						<span class="input-style">' +
	        	'							<input type="text" id="linkUrl" name="linkUrl" placeholder="유효한 URL을 입력하세요"/>' +
	        	'							<button type="button" class="delete">삭제</button>' +
	        	'						</span>' +
//	        	'					</div> ' +
//	        	'					<p class="guide-text"><input type="checkbox" id="sn-checkbox-open-in-new-window" checked />새창에서 열기</p>' +
	        	'					<br><br><input type="checkbox" id="newWinCheck" checked="checked"><label for="newWinCheck">새창에서 열기</label>' +
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
             $('#linkUrl').trigger('focus');
             
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
     			 var text = $('#textToDisplay').val();
     			 var url = $('#linkUrl').val();
     			 var check = $('#newWinCheck');
     			 
     			 if(!text){
     				 alert('노출문구를 입력해주세요.')
     				 return false;
     			 }
     			 if(!url){
     				 alert('URL을 입력해주세요.')
     				 return false;
     			 }
     			 
     			 self.setData(text, url, check);
     		 });	        	
        	
     		 //지우기
     		 $('button.delete').on('click', function(){
     			 $(this).siblings().val('');
     		 })
     		 
     		var isEqualTextUrl = true;
     		
     		$('#linkUrl').on('keyup keypress', function(){
     			if(isEqualTextUrl){
     				$('#textToDisplay').val($('#linkUrl').val());
     			}
     			if($('#textToDisplay').val() ==$('#linkUrl').val()){
     				isEqualTextUrl = true;
     			}
     		})
     		
			$('#textToDisplay').on('keyup keypress', function () {
				if($('#textToDisplay').val() !=$('#linkUrl').val()){
					isEqualTextUrl = false;
				}else{
					isEqualTextUrl = true;
				}
 			})
          }
        }).render();
      });

/*      
      // This events will be attached when editor is initialized.
      this.events = {
        // This will be called after modules are initialized.
        'summernote.init': function (we, e) {
          console.log('summernote initialized', we, e);
        },
        // This will be called when user releases a key on editable.
        'summernote.keyup': function (we, e) {
          console.log('summernote keyup', we, e);
        }
      };
*/
      // This method will be called when editor is initialized by $('..').summernote();
      // You can create elements for plugin
      this.initialize = function () {
          var jQuerycontainer = options.dialogsInBody ? jQuery(document.body) : jQueryeditor;

          var body = '<div class="form-group">' +
                       '<label>' + 'URL 삽입' + '</label>' +
                       '<input class="note-opengraph-url form-control" type="text" value="http://" />' +
                     '</div>';
          var footer = '<button href="#" class="btn btn-primary note-opengraph-btn " >' + lang.link.insert + '</button>';

          this.jQuerydialog = ui.dialog({
            className: 'link-dialog',
            title: '오픈 그래프 삽입',
            fade: options.dialogsFade,
            body: body,
            footer: footer
          }).render().appendTo(jQuerycontainer);
      };

      // This methods will be called when editor is destroyed by $('..').summernote('destroy');
      // You should remove elements on `initialize`.
      this.destroy = function () {
    	  ui.hideDialog(this.jQuerydialog);
          this.jQuerydialog.remove();
      };
      this.bindEnterKey = function (jQueryinput, jQuerybtn) {
          jQueryinput.on('keypress', function (event) {
            if (event.keyCode === 13) { //13은 키코드 엔터값임
              jQuerybtn.trigger('click');
            }
          });
      };
      
      this.setData = function (text, url, check) {
    	  context.invoke('editor.restoreRange');
    	  context.invoke('editor.focus');
    	  
    	  // if url doesn't match an URL schema, set http:// as default
    	  url = /^[A-Za-z][A-Za-z0-9+-.]*\:[\/\/]?/.test(url) ? url : 'http://' + url;
    	  
    	  var html='';
    	  if($(check).prop('checked')){
    		  html = '<a href="'+url+'" target="_blank">'+text+'</a>'
    	  }else{
    		  html = '<a href="'+url+'">'+text+'</a>'
    	  }
    	  
    	  context.invoke('editor.pasteHTML', html);
          $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
    	  $(".pop-layer").hide(); 
      }
      
      this.ajaxUrlConnet = function (data) {
    	  if(!data.trim()){
    		  alert('URL을 입력해 주세요.')
    	  }else{
  	    	var callCtx = $('#callCtx').val();
  	    	
    		  $.ajax({
    			  url: callCtx + '/editor/opengraphAjax',
    			  method: "POST",
    			  async: true,
    			  data: {'url': data},
    			  success: function(result){
    				  console.log(result);
    			  }
    		  }).done(function(c) {
   					context.invoke('editor.restoreRange');
   					context.invoke('editor.focus');
    			  var isException = false;
    			  $.each(c, function(key,value){
    				  console.log(key + ' : ' + decode(value));
    				  if(key == 'exception'){
    					  isException = true;
    					  alert('유효한 URL을 입력해 주세요.');
    					  false;
    				  }
    			  });
    			  
    			  if(!isException){
    				  var html='';
    				  if('video'.indexOf(decode(c['og:type'][0])) >= 0){
    					  html+='<a href="'+decode(c['og:url'][0])+'">';
    					  html+='<pre style="width: 300px;overflow: hidden;">';
    					  //html+='<pre style="width: 300px;overflow: hidden;" onclick="location.href=\''+c['og:url'][0]+'\'">';
    					  if( decode(c['og:video']) !== undefined || decode(c['og:video:secure_url']) !== undefined  ){
    						  var videoUrl = decode(c['og:video']);
    						  if(videoUrl === undefined)
    							  videoUrl = decode(c['og:video:secure_url'][0]);
    						  
    						  html+='<object data="'+videoUrl+'"></object>';
    					  }
    					  html+='<p><b>'+decode(c['og:title'][0])+'</b></p>';
    					  if( !(c['og:description'] === undefined)){
    						  html+='<p>'+decode(c['og:description'])+'</p>';
    					  }
    					  html+='<p><a href="'+decode(c['og:url'][0])+'">'+decode(c['og:url'][0])+'</a></p>';
    					  html+='</pre>';
    					  html+='</a>';
    					  context.invoke('editor.pasteHTML', html);
    					  
    		                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
    					  $(".pop-layer").hide(); 
    				  } else {
    					  html+='<a href="'+decode(c['og:url'][0])+'">';
    					  html+='<pre style="max-width: 300px;overflow: hidden;">';
    					  //html+='<pre style="width: 300px;overflow: hidden;" onclick="location.href=\''+c['og:url'][0]+'\'">';
    					  if( !(decode(c['og:image']) === undefined)){
    						  html+='<img src="'+decode(c['og:image'][0])+'" alt="'+decode(c['og:title'][0])+'" style="max-height: 100px;" />';
    					  }
    					  html+='<p><b>'+decode(c['og:title'][0])+'</b></p>';
    					  if( !(c['og:description'] === undefined)){
    						  html+='<p>'+decode(c['og:description'])+'</p>';
    					  }
    					  html+='<p><a href="'+decode(c['og:url'][0])+'">'+decode(c['og:url'][0])+'</a></p>';
    					  html+='</pre>';
    					  html+='</a>';
    					  context.invoke('editor.pasteHTML', html);
    					  
    		                 $('body').removeClass('open-modal');//모바일에서 원복하기 위해서
    					  $(".pop-layer").hide(); 
    				  }
    			  }

    		  }).fail(function() {
    			  alert('error = ' + data);
    		  });
    	  }
      }

      this.show = function () {
          context.invoke('editor.saveRange');
          this.showOpenGraphDialog().then(function (data) {
            // [workaround] hide dialog before restore range for IE range focus
            ui.hideDialog(self.jQuerydialog);
            context.invoke('editor.restoreRange');
            //console.log(data);
            	
              //context.invoke('editor.insertImagesOrCallback', data);
            	self.ajaxUrlConnet(data);
            	
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
      this.showOpenGraphDialog = function () {
        return jQuery.Deferred(function (deferred) {
          var jQueryOpenGraphInput = self.jQuerydialog.find('.note-opengraph-url'),
              jQueryOpenGraphBtn = self.jQuerydialog.find('.note-opengraph-btn');

          ui.onDialogShown(self.jQuerydialog, function () {
            context.triggerEvent('dialog.shown');

            jQueryOpenGraphBtn.click(function (event) {
              event.preventDefault();

              deferred.resolve(jQueryOpenGraphInput.val());
            });
            
            
            //ui.toggleBtn(jQueryOpenGraphBtn, jQueryOpenGraphInput.val());
            jQueryOpenGraphInput.val('').trigger('focus');
            /*
            jQueryOpenGraphInput.on('keyup paste', function () {
              var url = jQueryOpenGraphInput.val();
              //ui.toggleBtn(jQueryOpenGraphBtn, url);
            }).val('').trigger('focus');
            */
            self.bindEnterKey(jQueryOpenGraphInput, jQueryOpenGraphBtn);
          });

          ui.onDialogHidden(self.jQuerydialog, function () {
            //jQueryOpenGraphInput.off('keyup paste keypress');
            jQueryOpenGraphBtn.off('click');

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
function decode(data){
	var dec =  decodeURIComponent((data + '').replace(/\+/g, '%20'));
	var length = dec.length;
	return dec.substring(1, length-1);
}