<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>


 
<!-- 에디터 관련 -->
<link href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"> 
<script src="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<link rel="stylesheet" href="/js/summernote_0.8.6/summernote.css" />

	<script src="/js/summernote_0.8.6/summernote.js?update=20210309"></script>
	<script src="/js/summernote_0.8.6/lang/summernote-ko-KR.js"></script>
	<script src="/js/summernote_0.8.6/plugin/summernote-ext-ajaxImage.js?update=20210309"></script>
	<script src="/js/summernote_0.8.6/plugin/summernote-ext-opengraph.js"></script>
<!-- 에디터 관련 -->



 <div class="main_content">
    <h2>
      차량등록
    </h2>
	<div class="cont-area">    
 	<form id="usedCarVO" action="usedcarAction" id="summernoteForm">

<!-- 에디터 관련 -->
	<input type="hidden" id="callCtx" name="callCtx" value=""/>
	<input type="hidden" id="group1Id" value="usedcar"/>
	<input type="hidden" id="group2Id" value="form"/>
	<div id="popArea" class="pop-layer" style="display:none;"></div>
<!-- 에디터 관련 --> 

    <div class="register_wrap">
      <div class="left_area">
        <h3 class="sub_title">
          차량정보
        </h3>
        <ul class="info_list">
          <li class="info_item">
            <p class="info_title">차량번호</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="car_no" id="car_no">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">제조사</p>
            <div class="input_wrap">
              <select class="box_style" name="maker" id="maker">
                <option value="현대">현대</option>
                <option value="기아">기아</option>
                <option value="르노삼성">르노삼성</option>
                <option value="쉐보레">쉐보레</option>
                <option value="쌍용">쌍용</option>
                <option value="벤츠">벤츠</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량명</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="name" id="name">
              
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량연식</p>
            <div class="input_wrap select_wrap">
              <select class="box_style" name="vehicle_year" id="vehicle_year">
<c:forEach var="year" begin="2010" end="2050">
	<option value="${year}">${year}년</option>
</c:forEach>
              </select>
              <select class="box_style" name="vehicle_mon" id="vehicle_mon">
<c:forEach var="month" begin="01" end="12" step="1">
	<option value="${month}">${month}월식</option>
</c:forEach>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">계약기간 <br>(표준)</p>
            <div class="input_wrap sub_wrap">
            	<select class="box_style" name="period" id="period">
            		<option value="24">24개월</option>
            		<option value="36">36개월</option>
            		<option value="48">48개월</option>
            		<option value="0">기타</option>
            	</select>
              <div class="sub_inputwrap">
                <span>
                  기타
                </span>
                <input style="display:none" class="box_style" type="text" id="in_period" name="period">
              </div>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">보증금</p>
            <div class="input_wrap">
              <input class="box_style" type="number" name="deposit"  id="deposit">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">무심사 <br>(렌트료)</p>
            <div class="input_wrap price_wrap">
              <div class="price_item">
                <input class="box_style" type="number" name="rentfee" id="rentfee">
                <span class="suffix">
                  원
                </span>
              </div>
              <div class="price_item sub_price_item">
                <span class="prefix">하이렌트</span>
                <input class="box_style" type="number" name="rentfee_24" id="rentfee_24" placeholder="하이렌트">
                <span class="suffix">
                  원
                </span>
              </div>
              <div class="price_item sub_price_item">
                <span class="prefix">마이다스</span>
                <input class="box_style" type="number" name="rentfee_1" id="rentfee_1" placeholder="마이다스">
                <span class="suffix">
                  원
                </span>
              </div>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">차량가격</p>
            <div class="input_wrap ">
              <input class="box_style" type="number" name="trim_price" id="trim_price">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">만기인수가</p>
            <div class="input_wrap ">
              <input class="box_style" type="number" name="acquisition" id="acquisition">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">출력순서</p>
            <div class="input_wrap">
              <input type="number" placeholder="1부터" name="rank" id="rank">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">판매여부</p>
            <div class="input_wrap">
              <select class="box_style" name="status" id="status">
                <option value="판매중">판매중</option>
                <option value="판매종료">판매종료</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량구분</p>
            <div class="input_wrap">
              <select class="box_style" name="car_type" id="car_type">
                <option value="신차">신차</option>
                <option value="중고차">중고차</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">주행거리</p>
            <div class="input_wrap">
              <input class="text_box" type="number" placeholder="Km(숫자)" name="distance" id="distance">
              <span class="suffix">
                km
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">연료</p>
            <div class="input_wrap">
              <select class="box_style" name="fuel" id="fuel">
                <option value="LPG">LPG</option>
                <option value="휘발유">휘발유</option>
                <option value="경유">경유</option>
                <option value="전기">전기</option>
                <option value="하이브리드">하이브리드</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량 대표 <br>이미지</p>
            <div class="input_wrap file_wrap">
             	<div class="file-list">
             	
             	</div>
             	<p class="add-file">
            	<button type="button" class="file-ch _searchFileButton">파일선택 +</button>
            	</p>
            </div>
          </li>
        </ul>
      </div>
      <div class="right_area">
        <h3 class="sub_title">
          옵션
        </h3>
        <ul class="option_list">
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="네비게이션">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>네비게이션</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="전동시트" >
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>전동시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="블랙박스">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>블랙박스</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="전방감지센서">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>전방감지센서</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="후방감지센서">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>후방감지센서</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="후방카메라">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>후방카메라</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="크루즈컨트롤">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>크루즈컨트롤</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="스마트키">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>스마트키</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="하이패스">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>하이패스</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="열선시트">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>열선시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="통풍시트">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>통풍시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="열선핸들">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>열선핸들</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="options" id="options" value="썬루프">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>썬루프</span>
            </label>
          </li>
        </ul>

        <h3 class="sub_title">
          아이콘
        </h3>
        <ul class="option_list icon_list">
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox" name="icon" id="icon" value="엔진오일2회">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 2회</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox" name="icon" id="icon" value="엔진오일4회">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 4회</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox" name="icon" id="icon" value="즉시출고">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>즉시출고</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox" name="icon" id="icon" value="신차급">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>신차급</span>
            </label>
          </li>
        </ul>

        <div class="text_section">
          <h3 class="sub_title">
            기타사항
          </h3>
          <div class="textarea_wrap">
            <textarea name="etc_memo"  id="etc_memo"></textarea>
          </div>
        </div>

        <div class="text_section">
          <h3 class="sub_title">
            사고이력
          </h3>
          <div class="textarea_wrap">
            <textarea name="accident" id="accident"></textarea>
          </div>
        </div>
      </div>
    </div>
    <div class="bottom_area" >
		<div style="height:1800px; border:1px solid #ccc" id="summernote" class="summernote"></div>
		<textarea name="detailDesc" id="detailDesc" style="display: none;" rows="10" cols="10"></textarea>
      <div class="button_wrap">
        <!--  button>미리보기</button -->
        <button type="button" onClick="save()">등록</button>
      </div>
    </div>
   </form>
  </div>
</div>


	<script type="text/javascript">
	
	$(document).ready(function(){
/*		
		if($(".select-ch").text().trim() == "") {
			$(".select-ch").parent().parent().remove();
		}
		
		if($("#prefix_notice").text().trim() == "") {
			$("#prefix_notice").text("공지");
		}
		
		if($(".check-area").html().trim() == "") {
			$(".check-area").parent().parent().remove();
		}
*/		
		//목록
		$('.cont-area ._cancelButton').click(function() {
			if(confirm("글쓰기를 취소하시겠습니까?")) {
				history.go(-1);
			}
		});

		$('.cont-area ._searchFileButton').click(function(e) {
			e.preventDefault();
			
			var htmlStr = '';
			htmlStr += '			<span class="file-style">';
			htmlStr += '				<span class="attechFileName"></span>';
			htmlStr += '				<button type="button" class="delete _fileDelete">삭제</button>';
			htmlStr += '				<input type="file" class="file_add" name="attechFiles" style="display:none;"/>';
			htmlStr += '			</span>';

			$(".file-list").append(htmlStr);
			$(".file-style").last().hide();
			$(".file-style").last().find("input:file").click();
		});

		$(document).on('change', '.file_add', function(){
			if ($(this).val() != "") {
				$(this).parent().find("span.attechFileName").text($(this).val());
				$(this).parent().show();
			}
			
			var file;
			
			$(".file_add").each(function(i,e) {
				file = $(this).get(0).files[0];
				
				if(file.size > (5 * 1024 * 1024)) {
					alert("첨부 가능한 파일크기는 5MB까지 가능합니다.");
					$(this).parent().remove();
					return;
				}
			});
		});
	
		$("#period").on('change', function(){
			if ($(this).val() == "0") {
//				$("#in_period").style.display = "block";
				document.getElementById("in_period").style.display = "block";
			}else{
//				$("#in_period").style.display = "none";
				document.getElementById("in_period").style.display = "none";
				$("#in_period").val("0");
			}
		});		
		
		
		$(document).on('click', '._fileDelete', function(){
			$(this).parent().remove();
		});

		$('.cont-area ._saveButton').click(function() {
			save();
		});

		$('#bdTitle').focus();

//		if($('#detailDesc').text() != '') {
			$('#summernote').summernote('code', $('#detailDesc').text());
//		}	
			var fontList = ['notoSansKR', 'Arial', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'];
			$('#summernote').summernote({ 
				lang: 'ko-KR' // default: 'en-US' 
				,height: 3000 //set editable area's height 
				,codemirror: { // codemirror options
				    theme: 'monokai' 
				} 
				,tabsize: 2 
				,toolbar: [ 
					   ['fontname', ['fontname']] 
					   ,['fontsize', ['fontsize']] 
					   ,['color', ['color']] 
					   ,['font', ['bold', 'underline', 'clear']] 
					   ,['para', ['ul', 'ol', 'paragraph']] 
					   ,['table', ['table']]
					   ,['insert', ['ajaxImage']]
					   ,['view', ['codeview']]
				] 
				, fontNames:fontList
				, fontNamesIgnoreCheck: fontList
				, dialogsInBody: true
			});


	});
	
	


	function save(){
/*		
		if($("#car_no").val() == '') {
			alert("차량번호을 입력하세요.");
			$("#usedCarVO #car_no").focus();
			return;
		}
*/		
		if($("#name").val() == '') {
			alert("차량이름을 입력하세요.");
			$("#usedCarVO #name").focus();
			return;
		}
		if($("#in_period").val() > 60){
			alert("계약기간은 60개월을 넘길 수 없습니다.");
			$("#in_period").focus();
			return;
		}
		if($("#rentfee").val() == '') {
			alert("무심사(렌토료)을 입력하세요.");
			$("#usedCarVO #deposit").focus();
			return;
		}		
		if($("#trim_price").val() == '') {
			alert("차량가격을 입력하세요.");
			$("#usedCarVO #trim_price").focus();
			return;
		}
		if($("#acquisition").val() == '') {
			alert("만기인수가격을 입력하세요.");
			$("#usedCarVO #acquisition").focus();
			return;
		}
		if($("#etc_memo").val().length > 300) {
			alert("기타는 300자까지만 입력이 가능 합니다.");
			$("#etc_memo").val($("#etc_memo").val().substring(0, 100));
			$("#etc_memo").focus();
			return;
		}

		if($("#accident").val().length > 300) {
			alert("사고이력은 300자까지만 입력이 가능 합니다.");
			$("#accident").val($("#accident").val().substring(0, 100));
			$("#accident").focus();
			return;
		}
		if ($('#usedCarVO #summernote').summernote('isEmpty')) {
			alert("내용을 입력하세요.");
			return;
		}
		
		if ($('#usedCarVO #summernote').summernote('isOverSize')) {
			return;
		}
		if($("#rank").val() == '') {
			$("#rank").val('100');
		}
		if($("#distance").val() == '') {
			$("#distance").val('0');
		}
		
/*
		if($("#usedCarVO #name").val().length > 100) {
			alert("제목은 100자까지 가능합니다.");
			$("#usedCarVO #bdTitle").val($("#usedCarVO #bdTitle").val().substring(0, 100));
			$("#usedCarVO #bdTitle").focus();
			return;
		}
*/

//        $($('.panel-body img')[0]).addClass('summernoteImage');

	
		var formData = new FormData();
		formData.append("car_no", $('#car_no').val());
		formData.append("maker", $('#maker').val());
		formData.append("trim_name", $('#name').val());
		var vehicle
		if($('#vehicle_mon').val().length == 1)
			vehicle = $('#vehicle_year').val().concat('0',$('#vehicle_mon').val());
		else 
			vehicle = $('#vehicle_year').val().concat($('#vehicle_mon').val());
		formData.append("vehicle_year", vehicle);
		if($('#period').val() > 0)
			formData.append("period", $('#period').val());
		else
			formData.append("period", $('#in_period').val());
		formData.append("deposit", $('#deposit').val());
		formData.append("rentfee", $('#usedCarVO #rentfee').val());
		formData.append("rentfee_1", $('#usedCarVO #rentfee_1').val());
		formData.append("rentfee_24", $('#usedCarVO #rentfee_24').val());
		formData.append("trim_price", $('#usedCarVO #trim_price').val());
		formData.append("acquisition", $('#usedCarVO #acquisition').val());
		formData.append("ranking", $('#usedCarVO #rank').val());
		formData.append("sell_state", $('#usedCarVO #status').val());
		formData.append("car_type", $('#usedCarVO #car_type').val());
		formData.append("distance", $('#usedCarVO #distance').val());
		formData.append("fuel", $('#usedCarVO #fuel').val());
//		formData.append("options", $('#usedCarVO #options').val());
//		formData.append("icon", $('#usedCarVO #icon').val());
		formData.append("etc_memo", $('#usedCarVO #etc_memo').val());		
		formData.append("accident", $('#usedCarVO #accident').val());
		
		var optionStr = "";
		$('input:checkbox[name="options"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				optionStr += $(this).val() + "|";
			}
		});
		
		var iconStr = "";
		$('input:checkbox[name="icon"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				iconStr += $(this).val() + "|";
			}
		});		

		formData.append("options", optionStr);
		formData.append("icon", iconStr);

		$('#detailDesc').text($('#summernote').summernote('code'));
		//URL encode

		formData.append("detailDesc", urlHarmonyEncode($('#usedCarVO #detailDesc').val()));
		
		$(".file_add").each(function(i,e) {
			formData.append('attechFiles', $(this).get(0).files[0]);
		});

		$.ajax({
			url : '${ctx}/admin/usedcarAction',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(data) {
				if(data.resultCode == "NOT_LOGGED"){
					alert('로그인이 만료되었습니다.');
					return;
				} else if(data.resultCode == "0000"){
					moveList();
				} else {
					alert('게시물 저장에 실패했습니다.');
					return;
				}
			},error:function(xhr, textStatus) {
				alert('게시물 저장에 실패했습니다.');
				return;
			},complete : function(result) {
			}
		});
	}
	
	// 상세
	function moveList() {
		var url = "/admin/usedcarlist";
//		url += "?bcId=" + $("#gnrlBoardVO #bcId").val();
//		url += "&bctNo=" + $("#gnrlBoardVO #bctNo").val();
//		url += "&board=" + $("#gnrlBoardVO #board").val();
//		url += "&searchKey=" + $("#gnrlBoardVO #searchKey").val();
//		url += "&searchValue=" + $("#gnrlBoardVO #searchValue").val();
//		url += "&currentPageNo=" + $("#gnrlBoardVO #currentPageNo").val();
//		if($('#prepareMorder').length != 0 && $('#prepareMorder').val().trim() != ''){
//			url += "&mOrder=" + $('#prepareMorder').val();
//		}
		location.href = url;
	}
	

	function openFlash() { 
		var url = "${ctx}/common/paximage/editorPopup";
		url += "?bcId=" + $("#gnrlBoardVO #bcId").val();
//		url += "&bctNo=" + $("#gnrlBoardVO #bctNo").val();
		util.winPopup(url, 'flashImageEditPopup', 'width=730, height=660, toolbar=0, menubar=0, scrollbars=auto, resizable=yes, status=yes');
	}

    function insertPaxImage(images) {
//        console.log(images);
        $('#summernote').summernote('focus');
        for(var i = 0; i < images.length; i++) {
            var image = '${ctx}/common/paximage/showImage?imagePath=' + images[i];
            //var image = '${ctx}/cafefile/data/general/' + images[i];
//            $('#summernote').summernote('insertImage', image);
			$('#summernote').summernote('pasteHTML', '<img src="' + image + '"/>');
//            console.log("$('#summernote').summernote('insertImage', '" + image + "');");
        }
    }
    function urlHarmonyEncode(url) {
    	url = url.toString();
    	return encodeURIComponent(url);
    	//  return encodeURIComponent(url.replace(/&lt;/gi, "%PP_%").replace(/&gt;/gi, "%_PP%").replace(/</gi, "%P_%").replace(/>/gi, "%_P%").replace(/href=/gi, "%href_P%"));
    }
	</script>
