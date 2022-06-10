/*
 * 경로 수정 및 태그 수정
 * 베스트 수익률 게시판용 종목 차트 삽입
 * */
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
  	  		body += '						<input type="hidden" id="stockCode" name="stockCode">';
  	  		body += '						<input type="hidden" name="regmnId" value="'+$('#regmnId').val()+'">';
  	  		body += '						<input type="hidden" name="id" value="'+$('#id').val()+'">';
  	  		body += '						<button type="button" class="search">검색</button>';
  	  		body += '					</span>';
  	  		body += '				</p>';
  	  		body += '				<div class="pcorec-scroll">		';
  	  		body += '				</div>';
  	  		body += '			</div>';
  	  		body += '		</form> ';
  	  		body += '		</div> ';
  	  		body += '		<button class="cla-close">닫기</button> ';
  	  		body += '	</div> ';
  	  		body += '	</div> ';        
        
      
      // add hello button
      context.memo('button.stockSearch', function () {
    	  return ui.button({
          contents: '<i class="glyphicon glyphicon-signal"/> 종목 차트 삽입',
          tooltip: ' 종목 차트 삽입',
          click: function () {
        	  removeJs("//image.moneta.co.kr/rpan/common/js/common.js?update=20201215", "js") 
        	  removeJs("//image.moneta.co.kr/rpan/common/js/jquery-ui.js", "js")
        	  removeJs("//image.moneta.co.kr/rpan/common/js/autocomplete-common.js?update=20170908", "js") 
        	  self.open();
          }
        }).render();
    	  
      });

      
      this.open = function(){
    	  context.invoke('editor.saveRange');
      	  var regmnId = $('#regmnId').val();
			 
           $('#popArea').html(body);
           
           $('#popArea').css('position', 'fixed');
           $('#popArea').css('display', 'table');
              
           $.getScript("//paxnet.moneta.co.kr/tbbs/summernote/0.8.6/autocomplete-chart.js", function(data, textStatus) {
          		chartSearch.start({id:"stock",returnId:"stockCode",returnFnc:"getStockImg()"});
          		$(".data-stock-btn").keyup(function(event) {
          		  if (event.keyCode == 13) {
          		  }
          		});
          		$(document).on('keyup', '.data-stock-btn', function(event) {
          			if (event.keyCode == 13) {
          			}
          		});
          	});
            if($('html').hasClass('mobile-size')){
            	$('html, body').scrollTop(0);
               	$(".wrap").hide();
             }
           
           $('#popArea').show();
           
   		 //닫기
   		 $('button.cla-close').on('click', function(){
   			$(".wrap").show();
   			$(".pop-layer").hide(); 
   		 });
           
   		 //취소
   		 $('button.bodrb').on('click', function(){
   			$(".wrap").show();
   			$(".pop-layer").hide(); 
   		 });
           
   		 //등록
   		 $('button.red').on('click', function(){
   			$(".wrap").show();
   			$(".pop-layer").hide(); 
   		 });	        	
      	
   		 //지우기
   		 $('button.delete').on('click', function(){
   			 $(this).siblings().val('');
   		 })
		 
   		 $('#stock').trigger('focus');
   		 
   		 //종목선택
/*   		 $('button.stock-code').on('click', function () {
   			 $('input[name=stockCode]').val($(this).attr('data-stock-code'));
   			 self.ajaxCandleChartImage($('#stockChartForm').serialize());

   			 $('#p_iss_cd').val($(this).attr('data-stock-code'));
   			 $(".pop-layer").hide(); 
//   			 self.destroy();
   			 
   		 });*/
           
//   		 $('#stock-list').liveFilter('#stock', 'button');
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
    	  $.getScript("//paxnet.moneta.co.kr/files/stock/codelist.js", function() {
    		  $.each(autocompleteCodelist,function(key,value){
//    			  $.each(value,function(k,v){
    				  html+='<button data-stock-code="'+value[1]+'" class="list-group-item stock-code">'+value[0]+'('+value[1]+')'+'</button>';
//    			  })
    			     
    		  })
    		  $('#stock-list').append(html);
    		});
    	  
      }

      
      this.ajaxCandleChartImage = function (data) {
			$.ajax({
				url: document.location.origin + '/pro/editor/candleChartAjax',
				method: "POST",
				async: true,
				data: data,
				dataType: 'json'
					
			}).done(function(c) {
				var html='';
				html+='<img src="'+c.chartImageURL+'" alt="차트이미지"/>'
				context.invoke('editor.restoreRange');
				context.invoke('editor.pasteHTML', html);
//				context.invoke('editor.focus');
				$(".wrap").show();
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

var getStockImg = function(stockCode){
	if(stockCode){
		$('#stockCode').val(stockCode);
		$('#p_iss_cd').val(stockCode);
	}else{
		$('#p_iss_cd').val($('#stockCode').val());
	}
	 $('#summernote').summernote('stockSearch.ajaxCandleChartImage', $('#stockChartForm').serialize());
	 $(".wrap").show();
	 $(".pop-layer").hide(); 
	 
	 includeJs("//image.moneta.co.kr/rpan/common/js/common.js?update=20201204");
	 includeJs("//image.moneta.co.kr/rpan/common/js/jquery-ui.js");
	 includeJs("//image.moneta.co.kr/rpan/common/js/autocomplete-common.js?update=20170908");
}
var includeJs = function (url) {
	 var jScript = document.createElement("script"); 
	 jScript.src = url;
	 document.body.appendChild(jScript); 
}
function removeJs(filename, filetype){
    var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist from
    var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
    var allsuspects=document.getElementsByTagName(targetelement)
    for (var i=allsuspects.length-1; i>=0; i--){ //search backwards within nodelist for matching elements to remove
    	if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1){
    		console.log('>' + allsuspects[i])
    		allsuspects[i].parentNode.removeChild(allsuspects[i]) //remove element by calling parentNode.removeChild()
    	}
    }
}
function replaceJs(oldfilename, newfilename, filetype){
    var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist using
    var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
    var allsuspects=document.getElementsByTagName(targetelement)
    for (var i=allsuspects.length-1; i>=0; i--){ //search backwards within nodelist for matching elements to remove
        if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(oldfilename)!=-1){
            var newelement=createJs(newfilename, filetype)
            allsuspects[i].parentNode.replaceChild(newelement, allsuspects[i])
        }
    }
}
function createJs(filename, filetype){
    if (filetype=="js"){ //if filename is a external JavaScript file
        var fileref=document.createElement('script')
        fileref.setAttribute("type","text/javascript")
        fileref.setAttribute("src", filename)
    }
    else if (filetype=="css"){ //if filename is an external CSS file
        var fileref=document.createElement("link")
        fileref.setAttribute("rel", "stylesheet")
        fileref.setAttribute("type", "text/css")
        fileref.setAttribute("href", filename)
    }
    return fileref
}