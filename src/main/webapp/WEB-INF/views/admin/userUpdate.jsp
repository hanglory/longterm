<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/admin-estimatelist.css" />
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#level").val("${userVO.level }").prop("selected",true);
		$("#state").val("${userVO.state }").prop("selected",true);
		
	});
	
	function save(){
		if($("#name").val() == '') {
			alert("이름을 입력하세요.");
			$("#userVO #name").focus();
			return;
		}
		if($("#nickname").val() == '') {
			alert("아이디를 입력하세요.");
			$("#userVO #nickname").focus();
			return;
		}
		if($("#phone").val() == '') {
			alert("핸드폰 번호를 입력하세요.");
			$("#userVO #phone").focus();
			return;
		}
	
		var formData = new FormData();
		formData.append("id","${userVO.id }");
		formData.append("name", $('#name').val());
		formData.append("nickname", $('#nickname').val());
		formData.append("phone", $('#phone').val());
		formData.append("address", $('#address').val());
		formData.append("mail", $('#mail').val());
		formData.append("level", $('#userVO #level').val());
		formData.append("company", $('#userVO #company').val());
		formData.append("department", $('#userVO #department').val());
		formData.append("manager", $('#userVO #manager').val());
		formData.append("state", $('#userVO #state').val());
		
		$.ajax({
			url : '${ctx}/admin/userAction',
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
		var url = "/admin/userList";
		location.href = url;
	}	
	
</script>
	
    <div class="main_content content_box">
    <h2>
      이용자 정보 수정
    </h2>
<div class="cont-area">    
 <form id="userVO" action="userAction">
	<input type="hidden" id="id" value="${userVO.id}"/>
    <div class="register_wrap">
      <div class="left_area">
        <h3 class="sub_title">
          이용자정보
        </h3>
        <ul class="info_list">
          <li class="info_item">
            <p class="info_title">이름</p>
            <div class="input_wrap">
              <input type="text" id="name" name="name" value="${userVO.name }" placeholder="입력창(텍스트)">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">아이디</p>
            <div class="input_wrap">
              <input type="text" id="nickname" name="nickname" value="${userVO.nickname }" placeholder="입력창(텍스트)">
            </div>
          </li>		
          
          <li class="info_item">
            <p class="info_title">핸드폰</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="phone" id="phone" value="${userVO.phone }">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">주소</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="address" id="address" value="${userVO.address }" style="width: 100%">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">이메일</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="mail" id="mail" value="${userVO.mail }">
            </div>
          </li>

          <li class="info_item">
            <p class="info_title">권한레벨</p>
            <div class="input_wrap">
              <select class="box_style" name="level" id="level">
                <option value="1">1등급</option> <option value="2">2등급</option> <option value="3">3등급</option> <option value="4">4등급</option> <option value="5">5등급</option>
                <option value="6">6등급</option> <option value="7">7등급</option> <option value="8">8등급</option> <option value="9">9등급</option><option value="10">10등급</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">회사</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="company" id="company" value="${userVO.company }">
            </div>
          </li>          
          <li class="info_item">
            <p class="info_title">부서</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="department" id="department" value="${userVO.department }">
            </div>
          </li>          
          <li class="info_item">
            <p class="info_title">담당영업사원</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="manager" id="manager" value="${userVO.manager }">
            </div>
          </li>          
           <li class="info_item">
            <p class="info_title">상태</p>
            <div class="input_wrap">
              <select class="box_style" name="state" id="state">
                <option value="승인">승인</option>
                <option value="승인안됨">승인안됨</option>
                <option value="틸퇴">탈퇴</option>
              </select>
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
