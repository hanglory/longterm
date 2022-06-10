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
	width: calc(100% - 40px);
	position: relative;
	margin: 20px auto;
}

input[type=text], input[type=date], input[type=submit] {
	height: 2em;
	width: 200px;
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
	padding: 4px;
	font-size: 1.2em;
	font-weight: bold;

}

.paginate a {
	text-decoration: none ;
}


.sel-item td {
	color: #ffffff;
	background-color: #8030a0;
}


.disable-dbl-tap-zoom {
	touch-action: manipulation;
}

</style>

<style>
.esti-box {
	margin: 4px;
	padding: 4px;
	border: 1px solid #ccc;
	--background-color: #4ef0fe;
	border-radius: 10px;
}

.esti-no {
	font-weight: bold;
}
</style>

<div class="main">
		<table id="list" class="disable-dbl-tap-zoom">
<c:forEach var="estimate" items="${estimates }">
	<tr data-e_id=${estimate.id } data-t_id=${estimate.trim_id } align="left">
		<td style="text-align: left;" align="left">
		<b>${estimate.type}${estimate.estimate_no}</b><br/>
		${estimate.maker} - ${estimate.name} - ${estimate.lineup} - ${estimate.trim_name}
		</td>
	</tr>
</c:forEach>
	</table>
</div>	
	
		
<div class="optionBox" style="display:none;">
	<h1>견적 상세</h1>
	<div style="text-align:right">
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
	var no = document.getElementById("estimate_no").value;
	
	location.href = "./estimatelist?estimate_no="+ no + "&page=" + page;
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
