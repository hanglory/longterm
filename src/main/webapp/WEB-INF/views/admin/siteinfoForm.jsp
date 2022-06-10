<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/admin-estimatelist.css" />
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#pc_type").val("${siteinfoVO.pc_type }").prop("selected",true);

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
				$(".add-file").hide();
				$(".file-list > input").remove();
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
		$(document).on('click', '._fileDelete', function(){
			$(this).parent().remove();
			$(".add-file").show();
		});		
	});
	
	function save(){
		if($("#title").val() == '') {
			alert("제목을 입력하세요.");
			$("#siteinfoVO #title").focus();
			return;
		}
		if($("#start_date").val() == '') {
			alert("시작일을 입력하세요.");
			$("#siteinfoVO #start_date").focus();
			return;
		}
		if($("#end_date").val() == '') {
			alert("종료일을 입력하세요.");
			$("#siteinfoVO #end_date").focus();
			return;
		}
		if($("#left_postion").val() == '') {
			alert("좌측시작점을 입력하세요.");
			$("#siteinfoVO #left_postion").focus();
			return;
		}
		if($("#top_postion").val() == '') {
			alert("상단시작점을 입력하세요.");
			$("#siteinfoVO #top_postion").focus();
			return;
		}
		if($("#width").val() == '') {
			alert("넓이 값을 입력하세요.");
			$("#siteinfoVO #width").focus();
			return;
		}
		if($("#height").val() == '') {
			alert("높이 값을 입력하세요.");
			$("#siteinfoVO #height").focus();
			return;
		}
	
		var formData = new FormData();
		formData.append("id","${siteinfoVO.id }");
		formData.append("title", $('#title').val());
		formData.append("start_date", $('#start_date').val());
		formData.append("end_date", $('#end_date').val());
		formData.append("top_postion", $('#top_postion').val());
		formData.append("left_postion", $('#left_postion').val());
		formData.append("width", $('#siteinfoVO #width').val());
		formData.append("height", $('#siteinfoVO #height').val());
		formData.append("pc_type", $('#siteinfoVO #pc_type').val());
		formData.append("link_url", $('#siteinfoVO #link_url').val());
		$(".file_add").each(function(i,e) {
			formData.append('attechFiles', $(this).get(0).files[0]);
		});
		if($("#contents").val() != ""){
			formData.append("contents", $('#contents').val());			
		}

		
		$.ajax({
			url : '${ctx}/admin/siteinfoAction',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(data) {
				if(data.resultCode == "NOT_LOGGED"){
					alert('로그인이 만료되었습니다.');
					return;
				} else if(data.resultCode == "0000" || data.resultCode > 0){
					moveList();
				} else if(data.resultCode == "DUP"){
					alert('일정이 중복되는 데이타가 있습니다.');
					return;
				} else {
					alert('정보 저장에 실패했습니다.');
					return;
				}
			},error:function(xhr, textStatus) {
				alert('정보 저장에 실패했습니다.');
				return;
			},complete : function(result) {
			}
		});
	}
	
	// 상세
	function moveList() {
		var url = "/admin/siteinfoList";
		location.href = url;
	}	
	
</script>
	
    <div class="main_content content_box">
    <h2>
      이용자 정보 수정
    </h2>
<div class="cont-area">    
 <form id="siteinfoVO" action="siteinfoAction">
	<input type="hidden" id="id" value="${siteinfoVO.id}"/>
    <div class="register_wrap">
      <div class="left_area">
        <h3 class="sub_title">
          레이어 팝업 등록/수정
        </h3>
        <ul class="info_list">
          <li class="info_item">
            <p class="info_title">제목</p>
            <div class="input_wrap">
              <input type="text" id="title" name="title" value="${siteinfoVO.title }" placeholder="입력창(텍스트)" style="width:100%">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">시작일시</p>
            <div class="input_wrap">
              <input type="date" id="start_date" name="start_date" value="${siteinfoVO.start_date }" placeholder="입력창(텍스트)">
            </div>
          </li>		
          
          <li class="info_item">
            <p class="info_title">종료일시</p>
            <div class="input_wrap">
              <input type="date" placeholder="입력창(텍스트)" name="end_date" id="end_date" value="${siteinfoVO.end_date }">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">좌측시작점</p>
            <div class="input_wrap">
              <input type="number" placeholder="입력창(텍스트)" name="left_postion" id="left_postion" value="${siteinfoVO.left_postion }">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">상단시작점</p>
            <div class="input_wrap">
              <input type="number" placeholder="입력창(텍스트)" name="top_postion" id="top_postion" value="${siteinfoVO.top_postion }">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">폭사이즈</p>
            <div class="input_wrap">
              <input type="number" placeholder="입력창(텍스트)" name="width" id="width" value="${siteinfoVO.width }">
            </div>
          </li>          
          <li class="info_item">
            <p class="info_title">높이사이즈</p>
            <div class="input_wrap">
              <input type="number" placeholder="입력창(텍스트)" name="height" id="height" value="${siteinfoVO.height }">
            </div>
          </li>          
         <li class="info_item">
            <p class="info_title">노출기기</p>
            <div class="input_wrap">
              <select class="box_style" name="pc_type" id="pc_type">
                <option value="1">PC</option> 
                <option value="2">mobile</option>
              </select>
            </div>
          </li>
         <li class="info_item">
            <p class="info_title">이미지 클릭 URL</p>
            <div class="input_wrap">
              <input type="text" id="link_url" name="link_url" value="${siteinfoVO.link_url }" placeholder="입력창(텍스트)" style="width:100%">
            </div>
          </li>          
          <li class="info_item">
            <p class="info_title">광고 <br>이미지</p>
            <div class="input_wrap file_wrap">
          		
             	<div class="file-list" style="width:100%">
             	<input type="text" value="${siteinfoVO.contents }" id="contents" name="contents" style="width:100%">
             	</div>
             	<p class="add-file">
            	<button type="button" class="file-ch _searchFileButton">파일선택 +</button>
            	</p>
            </div>
          </li>
          
         </ul>
       </div>
    </div>
    <div class="bottom_area" >
      <div class="button_wrap">
        <button type="button" onClick="save()">등록</button>
      </div>
    </div>
  </div>
</form>
</div>	

<script>

/**
 * 수정된 견적 내용을 저장한다.
 * (진행상태, 메모)
 */
var deleteUser = function(id, trim_name) {
	if(!confirm(trim_name+'을 정말로 해지 하시겠습니까?') ){
		return;
	}
	var xhr = new XMLHttpRequest();
	var data = {};
	data.id = id;

	xhr.onreadystatechange = function() {
		if (xhr.readyState == xhr.DONE ) {
			if (xhr.status == 200 || xhr.status == 201) {
				// 동작을 마쳤으면, 페이지를 다시 불러온다.
				location.reload();
			} else {
				console.log(xhr.responseText);
			}
		}
	};

	
	xhr.open("POST", "${CPATH}/admin/usedcarDelete");
	xhr.setRequestHeader("content-type", "application/json");
	//xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	console.log(JSON.stringify(data));
	xhr.send(JSON.stringify(data));
}

/**
 * 수정된 견적 내용을 저장한다.
 * (진행상태, 메모)
 */
var modifyUser = function(id, trim_name) {
	location.href = "/admin/userUpdate?id="+id;

}


var showList = function() {
	document.querySelector('.optionBox').style.display = "none";
	document.querySelector('.main').style.display = "block";
}
//문자열 프로토타입으로 입력 길이만큼 앞에 pad 문자/문자열로 채운 문자열 반환
String.prototype.fillPadsStart = function(width, pad){
    return this.length >= width || pad == undefined || pad.length == 0 ? this : 
        new Array(Math.floor((width-this.length)/pad.length)+1).join(pad) + 
        pad.substr(0,(width-this.length)%pad.length) + this;//남는 길이만큼 pad로 앞을 채움
}

 
var searchToday = function() {
	var dt = new Date();
 	document.getElementById("estimate_no").value = 
 		(dt.getFullYear() % 100).toString().padStart(2,'0') + 
 		(dt.getMonth() + 1).toString().padStart(2,'0') + 
 		dt.getDate().toString().padStart(2,'0');
 		"" ;
};

var goPage = function(page) {

	location.href = "./userList?"
			+ "&search1=" + document.getElementById("search1").value.trim()
			+ "&page=" + page;
}

window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
