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
	
	$.extend($.summernote.options.popover,{
        poll:[['poll',['pollDialogShow','removePoll']]]
    })

  // Extends plugins for adding hello.
  //  - plugin is external module for customizing.
  $.extend($.summernote.plugins, {
    /**
     * @param {Object} context - context object has status of editor.
     */
    'poll': function (context) {
        var self = this;
        var ui = jQuery.summernote.ui;
        var body ='';

        var jQueryeditor = context.layoutInfo.editor;
        var options = context.options;
        var lang = options.langInfo;
      // add hello button
      context.memo('button.poll', function () {
    	 return $(ui.button({
              contents: '<i class="glyphicon glyphicon-edit"/> 팍스넷poll',
              tooltip: 'poll',
              click: function () {
            	  
            	  self.checkResponse();
            	  if(self.checkResponse()){
            		  alert('투표 참여자가 존재하여 투표를 수정하실 수 없습니다.')
            	  }else{
            		  self.show();
            	  }
         		 
              }
            }).render()).attr('id','poll');
      });
      
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

      this.checkResponse = function(){
    	  var quesNum = $('#quesNum').val();
    	  var isResp = false;
    	  if(quesNum != 0){
    		  $('.respNum').each(function(idx){
    			  if($(this).val() > 0){
    				  isResp = true;
    			  }
    		  })
    	  }
    	  return isResp;
      }
      
      
      this.show = function () {
    	  
    	  var now = new Date();
          var suveTitle = $('#suveTitle').val();
          var beginDate = $('#beginDate').val();
          var endDate = $('#endDate').val();
          if(endDate != ''){
        	  endDate = endDate.substr(0, 10);
          }
          var quesNumLimit = $('#quesNumLimit').val();		//1,2,3,4.....
          var pollDateTime = $('#endDate').val();		//갯수
          var itmNum = $('#itmNum').val();
          var suveCntnLength = $(".suveCntn").length;
          var body = '';
          var html = '';
          
          var quesNum = $('#quesNum').val();		//갯수
          if(quesNum == 0){
        	  suveTitle = '';
        	  beginDate = DateFormat.format.date(now, 'yyyy-MM-dd HH:m:ss');
        	  endDate = '';
        	  itmNum = 0;
        	  quesNumLimit = null;
          }
          
          body += '	<!--  임시저장 글 목록 팝업 -->';
          body += '	<div class="pop-inner">';
          body += '	<div class="popup-wrap wid-m">';
          body += '	<div class="pop-tit"><span>투표</span></div>';
          
          body += '<form id="note-poll" method="POST" onsubmit="return false;" >';
          body += '	<div class="pop-cont">';
          body += '	<div class="cont-scroll">';
          body += '		<div class="poll-pop">';
          body += '			<p class="tit-h2"><label for="subj">투표제목</label></p>';
          body += '			<span class="input-style">';
          body += '				<input type="text" id="pollTitle" name="pollTitle" placeholder="투표제목을 입력해주시기 바랍니다." value="' + suveTitle + '" maxlength="30" onkeyup="checkStrLength(event, \'pollTitle\', 30)"> ';
          body += '				<button type="button" class="delete">삭제</button>';
          body += '			</span>';
          body += '			<p class="tit-h2"><label for="subj2">투표항목</label></p>';
          body += '			<div class="subj-w">  ';
          body += '				<ul>';
          
          if(quesNum == 0){
        	  body += '					<li>';
        	  body += '						<span class="input-style">';
        	  body += '							<input type="text"  title="투표항목1"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다.">';
        	  body += '							<input type="hidden" name="pollItmOdnb" value="0">';
        	  body += '							<button type="button" class="delete">삭제</button>';
        	  body += '						</span>';
        	  body += '					</li>';
        	  body += '					<li>';
        	  body += '						<span class="input-style">';
        	  body += '							<input type="text"  title="투표항목2"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다.">';
        	  body += '							<input type="hidden" name="pollItmOdnb" value="0">';
        	  body += '							<button type="button" class="delete">삭제</button>';
        	  body += '						</span>';
        	  body += '					</li>';
        	  body += '					<li>';
        	  body += '						<p>';
        	  body += '							<span class="input-style">';
        	  body += '								<input type="text"  title="투표항목3"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다.">';
        	  body += '							<input type="hidden" name="pollItmOdnb" value="0">';
        	  body += '								<button type="button" class="delete">삭제</button>';
        	  body += '							</span>';
        	  body += '						</p>';
        	  body += '						<button type="button" class="list-del" onclick="delPollItm(this)">항목삭제</button>';
        	  body += '					</li>';
          }else{
        	  
    		  $(".suveCntn").each(function(idx){
    			  var value = $(this).val();
    			  if(idx == 0 || idx == 1){
                	  body += '					<li>';
                	  body += '						<span class="input-style">';
                	  body += '							<input type="text"  title="투표항목"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다." value="'+value+'">';
                	  body += '							<input type="hidden" name="pollItmOdnb" value="'+$('#itmOdnb'+(idx+1)+'').val()+'">';
                	  body += '							<button type="button" class="delete">삭제</button>';
                	  body += '						</span>';
                	  body += '					</li>';           				  
    			  }else{
    				  body += '					<li>';
    				  body += '						<p>';
    				  body += '							<span class="input-style">';
    				  body += '								<input type="text"  title="투표항목"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다." value="'+value+'">';
    				  body += '								<input type="hidden" name="pollItmOdnb" value="'+$('#itmOdnb'+(idx+1)+'').val()+'">';
    				  body += '								<button type="button" class="delete">삭제</button>';
    				  body += '							</span>';
    				  body += '						</p>';
    				  body += '						<button type="button" class="list-del" onclick="delPollItm(this)">항목삭제</button>';
    				  body += '					</li>';               	  
    				  
    			  }
    		  });		  
          }
          
          body += '				</ul>';
          body += '			</div>';
          body += '			<div class="bt-add"><button type="button"  id="btnPollInst">항목추가</button></div>		';
 
          body += '			<div class="choice-w">		';
          body += '				<p>	';
          body += '					<label for="pollItemType">복수선택</label>';
          body += '					<span class="select-style">';
          body += '						<select id="pollItemType">';
          
          //갯수에 따라서 재 정의해야한다. 
          
          if(!quesNumLimit){	//undefined
        	  body += '							<option value="1" selected="selected">1개 선택 가능</option>';
        	  body += '							<option value="2" >2개 선택 가능</option>';
        	  body += '							<option value="3" >3개 선택 가능</option>';
          }else{
        	  for(var i=0; i<itmNum; i++){
        		  if(i==0){
        			  if(i+1==quesNumLimit){
        				  body += '							<option value="1" selected="selected">1개 선택 가능</option>';
        			  }else{
        				  body += '							<option value="1">1개 선택 가능</option>';
        			  }
        		  }else{
        			  if(i+1==quesNumLimit){
        				  body += '							<option value="'+(i+1)+'" selected="selected">'+(i+1)+'개 선택 가능</option>';
        			  }else{
        				  body += '							<option value="'+(i+1)+'" >'+(i+1)+'개 선택 가능</option>';
        			  }
        		  }
        	  }
          }
          body += '						</select>';
          body += '					</span>';
          body += '				</p>	';
          body += '				<p>	';
          body += '					<label for="pollDateTime">기간(종료일)</label>	';
//          body += '					<span class="input-style-cal pollBeginTime" data-date-format="yyyy-mm-dd">';
//          body += '					<span class="input-style-cal left input-append date startdate pollBeginTime" data-date="" data-date-format="yyyy-mm-dd">';
//          body += '						<input type="hidden" id="pollBeginTime" name="pollBeginTime" value="'+beginDate+'">';
//          body += '						<input type="text" id="pollDateTime"  name="pollDateTime" value="'+endDate+'">';
//          body += '						<button type="button" class="calendar">검색</button>';
//          body += '					</span>';
          
          body += '	<span class="input-style-cal input-append date pollDateTime" data-date="" data-date-format="yyyy-mm-dd">';
          body += '	<input type="text" placeholder="날짜선택" readonly name="pollDateTime" id="pollDateTime" value="'+endDate+'">';
        		  body += '		<button type="button" class="calendar add-on">검색</button>';
        			  body += '	</span>';

          body += '				</p>';
          body += '			</div><br><br><br><br><br>';
          body += '		</div>';
          body += '	</div>	';
          body += '	<div class="pop-btn">	';
          body += '		<input type="hidden" id="pollBeginTime" name="pollBeginTime" value="'+beginDate+'">';
          body += '		<button type="button" class="btn-s bodrb">취소</button>  	';
          body += '		<button type="submit" class="btn-s red" id="btnPollSubmit">등록</button>	';
          body += '	</div>	';
          body += '	</form>	';
          body += '</div>	';
          body += '		<button class="cla-close">닫기</button>';
          body += '		</div>	';
          body += '  </div> ';
          
          $('#popArea').html(body);
          $('select').selectpicker('refresh');	
          $('#popArea').show();
          
          var firstDate, lastDate, dayAfter6;
          
         dayAfter6 = getDateFromToday(6);
        
 /**       
		//검은 막을 눌렀을 때
		$('#popArea').on('click', function (e) {  
			$(this).hide();  
		});
   			
		
		$(".popup-wrap").on("click",function(event){
		    //상위로 이벤트가 전파되지 않도록 중단한다.
		    $('select').selectpicker('refresh');	
		});
**/
         
		$(".pollDateTime").datepicker();
	    $(".pollDateTime").on('changeDate', function(ev){
	    	$("#newsDate3").prop("checked",true);
        		if($('#pollBeginTime').val() > $('#pollDateTime').val()){
        			alert('종료일은 현재일자 전으로 설정할 수 없습니다. 확인부탁드립니다.')
        			lastDate = new Date(dayAfter6.substring(0, 4), dayAfter6.substring(4, 6)-1, dayAfter6.substring(6, 8));
        			$('#pollDateTime').val($.datepicker.formatDate('yy-mm-dd', lastDate));
        			$(this).datepicker('setDate', lastDate);
        			$(this).datepicker('hide', lastDate);
        		}else{
        			$(this).datepicker('hide');
        		}
	    });

        	  
        	  
//        $( "#pollDateTime" ).datepicker({
//        	dateFormat: "yy-mm-dd",
//        	onClose: function(selectedDate){
//        		var eleId = $(this).attr('id');
//        	}
//        }).next('button').on('click', function () {
//        	$( "#pollDateTime" ).datepicker('show');
//        });

          
		 //값초기화
 		 $('button.delete').on('click', function(){
 			 console.log($(this).siblings('input').val());
 			$(this).siblings('input').val('');
 		 });
 		 
 		 //닫기
 		 $('button.cla-close').on('click', function(){
 			$(".pop-layer").hide(); 
 		 });
 		 
 		 //추가하기
 		 $('#btnPollInst').on('click', function(){
             var listHtml = '';
             listHtml += '<li>';
             listHtml += '	<p>';
             listHtml += '		<span class="input-style">';
             listHtml += '			<input type="text"  title="투표항목"  name="pollItemCntn" placeholder="투표항목을 입력해주시기 바랍니다.">';
             listHtml += '							<input type="hidden" name="pollItmOdnb" value="0">';
             listHtml += '			<button type="button" class="delete">삭제</button>';
             listHtml += '		</span>';
             listHtml += '	</p>';
             listHtml += '	<button type="button" class="list-del" onclick="delPollItm(this)">항목삭제</button>';
             listHtml += '</li>'; 
             
             $('div .subj-w > ul').append(listHtml);
             
             typeReSize();
 		 });
 		 
 		 //취소
 		 $('button.bodrb').on('click', function(){
 			$(".pop-layer").hide(); 
 		 });
 		 
 		 //저장
 		 $('#btnPollSubmit').on('click', function(){
 			 
 			 if(checkPollTitleIsNull() && checkPollItmIsNull() && checkPollEndTimeIsNull() &&checkPollEndTimeReg()){		//Null체크
 				 $('#suveTitle').val($('#pollTitle').val());
     			 $('#itmNum').val($('input[name=pollItemCntn]').size());
     			 $('#suveYn').val('Y');
     			 $('#quesNum').val(1);
     			 
     			 $('#pollDateTime').val()
     			 $('#beginDate').val(beginDate);
     			 $('#endDate').val($('#pollDateTime').val()+' 23:59:59');

     			 var hidHtml = '';
     			 hidHtml += '<input type="hidden" id="quesNumLimit" name="quesNumLimit" value="'+$('#pollItemType').val()+'">';
     			 $('input[name=pollItemCntn]').each(function(idx){
     				 hidHtml += '<input type="hidden" id="suveCntn'+(idx+1)+'" class="suveCntn" name="itmList['+idx+'].suveCntn" value="'+$(this).val()+'">';
     				 hidHtml += '<input type="hidden" id="itmOdnb'+(idx+1)+'" class="itmOdnb" name="itmList['+idx+'].itmOdnb" value="'+(idx+1)+'">';
     				 hidHtml += '<input type="hidden" id="respNum'+(idx+1)+'" class="respNum" name="itmList['+idx+'].respNum" value="0">';
     			 });
     			
     			 var html = ''
     				html += '<div class="board-view-poll">'
     				html += '	<p class="poll-subj">'
					html += '		<span>투표</span>'
					html += '		<button type="button" class="delete" id="btnPollDel" onclick="removePoll(this)">삭제</button>'
					html += '	</p>'
					html += '	<p class="poll-status long">'+$('#pollTitle').val()+'</p>'
					html += '	<p class="poll-limit">'
					var end = new Date($('#pollDateTime').val().substring(0, 4), $('#pollDateTime').val().substring(5, 7)-1, $('#pollDateTime').val().substring(8, 10), 23, 59, 59);
					html += '		<span>종료 <mark class="color-red">'+DateFormat.format.biPrettyDate(now, end)+'</mark> 일전</span>'
					html += 				DateFormat.format.date(now, 'yyyy.MM.dd')
					html += '			~			'
					html += 				DateFormat.format.date($('#endDate').val(), 'yyyy.MM.dd')
					html += '	</p>'
					
					
					html += '	<ul class="poll-radio">'
	     			 $('input[name=pollItemCntn]').each(function(idx){
	     				 html += '		<li><input type="checkbox" id="poll'+(idx+1)+'" class="poll" name="poll"><label for="poll'+(idx+1)+'">'+$(this).val()+'</label></li>'
	     			 });
					html += '	</ul>'
	
					html += '	<div class="poll-btn button2">'
					html += '		<button type="button" class="btn-m">결과보기</button>'
					html += '		<button type="button" class="btn-m bodr">투표하기</button>'
					html += '	</div>'
					html += '</div>'			 
     			 
     			 
     			 //데이터 저장
     			 $('#pollView').html(hidHtml);
     			 $('.board-poll-wrap').html(html);
     			 //본문에 제목노출
     			 $('.board-poll-wrap').show();
     			 //팝업닫기
     			 $(".pop-layer").hide(); 
     			 
     			 
     		    $('.poll').on('change', function () {
     		        var $checked = jQuery('.poll:checked');
     		        var $this = jQuery(this);
     		        var checkedLength = $checked.length;
     		        var quesNumLimit = $('#quesNumLimit').val();

     		        if(checkedLength > quesNumLimit){
     		            $this.attr('checked', false);
     		            alert('선택 가능수 ' + quesNumLimit + '개 입니다.');
     		        }

     		    });
 			 }
 		 });
    	  
    	  
        };
      /**
       * show image dialog
       *
       * @param {jQuery} jQuerydialog
       * @return {Promise}
       */
      this.showPollDialog = function () {
        return jQuery.Deferred(function (deferred) {
          var jQueryPollTitleInput = self.jQuerydialog.find('.note-poll-title'),
          		jQueryPollForm = self.jQuerydialog.find('#note-poll'),
          		jQueryPollType = self.jQuerydialog.find('#note-poll-type'),
          		jQueryPollItemType = self.jQuerydialog.find('.note-poll-item-type'),
          		jQueryPollItems = self.jQuerydialog.find('#note-poll-items'),
          		jQueryPollItemInput = self.jQuerydialog.find('.note-poll-item'),
          		jQueryPollRemoveBtn = self.jQuerydialog.find('.note-poll-item-remove-btn'),
          		jQueryPollItemInsertBtn = self.jQuerydialog.find('#note-poll-item-insert-btn'),
          		jQueryPollInsertBtn = self.jQuerydialog.find('.note-poll-insert-btn');

          ui.onDialogShown(self.jQuerydialog, function () {
            context.triggerEvent('dialog.shown');
    

            	
          });

          ui.onDialogHidden(self.jQuerydialog, function () {
        	  
        	  jQueryPollForm.off("submit")
        	  jQueryPollType.off('change')
        	  jQueryPollItemInsertBtn.off('click');
        	  self.jQuerydialog.off('click','.note-poll-item-remove-btn');
        	  

            if (deferred.state() === 'pending') {
              deferred.reject();
            }
          });

          ui.showDialog(self.jQuerydialog);
        });
      };

    },
  
  
  'pollPopover' : function (context) {
	    var self = this;
	    var ui = jQuery.summernote.ui;

	    var options = context.options;
	    
	    var $editable = context.layoutInfo.editable;
	    
		this.events = {
		  'summernote.keyup summernote.mouseup summernote.change summernote.scroll': function () {
		    self.update();
		  },
		  'summernote.dialog.shown': function () {
		    self.hide();
		  }
		};
	    
		context.memo('button.pollDialogShow', function () {
		  return ui.button({
		    contents: ui.icon(options.icons.link),
		    tooltip: '폴 수정',
		    click:context.createInvokeHandler('poll.show')
		  }).render();
		});
		
		context.memo('button.removePoll', function () {
		  return ui.button({
		    contents: ui.icon(options.icons.unlink),
		    tooltip: '폴 삭제',
		    click: context.createInvokeHandler('editor.unlink')
		  }).render();
		});

	    

	    this.shouldInitialize = function () {
	      return options.popover.poll !==null;
	    };

	    this.initialize = function () {
	      this.jQuerypopover = ui.popover({
	        className: 'note-poll-popover'
	      }).render().appendTo('body');
	      var jQuerycontent = this.jQuerypopover.find('.popover-content');

	      context.invoke('buttons.build', jQuerycontent, options.popover.poll);
	    };

	    this.destroy = function () {
	      this.jQuerypopover.remove();
	    };

	    this.update = function () {
			// Prevent focusing on editable when invoke('code') is executed
			if (!context.invoke('editor.hasFocus')) {
			  this.hide();
			  return;
			}
	      var rng = context.invoke('editor.createRange');
	      var jQueryPoll = $(rng.sc).parents('.paxnet-poll');

	      if (rng.isCollapsed() && (jQueryPoll.size() === 1)) {
	    	  
	        //var anchor = dom.ancestor(rng.sc, dom.isAnchor);
	        this.jQuerypopover.find('.note-poll');

	        var pos = self.posFromPlaceholder(jQueryPoll);
	        this.jQuerypopover.css({
	          display: 'block',
	          left: pos.left,
	          top: pos.top
	        });
	      } else {
	        this.hide();
	      }
	    };

	    this.hide = function () {
	      this.jQuerypopover.hide();
	    };
	    
	    
	    this.posFromPlaceholder = function (placeholder) {
	        var jQueryplaceholder = jQuery(placeholder);
	        var pos = jQueryplaceholder.offset();
	        var height = jQueryplaceholder.outerHeight(true); // include margin

	        return {
	          left: pos.left,
	          top: pos.top + height
	        };
	    };

	    
	    
	  }
  
  });
}));
function checkPollEndTimeIsNull(){
	var pollDateTime = $('#pollDateTime').val().trim();	
	if(pollDateTime == null || pollDateTime == '' ){
		alert('투표시간을 입력해주세요.')
		return false;
	} else {
		return true;
	}	
}
function checkPollEndTimeReg(){
	var pollDateTime = $('#pollDateTime').val();
	var regEx = /\d{4}\-\d{2}\-\d{2}/;
	if(!regEx.test(pollDateTime)){
		alert('날짜형식이 올바르지 않습니다. YYYY-MM-DD형태로 입력해 주세요.')
		return false;
	}else{
		return true;
	}
}
function checkPollTitleIsNull(){
	var title = $('#pollTitle').val().trim();	
	if(title == null || title == '' ){
		alert('투표제목을 입력해주시기 바랍니다.')
		return false;
	} else {
		return true;
	}	
}
function checkPollItmIsNull(){
	var isPollItmNull = false;
	$('input[name=pollItemCntn]').each(function(idx){
		var itm = $(this).val().trim();
		if(itm == null || itm == '' ){
			isPollItmNull = true;
		}
	});
	if(isPollItmNull){
		alert('투표항목을 입력해주시기 바랍니다.')
		return false;
	}else{
		return true;
	}
}
function formatShrtDate(str){
	var yy = str.substring(2, 4);
	var mm = str.substring(5, 7);
	var dd = str.substring(8, 10);
	return yy+'.'+mm+'.'+dd;
}
function formatToDate(str){
	var yyyy = str.substring(0, 4);
	var mm = str.substring(5, 7);
	var dd = str.substring(8, 10);
	var hh = str.substring(11, 13);
	var mi = str.substring(14, 16);
	return yyyy+'/'+mm+'/'+dd+' '+hh+':'+mi+':00';
}
function formatToDTL(str){
	var yyyy = str.substring(0, 4);
	var mm = str.substring(5, 7);
	var dd = str.substring(8, 10);
	var hh = str.substring(11, 13);
	var mi = str.substring(14, 16);
	return yyyy+'-'+mm+'-'+dd+'T'+hh+':'+mi;
}
function checkStrLength(e, id, length){
	var idval = $('#'+id+'').val();
	if(getByteLength(idval) > (length*2)){
		$('#'+id+'').val( cutByteLength( idval, (length*2) ) );
	}
}
function charByteSize(ch){
	if( ch == null || ch.length == 0) {
		return 0;
	}
	var charCode = ch.charCodeAt(0);
	if(charCode <= 0x00007F){
		return 1;
	} else if (charCode <= 0x0007FF) {
		return 2;
	} else if (charCode <= 0x00FFFF) {
		return 2;
	} else {
		return 4;
	}
}
function getByteLength(str) {
	if(str == null || str.length ==0){
		return 0;
	}
	var size = 0;
	for(var i=0; i<str.length; i++){
		size += charByteSize(str.charAt(i));
	}
	return size;
}
function cutByteLength(str, len){
	if(str == null || str.length ==0){
		return 0;
	}
	var size = 0;
	var rIndex = str.length;
	
	for(var i=0; i<str.length; i++){
		size += charByteSize(str.charAt(i));
		if(size == len){
			rIndex = i+1;
			break;
		} else if(size >len){
			rIndex =i;
			break;
		}
	}
	return str.substr(0, rIndex);
}
function getToday(){
	var date = new Date();
	var yyyy = leadingZeros(date.getFullYear(), 4);
	var mm = leadingZeros(date.getMonth()+1, 2);
	var dd = leadingZeros(date.getDate(), 2);
	var hh = leadingZeros(date.getHours(), 2);
	var mi = leadingZeros(date.getMinutes(), 2);
	return yyyy+'/'+mm+'/'+dd+' '+hh+':'+mi+':00';
}
function getAfter7Days(){
	var date = new Date(new Date().valueOf() +(6*24*60*60*1000));
	var yyyy = leadingZeros(date.getFullYear(), 4);
	var mm = leadingZeros(date.getMonth()+1, 2);
	var dd = leadingZeros(date.getDate(), 2);
//	var hh = leadingZeros(date.getHours(), 2);
//	var mi = leadingZeros(date.getMinutes(), 2);
	return yyyy+'/'+mm+'/'+dd+' '+'23:59:59';
}
function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++){
			zero += '0';
		}
	}
	return zero + n;
}
function checkDateTime(dateTime){
	var inputDate = $(dateTime).val();
	var todayDate = formatToDTL(getToday());
	if(inputDate<todayDate){
		alert('마감시간은 현재시간 전으로 설정할 수 없습니다. 확인부탁드립니다.')
		$(dateTime).val(todayDate);
	}
}
var delItmCnt = 0;
function delPollItm(itm){
	 alert('항목이 삭제되었습니다.');
	 $(itm).parent().remove();
	 typeReSize();
	 var hidHtml = ''
	 hidHtml += '<input type="hidden" name="delItmList['+delItmCnt+'].itmOdnb" value="'+$(itm).siblings('p').find('input[name=pollItmOdnb]').val()+'">';
	 hidHtml += '<input type="hidden" name="delItmList['+delItmCnt+'].suveCntn" value="'+$(itm).siblings('p').find('input[name=pollItemCntn]').val()+'">';
	 $('#pollInfo').append(hidHtml);
	 delItmCnt++;
}
function typeReSize(){
	var size = $('input[name=pollItemCntn]').size();
	var listHtml ='';
	for(var i=0; i<size; i++){
		if(i==0){
			listHtml += '							<option value="1" selected="selected">1개 선택 가능</option>';
		}else{
			listHtml += '							<option value="'+(i+1)+'" >'+(i+1)+'개 선택 가능</option>';
		}
	}
	$('#pollItemType').html(listHtml);
	$('select').selectpicker('refresh');	
}
function getDateFromToday(i){
    //i=0: today, -1:yesterday, 1: tomorrow .. .etc..

    today = new Date();
    ty = today.getFullYear();
    tm = today.getMonth()+1;
    td = today.getDate();
    if(tm<10) tm = "0" + tm;
    if(td<10) td = "0" + td;
    
    targetDay = new Date(today.valueOf()+(24*60*60*1000)*i);
        ty = targetDay.getFullYear();
        tm = targetDay.getMonth()+1;
        td = targetDay.getDate();
    if(tm<10) tm = "0" + tm;
    if(td<10) td = "0" + td;       
    return ty + tm + td;
  }