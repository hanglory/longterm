<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
	display: none;
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
th {
	color: #ffffff;
	background-color: rgb(46, 49, 146);
	border: 1px solid #aaa;
	padding: 6px;
}
td {
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

	<h1>견적서 리스트</h1>
	<form class="search-box" action="${CPATH}/member/${userId }/estimatelist">
		<select name="type1" id="type1">
			<option value="type" <%=request.getParameter("type1") == null ? "" : request.getParameter("type1").equals("type") ? "selected" : "" %> >종류</option>
			<option value="estimate_no" <%=request.getParameter("type1") == null ? "selected" : request.getParameter("type1").equals("estimate_no") ? "selected" : "" %> >견적번호</option>
			<option value="customer" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("customer") ? "selected" : "" %> >고객</option>
			<option value="tel" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("tel") ? "selected" : "" %> >전화번호</option>
			<option value="t.name" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("t.name") ? "selected" : "" %> >차종</option>
			<option value="state" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("state") ? "selected" : "" %> >진행상황</option>
		</select>
		<input type="search" name="search1" id="search1" value="<%=request.getParameter("search1") == null ? "" : request.getParameter("search1")%>"/>
		
		<select name="type2" id="type2">
			<option value="type" <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("type") ? "selected" : "" %>>종류</option>
			<option value="estimate_no"  <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("estimate_no") ? "selected" : "" %>>견적번호</option>
			<option value="customer" <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("customer") ? "selected" : "" %>>고객</option>
			<option value="tel" <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("tel") ? "selected" : "" %>>전화번호</option>
			<option value="t.name" <%=request.getParameter("type2")==null ? "selected" : request.getParameter("type2").equals("t.name") ? "selected" : "" %> >차종</option>
			<option value="state" <%=request.getParameter("type2")==null ? "" : request.getParameter("type2").equals("state") ? "selected" : "" %> >진행상황</option>
		</select>
		<input type="search" name="search2" id="search2" value="<%=request.getParameter("search2") == null ? "" : request.getParameter("search2")%>" />

<input type="submit" value="검색" />

		<div class="fr">
			<span>기간별검색</span><input type="date" id="start" name="search-start" value="<%=request.getParameter("search-start")%>"/>
			<span>~</span><input type="date" id="end" name="search-end" value="<%=request.getParameter("search-end")%>" />
		</div>
        
	</form>
	<div>
		<span>${paging.totalCount} 개가 있습니다.</span>
		<table id="list" class="disable-dbl-tap-zoom">
			<tr>
				<th rowspan='2'>종류</th>
				<th rowspan='2'>견적번호</th>
				<th rowspan='2'>모델명</th>
				<th>차량가</th>
<c:if test="${isMobile == 1} ">				
				<th>옵션가</th>
				<th>보증금</th>
				<th>월렌트료</th>
				<th>계약기간</th>
				<th rowspan='2'>블랙박스</th>
				<th rowspan='2'>탁송지</th>
				<th>수수료</th>
<!-- 				<th rowspan='2'>담당영업사원</th> -->
				<th rowspan='2'>고객</th>
</c:if>				
				<th rowspan='2'>진행상황</th>
			</tr>
			
			<tr>
				<th>(원)</th>
<c:if test="${isMobile == 1} ">					
				<th>(원)</th>
				<th>(원)</th>
				<th>(원)</th>
				<th>(개월)</th>
				<th>(원)</th>
</c:if>				
			</tr>
				<c:forEach var="estimate" items="${estimates }">
				<tr data-e_id=${estimate.id } data-t_id=${estimate.trim_id }>

				    <td>${estimate.type}</td>

					<td>${estimate.estimate_no }</td>
					
				    <td class="tac">${estimate.maker} 
				    	<span class='model-name'>${estimate.name }</span>
				    	${estimate.lineup }
				    	${estimate.trim_name }</td>
				
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.price }" /></td>
				 <c:if test="${isMobile == 1} ">	   
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.option_price}" /> </td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit }" /></td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.rentfee}" /> </td>
				    <td>${estimate.period }</td>
					<td>${estimate.blackbox }</td>
					<td>${estimate.tagsong }</td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.agent_fee}" /> </td>
				    <td>${estimate.customer }</td>
			    </c:if>
				    <td>${estimate.state }</td>
				</tr>
				</c:forEach>

		</table>

		<!-- paging -->
		<div class="paginate">
<%-- 		    <a href="javascript:goPage(${paging.firstPageNo})" class="first">처음 페이지</a> --%>
		    <a href="javascript:goPage(${paging.prevPageNo})" class="prev">이전 페이지</a>
		    <span>
		        <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
		            <c:choose>
		                <c:when test="${i eq paging.pageNo}"><a href="javascript:goPage(${i})" class="choice">${i}</a></c:when>
		                <c:otherwise><a href="javascript:goPage(${i})">${i}</a></c:otherwise>
		            </c:choose>
		        </c:forEach>
		    </span>
		    <a href="javascript:goPage(${paging.nextPageNo})" class="next">다음 페이지</a>
<%-- 		    <a href="javascript:goPage(${paging.finalPageNo})" class="last">마지막 페이지</a> --%>
		</div>


	</div>
	

</div>

<div class="optionBox">
	<h1>견적 상세</h1>
	<div class="search-box" style="text-align:right">
		<button onclick="javascript:showList()">리스트 보기</button>
		<button onclick="javascript:saveEstimate()">저장</button>
	</div>
	<div id="optionInfo"></div>
</div>
	

<script>

var showList = function() {
	document.querySelector('.optionBox').style.display = "none";
	document.querySelector('.main').style.display = "block";
}
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


/**
 * 
 * 갤럭시 탭에서는 dblclick Event가 동작하지만, 아이패드에서는 동작하지 않는다.
 * 아이패드에서 더블 클릭 동작 문제를 해결하기 위한 코드
 */
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
   
/**
 * 하나의 견적 내용을 HTML 형태로 가져온다.
 */
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
	
	xhr.open("POST", "${CPATH}/esti/detail");
	//xhr.setRequestHeader("content-type", "application/json");
	xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

	var arg = "estimate_id=" + estimate_id;
	console.log(arg);
	xhr.send(arg);

};

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
				location.reload();
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
