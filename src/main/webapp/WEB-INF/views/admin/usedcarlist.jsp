<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/adm-list.css">


  <div class="content_box">
    <form class="search_box" action="${CPATH}/admin/usedcarlist">
      <span>차량명</span>
      <input type="text" name="search1" id="search1">
      <button>검색</button>
      &nbsp;&nbsp;&nbsp;&nbsp;	<button type="button" onClick="location.href='usedcarform'">등록</button>
    </form>
    <h2>
      차량리스트
    </h2>
    <div class="car_list">
      <div class="list_style list_header">
<!--  
        <div class="item_check">
          <label class="check_lable">
            <input type="checkbox">
            <div class="check_style">
              <img src="/img/check.svg" alt="">
            </div>
          </label>
        </div>
-->        
        <div class="item_img">차량사진</div>
        <div class="item_name">차량명</div>
        <div class="item_deposit">보증금</div>
        <div class="item_rent">렌트료</div>
        <div class="item_click">클릭수</div>
        <div class="item_order">출력순서</div>
        <div class="item_status">판매여부</div>
        <div class="item_gubun">차량구분</div>
        <div class="item_setting">관리</div>
      </div>
      <ul class="list_content">



	<c:forEach var="usedCarVO" items="${usedCarVO }">
        <li class="list_style list_item">
<!--          
          <div class="item_check">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check.svg" alt="">
              </div>
            </label>
          </div>
-->
          <div class="item_img">
            <img class="img_cover" src="${usedCarVO.image }" alt="">
          </div>
          <div class="item_name">
            <span class="ellipsis_two">[${usedCarVO.car_no}]${usedCarVO.trim_name }</span>
          </div>
          <div class="item_deposit">
            <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.deposit }" />원</span>
          </div>
          <div class="item_rent">
            <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee }" /></span>
          </div>
          <div class="item_click">
            <span class="ellipsis">${usedCarVO.view_cnt} </span>
          </div>
          <div class="item_order">
            <span class="ellipsis">${usedCarVO.ranking }</span>
          </div>
          <div class="item_status">
       		<span class="ellipsis">${usedCarVO.sell_state }</span>
          </div>
          <div class="item_gubun">
	          <span class="ellipsis">${usedCarVO.car_type }</span>
          </div>
          <div class="item_setting">
            <button onclick="javascript:modifyUsedCar('${usedCarVO.id }','${usedCarVO.car_no }' )">수정</button> / 
            <button onclick="javascript:deleteUsedCar('${usedCarVO.id }','${usedCarVO.car_no }' )">삭제</button>
          </div>
        </li>				
	</c:forEach>			
	
      </ul>
    </div>

    <div class="page_box">
    
 	    <button onclick="javascript:goPage(${paging.prevPageNo})" class="prev">◀</button>
        <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
           <c:choose>
                <c:when test="${i eq paging.pageNo}"><button onclick="javascript:goPage(${i})" style="background-color: yellow;">${i}</button></c:when>
				<c:otherwise><button onClick="javascript:goPage(${i})">${i}</button></c:otherwise>
			</c:choose>
		</c:forEach>
		    <button onclick="javascript:goPage(${paging.nextPageNo})" class="next">▶</button>   

  </div>

	<span>${paging.totalCount} 개가 있습니다.</span>
  </div>

<script>

/**
 * 수정된 견적 내용을 저장한다.
 * (진행상태, 메모)
 */
var deleteUsedCar = function(id, trim_name) {
	if(!confirm(trim_name+'을 정말로 삭제 하시겠습니까?') ){
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
var modifyUsedCar = function(id, trim_name) {
	location.href = "/admin/usedcarUpdate?id="+id;

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

	location.href = "./usedcarlist?"
			+ "&search1=" + document.getElementById("search1").value.trim()
			+ "&page=" + page;
}

window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
