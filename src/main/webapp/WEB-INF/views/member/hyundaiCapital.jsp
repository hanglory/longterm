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
   color: #fff;
    background-color: #10479c;
    border: 2px solid#10479c;
    padding: 6px;
}
td {
	padding: 6px;
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
    border: none;
    background-color: transparent;
    box-sizing: border-box;
    font-family: 'NotoSansKR';
    cursor: pointer;
}
input[type=text], input[type=button], input[type=date], input[type=submit], input[type=number] {
    width: 20%;
    height: 30px;
    margin: 4px 0;
    padding: 0;
    border: 1px solid #999;
}
.input_box {
    float: left;
    width: calc(100%);
    height: 100%;
    margin-right: 0px;
    border: 1px solid #e8e8e8;
}
    
    .title_history2{
        
        color: #10479C;
    text-decoration: none;
    letter-spacing: 0px;
    font-weight: bold;
    font-size: 24px;
        
    }
    
    .userlist{
 width: 100%;
    border-collapse: collapse;
    --font-size: 1.2em;
    border-top: 2px solid #10479c;
    border-bottom: 2px solid #10479c;
} 
        
        
 


</style>





<script>






</script>

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
	<span class="title_history2">현대캐피탈 DB정보</span>
	<br><br>
    
	<div>
		<span style="font-size:18px;">고객정보 리스트</span> &nbsp; 

        <br><br>

		<table class="userlist" id="list">

			<tr>
				<th>동의일자</th>
				<th>상품코드</th>
				<th>고객번호</th>
				<th>고객명</th>
				<th>고객연락처</th>
				<th>상담차종</th>
				<th>사유코드</th>
                <th>고객세그먼트</th>
                <th>이관업체</th>
                <th>진행내역</th>
                <!--<th>발급일시</th>-->
	   
			</tr>
			
			
				
				<!-- <form method="post" id="frequestform" name="frequestform" onSubmit="return banksendSmsMsg(this)" action="#"> --> 
			
				<tr>
				    <!--<td>${bankAccount.bank_name}</td>-->
					
                    <td><span id="agreedate" name="agreedate"  maxlength="20" class="input_box">2023.04.30</span></td>
                    <td><span  id="product_code" name="product_code" maxlength="10" class="input_box">중고리스</span></td>
                    <td><span  id="cust_no" name="cust_no" maxlength="20"  class="input_box">1917918**</span></td>
					<td><span  id="cust_num" name="cust_num"  maxlength="20"  class="input_box">010-1234-5678</span></td>
                    <td><span  id="car_name" name="car_name" maxlength='20'  class="input_box">G80</span></td>
					<td><span  id="cust_name" name="cust_name" maxlength='20'  class="input_box">오**</span></td>
					<td><span id="reason_code" name="reason_code" maxlength='20'  class="input_box">다중채무</span></td>
                    <td><span id="segment" name="segment" maxlength='20'  class="input_box">26세이상</span></td>
                    <td><span id="hyundai" name="hyundai"  maxlength='20'  class="input_box">현대캐피탈</span></td>
                     <td>
                    <select name="state" id="state">
				<option value="문의" >문의</option>
				<option value="상담보류">상담보류</option>
				<option value="상담취소"> 상담취소</option>
				<option value="계약">계약</option>
				<option value="출고완료">출고완료</option>
				<option value="계약취소">계약취소</option>

			</select> 
                    
                    </td>
         
				</tr>
					<tr>
				    <!--<td>${bankAccount.bank_name}</td>-->
					
                    <td><span id="agreedate" name="agreedate"  maxlength="20" class="input_box">2023.05.01</span></td>
                    <td><span  id="product_code" name="product_code"  maxlength="10" class="input_box">중고론</span></td>
                    <td><span  id="cust_no" name="cust_no"  maxlength="20"  class="input_box">16877918**</span></td>
					<td><span  id="cust_num" name="cust_num"  maxlength="20"  class="input_box">010-1234-5678</span></td>
                    <td><span  id="car_name" name="car_name"  maxlength='20'  class="input_box">K5</span></td>
					<td><span  id="cust_name" name="cust_name"  maxlength='20'  class="input_box">김**</span></td>
					<td><span id="reason_code" name="reason_code"  maxlength='20'  class="input_box">신용불량</span></td>
                    <td><span id="segment" name="segment"  maxlength='20'  class="input_box">26세미만</span></td>
                    <td><span id="hyundai" name="hyundai"  maxlength='20'  class="input_box">현대캐피탈</span></td>
                     <td>
                    <select name="state" id="state">
				<option value="문의" >문의</option>
				<option value="상담보류">상담보류</option>
				<option value="상담취소"> 상담취소</option>
				<option value="계약">계약</option>
				<option value="출고완료">출고완료</option>
				<option value="계약취소">계약취소</option>

			</select> 
                    
                    </td>
         
				</tr>
            
            		<tr>
				    <!--<td>${bankAccount.bank_name}</td>-->
					
                    <td><span id="agreedate" name="agreedate"  maxlength="20" class="input_box">2023.05.02</span></td>
                    <td><span  id="product_code" name="product_code"  maxlength="10" class="input_box">중고론</span></td>
                    <td><span  id="cust_no" name="cust_no"  maxlength="20"  class="input_box">16547918**</span></td>
					<td><span  id="cust_num" name="cust_num"  maxlength="20"  class="input_box">010-1234-5678</span></td>
                    <td><span  id="car_name" name="car_name"  maxlength='20'  class="input_box">쏘나타</span></td>
					<td><span  id="cust_name" name="cust_name"  maxlength='20'  class="input_box">이**</span></td>
					<td><span id="reason_code" name="reason_code"  maxlength='20'  class="input_box">연체중</span></td>
                    <td><span id="segment" name="segment"  maxlength='20'  class="input_box">26세미만</span></td>
                    <td><span id="hyundai" name="hyundai"  maxlength='20'  class="input_box">현대캐피탈</span></td>
                     <td>
                    <select name="state" id="state">
				<option value="문의" >문의</option>
				<option value="상담보류">상담보류</option>
				<option value="상담취소"> 상담취소</option>
				<option value="계약">계약</option>
				<option value="출고완료">출고완료</option>
				<option value="계약취소">계약취소</option>

			</select> 
                    
                    </td>
         
				</tr>
            
            <tr>
				    <!--<td>${bankAccount.bank_name}</td>-->
					
                    <td><span id="agreedate" name="agreedate"  maxlength="20" class="input_box">2023.05.03</span></td>
                    <td><span  id="product_code" name="product_code"  maxlength="10" class="input_box">신차리스</span></td>
                    <td><span  id="cust_no" name="cust_no"  maxlength="20"  class="input_box">1917918**</span></td>
					<td><span  id="cust_num" name="cust_num"  maxlength="20"  class="input_box">010-1234-5678</span></td>
                    <td><span  id="car_name" name="car_name"  maxlength='20'  class="input_box">코나</span></td>
					<td><span  id="cust_name" name="cust_name"  maxlength='20'  class="input_box">정**</span></td>
					<td><span id="reason_code" name="reason_code"  maxlength='20'  class="input_box">한도부족</span></td>
                    <td><span id="segment" name="segment"  maxlength='20'  class="input_box">26세이상</span></td>
                    <td><span id="hyundai" name="hyundai"  maxlength='20'  class="input_box"></span>현대캐피탈</td>
                     <td>
                    <select name="state" id="state">
				<option value="문의" >문의</option>
				<option value="상담보류">상담보류</option>
				<option value="상담취소"> 상담취소</option>
				<option value="계약">계약</option>
				<option value="출고완료">출고완료</option>
				<option value="계약취소">계약취소</option>

			</select> 
                    
                    </td>
         
				</tr>
            
            <tr>
				    <!--<td>${bankAccount.bank_name}</td>-->
					
                    <td><span id="agreedate" name="agreedate" maxlength="20" class="input_box">2023.05.04</span></td>
                    <td><span  id="product_code" name="product_code"  maxlength="10" class="input_box">중고리스</span></td>
                    <td><span  id="cust_no" name="cust_no"  maxlength="20"  class="input_box">1647918**</span></td>
					<td><span  id="cust_num" name="cust_num"  maxlength="20"  class="input_box">010-1234-5678</span></td>
                    <td><span  id="car_name" name="car_name"  maxlength='20'  class="input_box">싼타페</span></td>
					<td><span  id="cust_name" name="cust_name" maxlength='20'  class="input_box">심**</span></td>
					<td><span id="reason_code" name="reason_code"  maxlength='20'  class="input_box">연체중</span></td>
                    <td><span id="segment" name="segment"  maxlength='20'  class="input_box">26세미만</span></td>
                    <td><span id="hyundai" name="hyundai"  maxlength='20'  class="input_box">현대캐피탈</span></td>
                     <td>
                    <select name="state" id="state">
				<option value="문의" >문의</option>
				<option value="상담보류">상담보류</option>
				<option value="상담취소"> 상담취소</option>
				<option value="계약">계약</option>
				<option value="출고완료">출고완료</option>
				<option value="계약취소">계약취소</option>

			</select> 
                    
                    </td>
         
				</tr>
            
            
			
			

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
	if(frm.user_name.value == '' && frm.carno.value=='' && frm.memo.value == ''){
		alert('값을 입력해 주세요.');
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
