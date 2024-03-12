<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${RPATH}/css/admin-estimatelist.css" />


<style>



body {
	
	min-width: 1300px !important;
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
    height: 30px;
    margin-right: 0px;
    border: 1px solid #e8e8e8;
}


</style>





<script>

function sendSmsFrom2(frm) {
	
if(frm.user_name.value == '' || frm.bank_account.value == '' ) {
	alert('값을 입력해 주세요.');
	return false;
}

var title = "하모니렌트카 전자계약 안내문자";	// Lms문자 전송시 문자 타이틀 값 전송
var message =  " " +frm.user_name.value + "고객님께서 요청하신"+ "\n" + "하모니렌트카 전자계약을 위해 아래의 URL로 접속하여 주십시요."  + "\n" + "\n"  + "온라인전자서명 계약 바로가기 ->" + "\n" + "http://www.harmonybpm.com" +  "\n" + "\n" + "공증 작성 방법" +"\n" + "https://cafe.naver.com/cnsrent/1707" + "\n"  + "\n"+ "상담문의 1661-9763" +"\n"  + "\n" + "카톡문의 ->" +"\n"+ "harmonyrent.channel.io" + "\n"  + "\n"+ "홈페이지 바로가기 ->" + "\n" + "https://harmonyrentcar.com" ;

if(frm.carno.value.length > 10) {
	
	var smsSendAuth = {phoneNo: frm.carno.value,
			message: message,
			title: title,
		 	keyType:"MAIN_STATIC"
		 };
	
	$.ajax({
		type: "POST",
		url: baseUrl+"bbs/onlyLmsSendAjax",
		data    :JSON.stringify(smsSendAuth),
		async: false,
		//dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
				data.smsCode;
				data.keyValue;
				if(data.smsCode == "0000"){
					alert("비대면계약 링크 발송이 완료되었습니다.");
					return false;
				}else{
					alert("비대면계약 링크 발송이 실패하였습니다. ");
					return false;
				}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("문자 전송 실패.")
            return false;
		}
	});
}




}





function sendSmsFrom(frm) {
	
	if(frm.user_name.value == '' || frm.bank_account.value == '' ) {
		alert('값을 입력해 주세요.');
		return false;
	}
	var title = "하모니렌트카 전용계좌 안내문자";	
	//var message = " " +frm.user_name.value + "고객님"+ "\n" +"우리은행 전용계좌 : "+frm.bank_account.value+ "입니다." + "\n" + "\n" + "감사합니다. -하모니렌트카-";
	var message = " " +frm.user_name.value + "고객님"+ "\n" +"우리은행 전용계좌 : "+frm.bank_account.value+ "입니다." + "\n" + "\n" +"입금 후 담당자에게 입금내역을 캡쳐하여 보내주시거나 입금 확인전화 부탁드립니다."+ "\n"+"담당자번호:" + frm.charge.value + "\n" + "감사합니다. -하모니렌트카-";

	if(frm.carno.value.length > 10) {
		
		var smsSendAuth = {phoneNo: frm.carno.value,
				message: message,
				title: title,
			 	keyType:"MAIN_STATIC"
			 };
		
		$.ajax({
			type: "POST",
			url: baseUrl+"bbs/onlyLmsSendAjax",
			data    :JSON.stringify(smsSendAuth),
			async: false,
			//dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
					data.smsCode;
					data.keyValue;
					if(data.smsCode == "0000"){
						alert("전용계좌 발송이 완료되었습니다.");
						return false;
					}else{
						alert("전용계좌 발송이 실패하였습니다. ");
						return false;
					}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            alert("문자 전송 실패.")
	            return false;
			}
		});
	}
	if(frm.charge.value.length > 10) {
		
		var smsSendAuth = {phoneNo: frm.charge.value,
				message: message,
				title: title,
			 	keyType:"MAIN_STATIC"
			 };
		
		$.ajax({
			type: "POST",
			url: baseUrl+"bbs/onlyLmsSendAjax",
			data    :JSON.stringify(smsSendAuth),
			async: false,
			//dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
					data.smsCode;
					data.keyValue;
					if(data.smsCode == "0000"){
						alert("전용계좌 발송이 완료되었습니다.");
						return false;
					}else{
						alert("전용계좌 발송이 실패하였습니다. ");
						return false;
					}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            alert("문자 전송 실패.")
	            return false;
			}
		});
	}
	if(frm.ag.value.length > 10) {
		
		var smsSendAuth = {phoneNo: frm.ag.value,
				message: message,
				title: title,
			 	keyType:"MAIN_STATIC"
			 };
		
		$.ajax({
			type: "POST",
			url: baseUrl+"bbs/onlyLmsSendAjax",
			data    :JSON.stringify(smsSendAuth),
			async: false,
			//dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
					data.smsCode;
					data.keyValue;
					if(data.smsCode == "0000"){
						alert("전용계좌 발송이 완료되었습니다.");
						return false;
					}else{
						alert("전용계좌 발송이 실패하였습니다. ");
						return false;
					}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            alert("문자 전송 실패.")
	            return false;
			}
		});
	}
	
	
}

function validateForm(frm) {

	
			if(frm.user_name.value == '' && frm.carno.value=='' && frm.memo.value == ''){
				alert('값을 입력해 주세요.');
				return false;
			}
	
		
}


function inputPhoneNumber(obj) {

    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";
    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

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
	<span class="title_history">나의 신청 계좌</span>
	
	<div>
	<span>발급계좌 총 ${paging.totalCount} 개</span><br><br> &nbsp; <a href="bankAccountRecv"><input type="button" align="right" value="계좌신청하기"  style="float: left;"></a>

		<table id="list">

			<tr>
			<!--<th>은행</th>-->
			
			<th>고객명</th>
			<th>고객번호</th>
			<th>담당번호</th>
			<th>계좌번호</th>
			
			<th>에이전시번호</th>
			<th>메모</th>
            <!--<th>발급일시</th>-->
   			<!--<th>sms</th>
			<th>비대면</th>
            <th>저장</th>-->
			</tr>
			
			<c:forEach var="bankAccount" items="${BankAccountVO }">
			<form action="bankAccountUpdate" method="post" onSubmit="return validateForm(this)">
			<!-- <form method="post" id="frequestform" name="frequestform" onSubmit="return banksendSmsMsg(this)" action="#"> --> 
			<input type="hidden" name="account" value="${bankAccount.account }" >
			<tr>
			    <!--<td>${bankAccount.bank_name}</td>-->
				<!--<td>우리</td>-->
				<td><input  id="user_name" name="user_name" value="${bankAccount.user_name }" maxlength="10" class="input_box"><br><input type="submit" value="*저장*" class="input_box" style="width:30%;color:red;"><input type="button" onClick="return sendSmsFrom(this.form)" value="계좌발송"  style="width:30%;margin-right:3%;"><input type="button" onClick="return sendSmsFrom2(this.form)" value="링크발송"  style="width:30%">
				</td>
				<td><input  id="carno" name="carno" value="${bankAccount.carno }" maxlength="20"  class="input_box"></td>
				<c:if test="${not empty bankAccount.charge }">
				<td><input  id="charge" name="charge" value="${bankAccount.charge }" maxlength="20"  class="input_box"></td>
			</c:if>
			<c:if test="${empty bankAccount.charge }">
				<td><input  id="charge" name="charge" value="${userPhone }" maxlength="20"  class="input_box"></td>			
			</c:if>
				<td><input id="bank_account" name="bank_account" value="${bankAccount.account }" maxlength="20" class="input_box"></td>
				
				
		
				<td><input  id="ag" name="ag" value="${bankAccount.ag }" maxlength='20'  class="input_box"></td>
				<td><input name="memo" value="${bankAccount.memo }" maxlength='20'  class="input_box"></td>
                <!--<td>${bankAccount.recv_date }</td>-->
      <!-- <td><input type="button" onClick="return sendSmsFrom(this.form)" value="발송"  style="width:100%"></td>
         <td><input type="button" onClick="return sendSmsFrom2(this.form)" value="발송"  style="width:100%"></td>      
				
				<td><input type="submit" value="저장" class="input_box" style="width:100%"></td>-->
				
			</tr>
			</form>
		
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
