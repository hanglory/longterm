<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>

ul {
	margin: 0;
	padding: 0;
}
.main {
	width: calc(100% - 40px);
	position: relative;
	margin: 20px auto;
}

.optionBox {
	display: block; 
	width: calc(100% - 40px);
	position: relative;
	margin: 20px auto;
}

input[type=text], input[type=date], input[type=submit] {
	height: 2em;
	width: 200px;
}

table {
	font-family: "Noto Sans KR", "Nanum Gothic", "Malgun Gothic", Georgia, serif;
}
table#list {
	margin: 20px 0;
	width: 100%;
	border-collapse: collapse;
	--font-size: 1.2em;
	--border-top: 10px solid #338;
	border-bottom: 10px solid #338;
}

table#detail {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

tr:nth-child(even) {
	background-color: #eef;
}

tr:hover td {
	background: #88f;
	color:#333;
	transition: all 0.3s;
}
#detail th {
	color: #ffffff;
	background-color: rgb(46, 49, 146);
	border: 1px solid #aaa;
	padding: 6px;
}
#detail td {
	padding: 4px;
	border: 1px solid #aaa;
}
#list td {
	text-align: center;
}

#detail td:nth-child(1) {
	width: 100px;
	text-align: center;
}

/* text-align : center */
.tac {
	text-align : center;
}

/* text-align : right */
.tar {
	text-align : right;
}

.paginate {
	margin: 20px auto;
	text-align: center;
}

.paginate .choice {
	border: 1px solid #338;
	border-radius: 4px;
	background-color: #338;
	
	color: white;
	padding: 12px;
	font-size: 1.2em;
	font-weight: bold;

}

.paginate a {
	text-decoration: none ;
	padding: 10px;
}


.sel-item td {
	color: #ffffff;
	background-color: #8030a0;
}


.disable-dbl-tap-zoom {
	touch-action: manipulation;
}

.model-name {
	font-weight: bold;
}
</style>

<div class="main">
<div class="optionBox">
	<div style="text-align:right">
	<h1 style="text-align:left">견적 상세</h1>
	 
	  <button  onclick="onActiveModal()">견적서보기</button> /
		<button onclick="javascript:showList()">리스트보기</button> / 
		<button onclick="javascript:saveEstimate()">저장</button>

		
	</div>
	<div id="optionInfo"></div>
</div>
<table id="detail" data-id='${estimate.estimate_no}'>
	<tr>
		<th>항목</th>
		<th>내용</th>
	</tr>
	<tr>
		<td>견적번호</td>
		<td>${estimate.type}${estimate.estimate_no}</td>
	</tr>
	<tr>
		<td>차량</td>
		<td>${car.maker} - ${car.model_name } - ${car.lineup } - ${car.trim_name }</td>
	</tr>
	<tr>
		<td>차량가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty car.price ? 0 : car.price}" /> 원</td>
	</tr>

	<tr>
		<td>옵션가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.option_price ? 0 : estimate.option_price}" /> 원</td>
	</tr>
	
	<tr>
		<td>색상</td>
		<td>
			${color.color_name }
			<c:if test="${not empty color.price and color.price != 0}"> 
			(+ <fmt:formatNumber type="number" maxFractionDigits="3" value="${color.price}" /> 원)
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td>총 가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${car.price + estimate.option_price + color.price}" /> 원</td>
	</tr>

	<tr>
		<td>선택옵션</td>
		<td>
			<ul>
			<c:forEach items="${options }" var="option">
				<li>${option.name }</li>
			</c:forEach>
			</ul>
		</td>
	</tr>
	<tr>
		<td>주행거리</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.distance ? 0 : estimate.distance/10000 }" /> 만KM</td>
	</tr>
	<tr>
		<td>계약기간</td>
		<td>${estimate.period }개월</td>
	</tr>

	<tr>
		<td>월렌트료</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.rentfee ? 0 : estimate.rentfee }" /> 원</td>
	</tr>

	<tr>
		<td>보증금</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.deposit ? 0 : estimate.deposit }" /> 원</td>
	</tr>
	<tr>
		<td>만기인수가</td>
		<td>
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.acquisition ? 0 : estimate.acquisition }" /> 원
			<c:if test="${userLevel == 10 }"> 
				<c:if test="${fn:indexOf(estimate.type,'H') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'N') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>	%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'M') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
							/ 잔가(0%)
				</c:if>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>수수료</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.agent_fee }" /> (${estimate.agent_fee_rate } %)</td>
	</tr>	
	<tr>
		<td>탁송</td>
		<td>${estimate.tagsong }</td>
	</tr>
	
	<tr>
		<td>블랙박스</td>
		<td>${estimate.blackbox }</td>
	</tr>
	
	<tr>
		<td>기타 비용</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.etcprice ? 0 : estimate.etcprice}" /> 원</td>
	</tr>
	
	<tr>
		<td>고객</td>
		<td>
			${estimate.customer } / ${estimate.tel } / ${estimate.email }
		</td>
	</tr>
		
	<tr>
		<td>진행상황</td>
		<td>
			
			<select name="" id="state-sel">
				<option value="문의" <c:if test="${estimate.state=='문의'}">selected </c:if> >문의</option>
				<option value="상담보류" <c:if test="${estimate.state=='상담보류'}">selected </c:if> >상담보류</option>
				<option value="상담취소" <c:if test="${estimate.state=='상담취소'}">selected </c:if> >상담취소</option>
				<option value="계약" <c:if test="${estimate.state=='계약'}">selected </c:if> >계약</option>
				<option value="출고완료" <c:if test="${estimate.state=='출고완료'}">selected </c:if> >출고완료</option>
				<option value="계약취소" <c:if test="${estimate.state=='계약취소'}">selected </c:if> >계약취소</option>

			</select> 
		</td>
	</tr>

	<tr>
		<td>메모</td>
		<td>
			<textarea id="memo" placeholder="메모를 작성하세요" rows="10" style="width:100%;">${estimate.memo }</textarea>
		</td>
	</tr>
</table>
</div>
<script>
var showList = function() {
//	document.querySelector('.optionBox').style.display = "none";
//	document.querySelector('.main').style.display = "block";
	location.href="estimatelist";
}
/*
var goPage = function(page) {
	var type1Sel = document.getElementById("type1");
	var type2Sel = document.getElementById("type2");
	location.href = "./estimatelist?type1="+ type1Sel[type1Sel.selectedIndex].value
					+ "&search1=" + document.getElementById("search1").value.trim()
					+ "&type2="+ type2Sel[type2Sel.selectedIndex].value
					+ "&search2=" + document.getElementById("search2").value.trim()
					+ "&search-start=" + document.getElementById("start").value
					+ "&search-end=" + document.getElementById("end").value
					+ "&page=" + page;
}

document.querySelector("#list").addEventListener("dblclick", function (e){
	var elems = document.querySelectorAll(".sel-item");
	for(var i=0; i<elems.length; i++) {
		elems[i].classList.remove("sel-item");
	}
	if (e.target.nodeName == "TD") {
		e.preventDefault();
		getEstimateOne(e.target.parentElement.dataset.e_id, e.target);
		e.target.parentElement.classList.add("sel-item");
	}
	e.preventDefault();
}, false);
*/

/**
 * 
 * 갤럭시 탭에서는 dblclick Event가 동작하지만, 아이패드에서는 동작하지 않는다.
 * 아이패드에서 더블 클릭 동작 문제를 해결하기 위한 코드
 */
 /*
var lastTouchEnd = 0; 
document.querySelector("#list").addEventListener('touchend', function (e) {
    var now = (new Date()).getTime();
    if (now - lastTouchEnd <= 300) {
		e.preventDefault();
         
     	var elems = document.querySelectorAll(".sel-item");
    	for(var i=0; i<elems.length; i++) {
    		elems[i].classList.remove("sel-item");
    	}
    	if (e.target.nodeName == "TD") {
    		e.preventDefault();
    		getEstimateOne(e.target.parentElement.dataset.e_id, e.target);
    		e.target.parentElement.classList.add("sel-item");
    	}
	} lastTouchEnd = now; 
}, false);
   */
/**
 * 하나의 견적 내용을 HTML 형태로 가져온다.
 */
/* 
var getEstimateOne = function(estimate_id, node) {
	
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == xhr.DONE ) {
			if (xhr.status == 200 || xhr.status == 201) {
				document.querySelector('.optionBox').style.display = "block";
				document.querySelector('.main').style.display = "none";
				document.getElementById("optionInfo").innerHTML = xhr.responseText;
				
			} else {
				console.log(xhr.responseText);
			}
		}
	};

	document.querySelector('.optionBox').style.display = "block";
	document.querySelector('.main').style.display = "none";
	document.getElementById("optionInfo").innerHTML = xhr.responseText;
	
	xhr.open("POST", "${CPATH}/esti/estimatedetail");
	//xhr.setRequestHeader("content-type", "application/json");
	xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

	var arg = "estimate_id=" + estimate_id;
	console.log(arg);
	xhr.send(arg);

};
*/
/**
 * 수정된 견적 내용을 저장한다.
 * (진행상태, 메모)
 */
var saveEstimate = function() {
	var xhr = new XMLHttpRequest();
	var data = {};
	data.id = document.getElementById("detail").dataset.id;
	var sel = document.getElementById("state-sel");
	data.state = sel[sel.selectedIndex].value;
	data.memo = document.getElementById("memo").value;

	xhr.onreadystatechange = function() {
		if (xhr.readyState == xhr.DONE ) {
			if (xhr.status == 200 || xhr.status == 201) {
				// 동작을 마쳤으면, 페이지를 다시 불러온다.
				// location.reload();
				location.href="estimatelist";
			} else {
				console.log(xhr.responseText);
			}
		}
	};

	
	xhr.open("POST", "${CPATH}/esti/update");
	xhr.setRequestHeader("content-type", "application/json");
	//xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	console.log(JSON.stringify(data));
	xhr.send(JSON.stringify(data));
}
	
</script>




<%@ include file="../admin/estimate_tot_popup.jsp" %>

