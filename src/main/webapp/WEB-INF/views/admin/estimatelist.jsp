<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${RPATH}/css/admin-estimatelist.css" />

<style>
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

table {
	width: 100%;
	border-collapse: collapse;
	--font-size: 1.2em;
	border-top: 10px solid #338;
	border-bottom: 10px solid #338;
}

tr:nth-child(even) {
	background-color: #eef;
}

th {
	color: #332;
	background-color: #ccc;
	border: 1px solid #aaa;
}
td {
	padding: 4px;
	text-align: center;
	border: 1px solid #aaa;
}

tr:hover td {
	color: #fff;
	background-color: #000;
	transition: all 0.2s;
	--font-size: 1.2rem;
	--transform: scale(1.3);
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
	padding: 8px;
	font-size: 1.2em;
	font-weight: bold;

}

.paginate a {
	text-decoration: none ;
	padding: 6px;
}
</style>

    <% 
	int isMobile = 0;
	String agent = request.getHeader("USER-AGENT");
	String[] mobileos = {"iPhone","iPod","iPad","Android","BlackBerry","Windows CE","Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
	int j = -1;
	for(int i=0 ; i<mobileos.length ; i++) {
		j=agent.indexOf(mobileos[i]);
		if(j > -1 )
		{
			// 모바일로 접근했을 때
			isMobile = 1;
			break;
		}
	}
%>

<div class="main">
	<span class="title_history">견적서 리스트</span>
	<form class="search-form" action="${CPATH}/admin/estimatelist">
		<select name="type1" id="type1">
			<option value="type" <%=request.getParameter("type1") == null ? "" : request.getParameter("type1").equals("type") ? "selected" : "" %> >종류</option>
			<option value="estimate_no" <%=request.getParameter("type1") == null ? "selected" : request.getParameter("type1").equals("estimate_no") ? "selected" : "" %> >견적번호</option>
			<option value="customer" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("customer") ? "selected" : "" %> >고객</option>
			<option value="t.name" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("t.name") ? "selected" : "" %> >차종</option>
			<option value="user_id" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("user_id") ? "selected" : "" %> >아이디</option>
			<option value="user_name" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("user_name") ? "selected" : "" %> >이름</option>
	       <option value="user_manager" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("user_manager") ? "selected" : "" %> >본사담당</option>
			<option value="state" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("state") ? "selected" : "" %> >진행상태</option>
		</select>
		<input type="search" name="search1" id="search1" value="<%=request.getParameter("search1") == null ? "" : request.getParameter("search1")%>"/>
		
		<select name="type2" id="type2">
			<option value="type" <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("type") ? "selected" : "" %>>종류</option>
			<option value="estimate_no"  <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("estimate_no") ? "selected" : "" %>>견적번호</option>
			<option value="customer" <%=request.getParameter("type2") == null ? "" : request.getParameter("type2").equals("customer") ? "selected" : "" %>>고객</option>
			<option value="t.name" <%=request.getParameter("type2")==null ? "selected" : request.getParameter("type2").equals("t.name") ? "selected" : "" %> >차종</option>
		</select>
		<input type="search" name="search2" id="search2" value="<%=request.getParameter("search2") == null ? "" : request.getParameter("search2")%>" />

<input type="submit" value="검색" />

		<div class="fr">
			<span>기간별검색</span><input type="date" id="start" name="search-start" value="<%=request.getParameter("search-start")%>"/>
			<span>~</span><input type="date" id="end" name="search-end" value="<%=request.getParameter("search-end")%>" />
		</div>
        
	</form>

      
	<div>
		<span>견적서 총 ${paging.totalCount} 개</span>
		  <% if(isMobile == 1){ %>
               <li style="color:red;">두번 누르시면 상세페이지로 이동합니다.</li>
        <table id="list">    
			<tr>
				<th rowspan='2'>종류</th>			
				<th rowspan='2'>이름</th>              
				<th rowspan='2'>모델</th>
				<th>차량가격</th>
<!-- 				<th>제조사</th> -->
<!-- 				<th>차종</th> -->
<!-- 				<th>라인업</th> -->
<!-- 				<th>트림</th> -->
<!-- 				<th>보증금 비율</th> -->
				
				<th rowspan='2'>진행상태</th>
			</tr>
			
			<tr>
				<th>(원)</th>
				
				
			</tr>
				<c:forEach var="estimate" items="${estimates }">
				<tr data-e_id=${estimate.id } data-t_id=${estimate.trim_id }>

				    <td>${estimate.type}</td>
<%-- 				    <td>${estimate.deposit_ratio == 0.5 ? "M" : "H"}</td> --%>

<%-- 					<td>${estimate.user_company} ${estimate.user_name }</td> --%>
				
					<td>${estimate.user_name }</td>
                   
				    <td class="tac">
				    	${estimate.name }
				    	</td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.price+estimate.option_price}" /></td>
					
<%-- 				    <td>${estimate.maker }</td> --%>
<%-- 				    <td>${estimate.name }</td> --%>
<%-- 				    <td>${estimate.lineup }</td> --%>
<%-- 				    <td class="tac">${estimate.trim_name }</td> --%>
<%-- 				    <td>${estimate.deposit_ratio }</td> --%>
				
				
		
				    <td>${estimate.state }</td>
				</tr>
				</c:forEach>

		</table>
		     <% }else { %>
		<table id="list">

			<tr>
				<th rowspan='2'>종류</th>
				<th rowspan='2'>견적번호</th>
				<th rowspan='2'>아이디</th>
				<th rowspan='2'>이름</th>
                <th rowspan='2'>본사담당</th>
				<th rowspan='2'>모델</th>
				<th>차량가격</th>
<!-- 				<th>제조사</th> -->
<!-- 				<th>차종</th> -->
<!-- 				<th>라인업</th> -->
<!-- 				<th>트림</th> -->
<!-- 				<th>보증금 비율</th> -->
				<th>보증금</th>
				<th>계약기간</th>
				<th>주행거리</th>
				<th>월렌트료</th>
				<th>옵션가격</th>
				<th rowspan='2'>색상</th>
				<th rowspan='2'>진행상태</th>
			</tr>
			
			<tr>

				<th>(원)</th>
				<th>(원)</th>
				<th>(개월)</th>
				<th>(KM)</th>
				<th>(원)</th>
				<th>(원)</th>
			</tr>
				<c:forEach var="estimate" items="${estimates }">
				<tr data-e_id=${estimate.id } data-t_id=${estimate.trim_id }>

				    <td>${estimate.type}</td>
<%-- 				    <td>${estimate.deposit_ratio == 0.5 ? "M" : "H"}</td> --%>

					<td>${estimate.estimate_no }</td>
<%-- 					<td>${estimate.user_company} ${estimate.user_name }</td> --%>
					<td>${estimate.user_id }</td>
					<td>${estimate.user_name }</td>
                    <td>${estimate.user_manager }</td>
				    <td class="tac">${estimate.maker} 
				    	${estimate.name }
				    	${estimate.lineup }
				    	${estimate.trim_name }</td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.price+estimate.option_price}" /></td>
					
<%-- 				    <td>${estimate.maker }</td> --%>
<%-- 				    <td>${estimate.name }</td> --%>
<%-- 				    <td>${estimate.lineup }</td> --%>
<%-- 				    <td class="tac">${estimate.trim_name }</td> --%>
<%-- 				    <td>${estimate.deposit_ratio }</td> --%>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit }" /></td>
				    <td>${estimate.period }</td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.distance/ 10000}" />만</td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.rentfee}" /></td>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.option_price}" /></td>
				    <td>${estimate.color_name }</td>
				    <td>${estimate.state }</td>
				</tr>
				</c:forEach>

		</table>
<% } %>
		
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
	<div style="text-align:right">
	 
	  <button  onclick="onActiveModal()">견적서보기</button> /
		<button onclick="javascript:showList()">리스트 보기</button> / 
		<button onclick="javascript:saveEstimate()">저장</button>

		
	</div>
	<div id="optionInfo"></div>
</div>
<script>


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
	var type1Sel = document.getElementById("type1");
	var type2Sel = document.getElementById("type2");

	location.href = "./estimatelist?"
			+ "type1="+ type1Sel[type1Sel.selectedIndex].value
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

var getEstimateOne = function(estimate_id, node) {
	location.href="estimateDetail?estimate_id="+estimate_id;

/*	
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
	xhr.send(arg);
*/	

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

window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
