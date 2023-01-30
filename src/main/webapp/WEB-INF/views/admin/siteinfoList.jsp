<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/admin-estimatelist.css" />

<div class="main">
	<h1>사이트관리리스트</h1>

	<div>
		<span>${paging.totalCount} 개가 있습니다.</span>
		<button class="bluebtn" style="float: right;" onclick="javascript:location.href='siteinfoForm'">등록</button>
		<table id="list">
			<tr>
			    <th>타이틀</th>
        		<th>시작일시</th>
        		<th>종료일시</th>
        		<th>좌측시작점</th>
        		<th>상단시작점</th>
        		<th>폭사이즈</th>
        		<th>높이사이즈</th>
        		<th>노출기기</th>
        		<th>수정</th>
			</tr>

	<c:forEach var="siteinfoVO" items="${siteinfoVO }">
		<tr data-e_id=${siteinfoVO.id } data-t_id=${siteinfoVO.title }>
	     	<td>${siteinfoVO.title }</td>
			<td>${siteinfoVO.start_date }</td>
          	<td>${siteinfoVO.end_date }</td>
          	<td>${siteinfoVO.left_postion } px</td>
          	<td>${siteinfoVO.top_postion} px</td>
          	<td>${siteinfoVO.width } px</td>
          	<td>${siteinfoVO.height } px</td>
          	<td>${siteinfoVO.pc_type }</td>
          	<td><a href="javascript:modifyUser('${siteinfoVO.id }','${siteinfoVO.title }' )" class="bluebtn">수정</a>
          	</td>
        </tr>
	</c:forEach>			
		</table>
	</div>
    <div class="paginate">
    
 	    <a href="javascript:goPage(${paging.prevPageNo})" class="prev">◀</a>
 	    <span>
        <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
           <c:choose>
                <c:when test="${i eq paging.pageNo}"><a href="javascript:goPage(${i})" class="choice">${i}</a></c:when>
				<c:otherwise><a href="javascript:goPage(${i})">${i}</button></c:otherwise>
			</c:choose>
		</c:forEach>
		</span>
		    <a href="javascript:goPage(${paging.nextPageNo})" class="next">▶</a>   

  	</div>
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
	location.href = "/admin/siteinfoForm?id="+id;

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
