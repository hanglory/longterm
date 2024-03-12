<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.harmony.longterm.utils.SHA256Util" %>
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
	border-top: 0px solid #338;
	border-bottom: 0px solid #338;
}

tr:nth-child(even) {
	background-color: #eef;
}

th {
   color: #fff;
    background-color: #10479c;
    border: 2px solid#10479c;
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
label {
    display: inline-block;
}
label span {
    pointer-events: none;
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
<script>

function editView(frmName, formObj) {
	document.forms[frmName].memo.style.display ='block';
	var memoName = "memotext"+frmName;
	document.getElementById(memoName).style.display = 'none';
	document.forms[frmName].focus();
//	document.forms[frmName].memotext.style.display = 'none';
}

function editOut(frmName, formObj) {
	document.forms[frmName].memo.style.display ='none';
	var memoName = "memotext"+frmName;
	document.getElementById(memoName).style.display = 'block';
//	document.forms[frmName].memotext.style.display = 'block';
}

function actionUpdate(seqno, formObj, frmIdx) {
	/*if(formObj.status.value == "") {
		alert('진행내역 처리후 저장해 주세요.');
		return false;
	}*/
	if(seqno > 0) {
		var memoName = "memotext"+frmIdx;
		var sendParam = {cntrReqSts: formObj.status.value,
				viewYn:"Y",
				updUser:"하모니크",
				company:"HD",
				memo:formObj.memo.value,
				seqno: seqno,
				manager:formObj.manager.value
			 };
		$.ajax({
			type: "POST",
			url: baseUrl+"API/apiRecvDataUpdateAjax",
			data    :JSON.stringify(sendParam),
			async: false,
			//dataType: "json",          // ajax 통신으로 받는 타입
	        contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
					data.resultCode;
					if(data.resultCode == "0000"){
						alert("저장 완료 되었습니다.");
						document.getElementById(memoName).innerHTML = formObj.memo.value;
						return false;
					}else{
						alert("저장이 실패하였습니다. ");
						return false;
					}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            alert("저장 실패.")
	            return false;
			}
		});		
	}
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
	<span class="title_history2">현대캐피탈 DB정보</span>
	<form class="search-form" action="hyundaiCapital">
	<span>요청기간</span><input type="date" id="start" name="search-start" value="<%=request.getParameter("search-start")%>" style="width:120px"/>
	<span>~</span><input type="date" id="end" name="search-end" value="<%=request.getParameter("search-end")%>" style="width:120px" />
<!--<label>
 	<input type="checkbox" name="options" id="options" value="02"><span>신차리스</span>
</label> 	
	<input type="checkbox" name="options" id="options" value="03" checked><span>신차렌트</span>
	<input type="checkbox" name="options" id="options" value="04" ><span>중고론</span>
	<input type="checkbox" name="options" id="options" value="05" ><span>중고리스</span>-->

	<select name="type1" id="type1">
		<option value="offr_prdt_cd" <%=request.getParameter("type1") == null ? "selected" : request.getParameter("type1").equals("offr_prdt_cd") ? "selected" : "" %> >상품코드</option>
		<option value="cnsl_vhtp_nm" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("cnsl_vhtp_nm") ? "selected" : "" %> >상담차종</option>
		<option value="manager" <%=request.getParameter("type1")==null ? "" : request.getParameter("type1").equals("manager") ? "selected" : "" %> >담당자</option>
	</select>
	<input type="search" name="search1" id="search1" value="<%=request.getParameter("search1") == null ? "" : request.getParameter("search1")%>"/>
	<input type="submit" value="검색" />

    
</form>	
	<br><br>
    
	<div>
		<span style="font-size:18px;">고객정보 리스트</span> &nbsp; 
		
		<table style="all: none;user-select: initial;" id="list">

			<tr>
				<th width="100">동의일자<a href="javascript:sortOrder('desc','agm_agrm_dt');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','agm_agrm_dt');"><img src="/images/others/s_sort_bottom.gif"></a></th>
				<th width="100">상품코드<a href="javascript:sortOrder('desc','offr_prdt_cd');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','offr_prdt_cd');"><img src="/images/others/s_sort_bottom.gif"></a></th>
				<th width="80">사유코드<a href="javascript:sortOrder('desc','drot_rsn_cd');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','drot_rsn_cd');"><img src="/images/others/s_sort_bottom.gif"></a></th>
                <th width="80">고객세그먼트<a href="javascript:sortOrder('desc','cust_sgmn_cd');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','cust_sgmn_cd');"><img src="/images/others/s_sort_bottom.gif"></a></th>
				<th width="100">고객명</th>
				<th width="120">고객연락처</th>
				<th width="250">상담차종<a href="javascript:sortOrder('desc','cnsl_vhtp_nm');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','cnsl_vhtp_nm');"><img src="/images/others/s_sort_bottom.gif"></a></th>
				
                <th width="100">담당자</th>
                <th>진행내역</th>
                <th width="400">메모</th> 
                <th width="150">요청일시<a href="javascript:sortOrder('desc','reg_date');"><img src="/images/others/s_sort_top.gif"></a><a href="javascript:sortOrder('asc','reg_date');"><img src="/images/others/s_sort_bottom.gif"></a></th>
                <th width="50">저장</th>
			</tr>
			
			<c:forEach var="apiRecvDataVO" items="${ApiRecvDataVO }" varStatus="status">
			<tr>
			<c:set var="frmName" value="frm${status.index}" />
			<form action="#" name="${frmName}">
                <td>${apiRecvDataVO.agm_agrm_dt }</td>
                <td>${apiRecvDataVO.offr_prdt_cd }</td>
                <td>${apiRecvDataVO.drot_rsn_cd }</td>
				<td>${apiRecvDataVO.cust_sgmn_cd }</td>
                <td>${SHA256Util.decryptBase64HC(apiRecvDataVO.cust_nm) }</td>
				<td>${SHA256Util.decryptBase64HC(apiRecvDataVO.cust_ctif_cn) }</td>
                <td>${apiRecvDataVO.cnsl_vhtp_nm }</td>
                <td>
                	<select name="manager" id="manager" style="width:100%">
						<option value=""></option>
						<option value="장종의" <c:if test="${apiRecvDataVO.manager eq '장종의'}">selected</c:if>>장종의</option>
						<option value="백광현" <c:if test="${apiRecvDataVO.manager eq '백광현'}">selected</c:if>>백광현</option>
						<option value="조복경" <c:if test="${apiRecvDataVO.manager eq '조복경'}">selected</c:if>>조복경</option>
						<option value="안점숙" <c:if test="${apiRecvDataVO.manager eq '안점숙'}">selected</c:if>>안점숙</option>
						<option value="이효정" <c:if test="${apiRecvDataVO.manager eq '이효정'}">selected</c:if>>이효정</option>
					</select> 
				</td>
                <td width="100">
                    <select name="status" id="status" style="width:100%">
                    <option value=""></option>
						<option value="H61005" <c:if test="${apiRecvDataVO.status eq 'H61005'}">selected</c:if>>부재중</option>
						<option value="H61004" <c:if test="${apiRecvDataVO.status eq 'H61004'}">selected</c:if>>상담중</option>
						<option value="H61001" <c:if test="${apiRecvDataVO.status eq 'H61001'}">selected</c:if>>상담완료</option>
						<option value="H61002" <c:if test="${apiRecvDataVO.status eq 'H61002'}">selected</c:if>>계약진행중</option>
						<option value="H61006" <c:if test="${apiRecvDataVO.status eq 'H61006'}">selected</c:if>>조건불일치</option>
						<option value="H61007" <c:if test="${apiRecvDataVO.status eq 'H61007'}">selected</c:if>>가능성 상</option>
						<option value="H61008" <c:if test="${apiRecvDataVO.status eq 'H61008'}">selected</c:if>>가능성 중</option>
						<option value="H61009" <c:if test="${apiRecvDataVO.status eq 'H61009'}">selected</c:if>>가능성 하</option>
						<option value="H61010" <c:if test="${apiRecvDataVO.status eq 'H61010'}">selected</c:if>>계약완료</option>
						<option value="H61011" <c:if test="${apiRecvDataVO.status eq 'H61011'}">selected</c:if>>출고완료</option>
						<option value="H61003" <c:if test="${apiRecvDataVO.status eq 'H61003'}">selected</c:if>>상품품절</option>
					</select> 
                </td>
                <td onClick="editView('${status.index+1}',this.form)"><textarea name="memo"  id="memo" style="width:100%; border:0;display:none;" onFocusOut="editOut('${status.index+1}',this.form)">${apiRecvDataVO.memo }</textarea><span name="memotext" id="memotext${status.index+1}" style="display:block">${apiRecvDataVO.memo }</span></td>
               
                <td>${apiRecvDataVO.reg_date }</td>
                <td><input type="button" value="저장" style="width:100%;" onClick="actionUpdate('${apiRecvDataVO.seqno }',this.form,'${status.index+1}')"  style="cursor:pointer;"></td>
                
    			</form>
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

var order = "desc";
var field = "seqno";
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
//	var type2Sel = document.getElementById("type2");

	location.href = "./hyundaiCapital?"
			+ "type1="+ type1Sel[type1Sel.selectedIndex].value
			+ "&search1=" + document.getElementById("search1").value.trim()
//			+ "&type2="+ type2Sel[type2Sel.selectedIndex].value
//			+ "&search2=" + document.getElementById("search2").value.trim()
			+ "&search-start=" + document.getElementById("start").value
			+ "&search-end=" + document.getElementById("end").value
			+ "&orderby=" + order
			+ "&orderfield=" + field
			+ "&page=" + page;
}

var sortOrder = function(ascDesc, selField) {
	order = ascDesc;
	field = selField;
	var type1Sel = document.getElementById("type1");
//	var type2Sel = document.getElementById("type2");

	location.href = "./hyundaiCapital?"
			+ "type1="+ type1Sel[type1Sel.selectedIndex].value
			+ "&search1=" + document.getElementById("search1").value.trim()
//			+ "&type2="+ type2Sel[type2Sel.selectedIndex].value
//			+ "&search2=" + document.getElementById("search2").value.trim()
			+ "&search-start=" + document.getElementById("start").value
			+ "&search-end=" + document.getElementById("end").value
			+ "&orderby=" + order
			+ "&orderfield=" + field
			+ "&page=1";
}

/*
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


window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
