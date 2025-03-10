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
/*
tr:hover td {
	color: #fff;
	background-color: #000;
	transition: all 0.2s;
	--font-size: 1.2rem;
	--transform: scale(1.3);
}
*/
/* text-align : center */
.tac {
	text-align : center;
}

/* text-align : right */
.tar {
	text-align : right;
}
.input {
	width:100%;
}

button {
    background-color: transparent;
    box-sizing: border-box;
    font-family: 'NotoSansKR';
    cursor: pointer;
    width: 150px;
    height: 30px;
    margin: 4px 0;
    padding: 0;
    border: 1px solid #999;
}
input[type=text], input[type=button], input[type=date], input[type=submit], input[type=number] {
    width: 150px;
    height: 30px;
    margin: 4px 0;
    padding: 0;
    border: 1px solid #999;
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

  <canvas id="canvas" style="display:none"></canvas>  
  
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/redmond/jquery-ui.min.css"/>
<script src="<c:url value="//code.jquery.com/jquery-3.1.0.min.js"/>"></script>
<script src="<c:url value="//code.jquery.com/ui/1.12.0/jquery-ui.min.js"/>"></script>
<script src="<c:url value="/js/jquery.fileDownload.js"/>"></script>
<script>
var canvas = document.getElementById("canvas");
var ctx = canvas.getContext("2d");
function showPer(per) { 
	ctx.clearRect(0, 0, 400, 400);  //바깥쪽 써클 그리기  
	ctx.strokeStyle = "#f66";  
	ctx.lineWidth=1000;  
	ctx.beginPath();  
	ctx.arc(60, 60, 500, 0, Math.PI * 2 * per / 100);  
	ctx.stroke();  //숫자 올리기  
	ctx.font = '32px serif';  
	ctx.fillStyle = "#000";  
	ctx.textAlign = 'center';  
	ctx.textBaseline = 'middle';
	ctx.fillText("다운로드중 잠시만 기다려 주세요",60,60);
//	ctx.fillText(per + '%', 60, 60);
}
	var url = '/admin/bankAccountExcelDown';

//	$("#btnSubmit").on("click", function(e) {  
	function btnClick(){
		$.ajax({    
			url: url,    
			type : 'get',    
			xhrFields: {  //response 데이터를 바이너리로 처리한다.      
				responseType: 'blob'    
				},    
			beforeSend : function() {  //ajax 호출전 progress 초기화      
				showPer(0);      
				canvas.style.display = 'block';    
			},    
			xhr: function() {  //XMLHttpRequest 재정의 가능      
				var xhr = $.ajaxSettings.xhr();      
				xhr.onprogress = function(e) {        
					showPer(Math.floor(e.loaded / e.total * 100));      
				};      
				return xhr;    
			},        
			success : function(data) {      
				console.log("완료");      
				var blob = new Blob([data]);       //파일저장      
				if (navigator.msSaveBlob) {        
					return navigator.msSaveBlob(blob, "전용계좌관리.xlsx");       
				}else {        
					var link = document.createElement('a');         
					link.href = window.URL.createObjectURL(blob);         
					link.download = "전용계좌관리.xlsx";        
					link.click();      
				}    
			},    
			complete : function() {      
				canvas.style.display = 'none';    
				}  
		});
	}
//	});

	//<![CDATA[
	$(function() {
		$("#btn-excel").on("click", function () {
			var $preparingFileModal = $("#preparing-file-modal");
			$preparingFileModal.dialog({ modal: true });
			$("#progressbar").progressbar({value: false});
			$.fileDownload("/admin/bankAccountExcelDown", {
				successCallback: function (url) {
					$preparingFileModal.dialog('close');
				},
				failCallback: function (responseHtml, url) {
					$preparingFileModal.dialog('close');
					$("#error-modal").dialog({ modal: true });
				}
			});

			// 버튼의 원래 클릭 이벤트를 중지 시키기 위해 필요합니다.
			return false;
		});
	});
	//]]>


	function fnExcelDownload()
	{
		window.location.href="/admin/bankAccountExcelDown";
	}
</script>
<div class="main">
	<form class="search-form" action="/admin/bankAccount" mothod="POST" onSubmit="return checkInput(this)">
		<select name="type1" id="type1">
			<option value="account">계좌번호</option>
			<option value="user_name">입금자명</option>
			<option value="reg_id">관리자명</option>
		</select>
		<input type="search" name="search1" id="search1" value="${search1 }"/>
		<input type="submit"  value="검색" style='cursor:pointer;'/>
	</form>
	<div>
		<span>발급계좌 총 ${paging.totalCount} 개</span> 		
		<button id="btn-excel" style='cursor:pointer;'>엑셀 다운로드</button>
		
		<!-- 파일 생성중 보여질 진행막대를 포함하고 있는 다이얼로그 입니다. -->
		<div title="Data Download" id="preparing-file-modal" style="display: none;">
			<div id="progressbar" style="width: 100%; height: 22px; margin-top: 20px;"></div>
		</div>
		
		<!-- 에러발생시 보여질 메세지 다이얼로그 입니다. -->
		<div title="Error" id="error-modal" style="display: none;">
			<p>생성실패.</p>
		</div>
		
		
		<table id="list">
		<colgroup>
			<col width="5%">
			<col width="8%">
			<col width="10%">
			<col width="20%">
			<col width="8%">
			<col width="14%">
			<col width="15%">
			<col width="20%">
			
		</colgroup>		
			<tr>
				<th>번호</th>
				<th>은행</th>
				<th>계좌번호</th>
				<th>입금자명</th>
				<th>고객번호</th>
                <!-- <th>발급일시</th> -->
                <th>영업번호</th>
                <th>에이전시번호</th>
                <th>관리자</th>
				<th>메모</th>
			</tr>
			
			<c:forEach var="bankAccount" items="${BankAccountVO }">
				<tr data-e_id="${bankAccount.seqno}" data-t_id="${bankAccount.account }">
				    <td>${bankAccount.seqno}</td>				
				    <td>${bankAccount.bank_name}</td>
					<td>${bankAccount.account }</td>
					<td>${bankAccount.user_name }</td>
					<td>${bankAccount.carno }</td>
					<td>${bankAccount.charge }</td>
					<td>${bankAccount.ag }</td>
                     <!-- <td>${bankAccount.recv_date }</td> -->
					<td>${bankAccount.name }</td>
					<td>${bankAccount.memo }</td>
				</tr>
			</c:forEach>

		</table>
		
		<!-- paging -->
		<div class="paginate">
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
		</div>
	</div>
</div>

<script>


function checkInput(frm){
	if(frm.search1.value == ''){
		alert('검색할 값을 입력해 주세요.');
		return false;
	}
	return true;
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
	var type1Sel = document.getElementById("type1");
//	var type2Sel = document.getElementById("type2");

	location.href = "./bankAccount?"
			+ "type1="+ type1Sel[type1Sel.selectedIndex].value
			+ "&search1=" + document.getElementById("search1").value.trim()
//			+ "&type2="+ type2Sel[type2Sel.selectedIndex].value
//			+ "&search2=" + document.getElementById("search2").value.trim()
//			+ "&search-start=" + document.getElementById("start").value
//			+ "&search-end=" + document.getElementById("end").value
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
	location.href="bankAccountUpdate?seqno="+estimate_id;

};


window.addEventListener("load", function() {
	//getEstimateList();
});

$(document).ready(function(){
	if('${type1}' == ''){
		$("#type1").val("account").prop("selected",true);
	}else{
		$("#type1").val("${type1 }").prop("selected",true);
	}
});
</script>
