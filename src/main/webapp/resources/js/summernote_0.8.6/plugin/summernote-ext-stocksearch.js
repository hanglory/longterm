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
    'stockSearch': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      
      // add hello button
      context.memo('button.stockSearch', function () {
    	  return ui.button({
          contents: '<i class="glyphicon glyphicon-signal"/> 종목 차트 삽입',
          tooltip: ' 종목 차트 삽입',
          click: function () {
        	  self.open();
        	  
        	  /*
        	  context.invoke('editor.saveRange');
          	  var regmnId = $('#regmnId').val();
          	  var body = '';
          	  	body += '	<div class="pop-inner">';
    	      	body += '	<div class="popup-wrap">';
    	      	body += '		<div class="pop-tit"><span>종목검색</span></div>';
    	      	body += '		<form id="stockChartForm" name="stockChartForm" onsubmit="return false;">';
    	      	body += '		<div class="pop-cont">';
    	      	body += '			<div class="pcorec-pop">';
    	      	body += '				<p>';
    	      	body += '					<span class="input-style">';
    	      	body += '						<input type="text" id="stock" placeholder="종목명/종목코드" title="종목명/종목코드">';
    	      	body += '						<input type="hidden" name="stockCode">';
    	      	body += '						<input type="hidden" name="regmnId" value="'+$('#regmnId').val()+'">';
    	      	body += '						<input type="hidden" name="id" value="'+$('#id').val()+'">';
    	      	body += '						<button type="button" class="search">검색</button>';
    	      	body += '					</span>';
    	      	body += '				</p>';
    	      	body += '				<div class="pcorec-scroll">		';
    	      	body += '					<ul id="stock-list">';
    			  $.each(code,function(key,value){
    				  $.each(value,function(k,v){
    					  body += '<li><button type="button" data-stock-code="'+v[1]+'" class="stock-code"><span>'+v[0]+'('+v[1]+')'+'</span></button></li>';
    				  })
    			  })
    	      	body += '					</ul>';
    	      	body += '				</div>';
    	      	body += '			</div>';
    		    body += '		</form> ';
    		    body += '		</div> ';
    		    body += '		<button class="cla-close">닫기</button> ';
    		    body += '	</div> ';
    		    body += '	</div> ';
    			 
               $('#popArea').html(body);
               $('#popArea').show();
               
       		 //닫기
       		 $('button.cla-close').on('click', function(){
       			$(".pop-layer").hide(); 
       		 });
               
       		 //취소
       		 $('button.bodrb').on('click', function(){
       			$(".pop-layer").hide(); 
       		 });
               
       		 //등록
       		 $('button.red').on('click', function(){
      	        $(".pop-layer").hide(); 
       		 });	        	
          	
       		 //지우기
       		 $('button.delete').on('click', function(){
       			 $(this).siblings().val('');
       		 })
    		 
       		 $('#stock').trigger('focus');
       		 
       		 //종목선택
       		 $('button.stock-code').on('click', function () {
       			 $('input[name=stockCode]').val($(this).attr('data-stock-code'));
       			 self.ajaxCandleChartImage($('#stockChartForm').serialize());
       			 self.destroy();
       		 });
               
       		 $('#stock-list').liveFilter('#stock', 'button');
        	  
        	  */
          }
        }).render();
    	  
      });

      
      this.open = function(){
    	  context.invoke('editor.saveRange');
      	  var regmnId = $('#regmnId').val();
      	  var body = '';
    	  	body += '	<div class="pop-inner">';
	      	body += '	<div class="popup-wrap">';
	      	body += '		<div class="pop-tit"><span>종목검색</span></div>';
	      	body += '		<form id="stockChartForm" name="stockChartForm" onsubmit="return false;">';
	      	body += '		<div class="pop-cont">';
	      	body += '			<div class="pcorec-pop">';
	      	body += '				<p>';
	      	body += '					<span class="input-style">';
	      	body += '						<input type="text" id="stock" placeholder="종목명/종목코드" title="종목명/종목코드">';
	      	body += '						<input type="hidden" name="stockCode">';
	      	body += '						<input type="hidden" name="regmnId" value="'+$('#regmnId').val()+'">';
	      	body += '						<input type="hidden" name="id" value="'+$('#id').val()+'">';
	      	body += '						<button type="button" class="search">검색</button>';
	      	body += '					</span>';
	      	body += '				</p>';
	      	body += '				<div class="pcorec-scroll">		';
	      	body += '					<ul id="stock-list">';
			  $.each(code,function(key,value){
				  $.each(value,function(k,v){
					  body += '<li><button type="button" data-stock-code="'+v[1]+'" class="stock-code"><span>'+v[0]+'('+v[1]+')'+'</span></button></li>';
				  })
			  })
	      	body += '					</ul>';
	      	body += '				</div>';
	      	body += '			</div>';
		    body += '		</form> ';
		    body += '		</div> ';
		    body += '		<button class="cla-close">닫기</button> ';
		    body += '	</div> ';
		    body += '	</div> ';
			 
           $('#popArea').html(body);
           $('#popArea').show();
           
   		 //닫기
   		 $('button.cla-close').on('click', function(){
   			$(".pop-layer").hide(); 
   		 });
           
   		 //취소
   		 $('button.bodrb').on('click', function(){
   			$(".pop-layer").hide(); 
   		 });
           
   		 //등록
   		 $('button.red').on('click', function(){
  	        $(".pop-layer").hide(); 
   		 });	        	
      	
   		 //지우기
   		 $('button.delete').on('click', function(){
   			 $(this).siblings().val('');
   		 })
		 
   		 $('#stock').trigger('focus');
   		 
   		 //종목선택
   		 $('button.stock-code').on('click', function () {
   			 $('input[name=stockCode]').val($(this).attr('data-stock-code'));
   			 self.ajaxCandleChartImage($('#stockChartForm').serialize());

   			 $('#p_iss_cd').val($(this).attr('data-stock-code'));
   			 $(".pop-layer").hide(); 
//   			 self.destroy();
   			 
   		 });
           
   		 $('#stock-list').liveFilter('#stock', 'button');
      }
      
      
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

/*      
      this.show = function () {
          context.invoke('editor.saveRange');
          this.showImageDialog().then(function () {
            context.invoke('editor.restoreRange');
          });
      };
*/      
      
      this.getStockList = function () {
    	  var html='';
    	  $.getScript("http://image.moneta.co.kr/paxnet30/codelist_encod.js", function() {
    		  $.each(code,function(key,value){
    			  $.each(value,function(k,v){
    				  html+='<button data-stock-code="'+v[1]+'" class="list-group-item stock-code">'+v[0]+'('+v[1]+')'+'</button>';
    			  })
    			     
    		  })
    		  $('#stock-list').append(html);
    		});
    	  
      }

      
      this.ajaxCandleChartImage = function (data) {
    	  console.log(data)
			$.ajax({
				url: 'fileproc/bbsWrt/candleChartImage',
				method: "POST",
				async: true,
				data: data,
				dataType: 'xml'
			}).done(function(c) {
//				console.log(c);
//				console.log(jQuery.type(c));
//				console.log($(c).find('charImageURL'));		//됨
				var charImageURL = $(c).find('charImageURL')[0].childNodes[0].data;
  				var html='';
  				html+='<img class="lazy" data-original="'+charImageURL+'" src="'+charImageURL+'" alt="차트이미지"/>'
 				context.invoke('editor.restoreRange');
 				context.invoke('editor.focus');
  				context.invoke('editor.pasteHTML', html);
  				$(".pop-layer").hide(); 
	  		}).fail(function() {
	  			alert('error = ' + data);
	  		});
    	  
   }

      this.show = function () {
          context.invoke('editor.saveRange');
          this.showOpenGraphDialog().then(function (data) {
            // [workaround] hide dialog before restore range for IE range focus
            ui.hideDialog(self.jQuerydialog);
            
            context.invoke('editor.restoreRange');
            //console.log(data);
            //종목리스트 ajax 호출후 UI에 삽입
            
              //context.invoke('editor.insertImagesOrCallback', data);
            	//self.ajaxUrlConnet(data);
            	
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
        	
        	
          var jQueryStockSearchInput = self.jQuerydialog.find('.note-stockSearch-input')
          var jQueryStockBtn = self.jQuerydialog.find('.stock-code')

          ui.onDialogShown(self.jQuerydialog, function () {
            context.triggerEvent('dialog.shown');
            
            jQueryStockSearchInput.trigger('focus');
            
            jQueryStockBtn.on('click', function () {
            	self.jQuerydialog.find('input[name=stockCode]').val($(this).attr('data-stock-code'));
            	//console.log(self.jQuerydialog.find('#stockChartForm').serialize());
            	self.ajaxCandleChartImage(self.jQuerydialog.find('#stockChartForm').serialize());
            	self.destroy();
            });

           
            $('#stock-list').liveFilter('#note-stockSearch-input', 'button');
            
          });
            

            
          ui.onDialogHidden(self.jQuerydialog, function () {

        	//jQueryStockSearchInput.off('keyup paste keypress');
            jQueryStockBtn.off('click');

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
