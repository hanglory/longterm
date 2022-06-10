<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/admin-estimatelist.css" />

<div class="main">
	<h1>이용자 리스트</h1>
	<form class="search-form" action="/admin/userList">
		<select name="type1" id="type1">
			<option value="type"  >이름</option>
		</select>
		<input type="search" name="search1" id="search1" value=""/>
		<input type="submit" value="검색" />
	</form>
	<div>
		<span>${paging.totalCount} 개가 있습니다.</span>
		<table id="list">
			<tr>
			    <th>고객명</th>
        		<th>ID</th>
        		<th>Phone</th>
        		<th>mail</th>
        		<th>이용레벨</th>
        		<th>소속회사</th>
        		<th>매니저</th>
        		<th>상태</th>
        		<th>등록일</th>
        		<th>수정</th>
			</tr>

	<c:forEach var="userVO" items="${userVO }">
			<tr data-e_id=${userVO.id } data-t_id=${userVO.nickname }>

<!--          
				<tr data-e_id=913 data-t_id=3734>

				    <td>AN</td>
<td>2203160008</td>
<td>aga803001</td>
					<td>한경수</td>
                    <td>한경수</td>
				    <td class="tac">기아EV62021년형 롱 레인지에어 4WD</td>
				    <td>58,180,000</td>
					
<td>10,930,000</td>
				    <td>48</td>
				    <td>3만</td>
				    <td>1,150,000</td>
				    <td>650,000</td>
				    <td></td>
				    <td>문의</td>
				</tr>
-->
          	<td>${userVO.name }</td>
			<td>${userVO.nickname }</td>
          	<td>${userVO.phone }</td>
          	<td>${userVO.mail }</td>
          	<td>${userVO.level} </td>
          	<td>${userVO.company }</td>
          	<td>${userVO.manager }</td>
          	<td>${userVO.state }</td>
          	<td>${userVO.regdate }</td>
          	<td><a href="javascript:modifyUser('${userVO.id }','${userVO.name }' )" class="bluebtn">수정</a></td>
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
