<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 공통변수 처리 -->
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RPATH" value="${CPATH}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<meta name="viewport" content="width=1050, initial-scale=1.0">
<title>견적서</title>

<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script>

    window.addEventListener("load", function() {
    	document.getElementById("savePdf").addEventListener("click", function() {
        //$("#savePdf").click(function() {
             setTimeout(function() {
              createPdf();
            }, 100);
        });

        var content_option = 	"width=device-width, " + 
								"initial-scale="+ screen.width / 1500 + ", " +
								"minimum-scale="+ screen.width / 2400 + ", " +
								"maximum-scale=2.0, " + 
								"user-scalable=yes ";
		document.querySelector("meta[name=viewport]").setAttribute("content", content_option);
	});

    var renderedImg = new Array;
    
    var contWidth = 190, // 너비(mm) (a4에 맞춤)
        padding = 10; //상하좌우 여백(mm)
    
    //이미지를 pdf로 만들기
    // 저장하고자 하는 엘리먼트의 class를 pdf_page로 설정해야 한다.
    function createPdf(filename) {
	    var saveBtn = document.getElementById("btn-save");
	    saveBtn.style.display = "none";
        	
	    var lists = document.querySelectorAll(".pdf_page"),
	        deferreds = [],
	        doc = new jsPDF("p", "mm", "a4"),
	        listsLeng = lists.length;
		var sx = window.scrollX,
        	sy = window.scrollY;
        window.scrollTo(0,0);
	    for (var i = 0; i < listsLeng; i++) { // pdf_page 적용된 태그 개수만큼 이미지 생성
	        var deferred = $.Deferred();
	        deferreds.push(deferred.promise());
	        generateCanvas(i, doc, deferred, lists[i]);
	    }
        window.scrollTo(sx, sy);
        saveBtn.style.display = "block";
	    $.when.apply($, deferreds).then(function () { // 이미지 렌더링이 끝난 후
	        var sorted = renderedImg.sort(function(a,b){return a.num < b.num ? -1 : 1;}), // 순서대로 정렬
	            curHeight = padding, //위 여백 (이미지가 들어가기 시작할 y축)
	            sortedLeng = sorted.length;
	    
	        for (var i = 0; i < sortedLeng; i++) {
		        var sortedHeight = sorted[i].height, //이미지 높이
		            sortedImage = sorted[i].image; //이미지
	    		console.log("INFO: " + curHeight + " " + sortedHeight);
		            
		        if( curHeight + sortedHeight > 297 - padding * 2 ) { // a4 높이에 맞게 남은 공간이 이미지높이보다 작을 경우 페이지 추가
		            doc.addPage(); // 페이지를 추가함
		            curHeight = padding; // 이미지가 들어갈 y축을 초기 여백값으로 초기화
		            doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
		            curHeight += sortedHeight; // y축 = 여백 + 새로 들어간 이미지 높이
		            curHeight += 10; // 여백을 주기 위해서
		        } else { // 페이지에 남은 공간보다 이미지가 작으면 페이지 추가하지 않음
		            doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
		            curHeight += sortedHeight; // y축 = 기존y축 + 새로들어간 이미지 높이
		            curHeight += 10; // 여백을 주기 위해서
		        }
	        }
	        doc.save(filename + '.pdf'); //pdf 저장
	    
	        curHeight = padding; //y축 초기화
	        renderedImg = new Array; //이미지 배열 초기화
	    
	    });
    }
    
    function generateCanvas(i, doc, deferred, curList) { //페이지를 이미지로 만들기
        var pdfWidth = $(curList).outerWidth() * 0.2645, //px -> mm로 변환
            pdfHeight = $(curList).outerHeight() * 0.2645,
            heightCalc = contWidth * pdfHeight / pdfWidth; //비율에 맞게 높이 조절

		html2canvas( curList ).then(function (canvas) {
            var img = canvas.toDataURL('image/jpeg', 1.0); //이미지 형식 지정
            renderedImg.push({num:i, image:img, height:heightCalc}); //renderedImg 배열에 이미지 데이터 저장(뒤죽박죽 방지)     
            deferred.resolve(); //결과 보내기
        });
        

    }

</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap');

@font-face {
	font-family: 'Noto Sans KR';
	font-style: normal;
	font-weight: 300;
	src: url(${RPATH}/fonts/NOTOSANSCJKKR-LIGHT.OTF) format('opentype');
}

/* @font-face { */
/* 	font-family: 'Noto Sans KR'; */
/* 	font-style: normal; */
/* 	font-weight: 400; */
/* 	src: url(/fonts/NotoSansKr/NotoSansKR-Regular.woff2) format('woff2'), */
/* 		url(/fonts/NotoSansKr/NotoSansKR-Regular.woff) format('woff'), */
/* 		url(${RPATH}/fonts/NOTOSANSCJKKR-REGULAR.OTF) format('opentype'); */
/* } */

@font-face {
	font-family: 'Noto Sans KR';
	font-style: normal;
	font-weight: 400;
	src: url(${RPATH}/fonts/NOTOSANSCJKKR-REGULAR.OTF) format('opentype');
}

@font-face {
	font-family: 'Noto Sans KR';
	font-style: normal;
	font-weight: 700;
	src: url(${RPATH}/fonts/NOTOSANSCJKKR-BOLD.OTF) format('opentype');
}

body {
	margin: 0;
	padding: 0;
	font-size: 20px;
	--font-family: "Noto Sans KR", "NanumGothic", "Nanum Gothic", "Malgun Gothic", serif;
	font-family: "NanumGothic", "Malgun Gothic", Georgia, serif;
	background: #eeeeee;
}

.unselectable {
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	-webkit-touch-callout: none;
}

.container {
	width: 1100px;
	padding: 50px;
	margin: 0px auto;
	background: #ffffff;
}

.pdf_page {
	-height: 100vh;
	-border-bottom: 10px solid #555555;
}

table {
	border-collapse: collapse;
}

.header {
	display: flex;
	justify-content: space-between;
	--border-bottom: 10px solid #555555;
	margin: 0px 0px 50px 0px;
}

.header img {
	width: 200px;
	margin: 0 20px;
	object-fit: scale-down;
	align-self: center;
}

.header table {
	margin: 0 20px;
}

.header td {
	padding: 5px;
}

.header tr:not(:last-child) td {
	--border-bottom: 1px solid #dddddd;
}

.header td:nth-child(1) {
	text-align: right;
}

.content {
	margin: 100px 0px;
	padding: 20px;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: stretch;
}

.detail:nth-child(1){
	flex: 0 1 58%;
}

.detail:nth-child(2){
	flex: 0 1 38%;
}


.select-title {
	padding: 20px;
	font-weight: 900;
	font-size: 1.8rem;
	border-bottom: 8px solid #883322;
	margin: 0 0 20px 0;
}

#select-item {
	width: 100%;
	--border-top: 8px solid #883322;
	--border-bottom: 8px solid #883322;
}

#select-item td {
	padding: 10px 20px;
}

.#select-item td:nth-child(1) {
	text-align: left;
	border-right: 1px solid #000;
}

#select-item td:nth-child(2) {
	--width: 35%;
}


.ta-center {
	text-align: center;
}

.ta-right {
	text-align: right;
}

#select-item tr:not(:last-child) td {
	border-bottom: 1px solid #bbbbbb;
}

.common-item {
	margin: 0px 0px;
	background: #ffe;
	--border-top: 4px solid #882222;
	--border-bottom: 4px solid #882222;
}

.common-item table {
	width: 100%;
}

.common-item table td {
	vertical-align: top;
	padding: 10px 4px;
}

.common-item table tr:not(:last-child) td {
	border-bottom: 1px solid #aaaaaa;
}

.memo-box {
	padding: 40px;
	-background: #89a;
}

textarea {
	width: 100%;
	height: 100px;
	resize: none;
}

.title-header {
	color: #a33;
}

.detail-header {
	color: #3a7;
}

.comment {
	color: #d33;
}

.contact-info {
	color: #33c;
}

#result {
	width: 90%;
	margin: 0 auto;
}
#result img {
	width: 100%;
}

#result td {
	padding: 6px 10px;
	font-size: 1.3rem;
}

#result td:nth-child(1) {
	font-weight: bold;
	color: #a33;
	text-align: right;
}

#result td:nth-child(2) {

}

#result tr:nth-child(1) td{
	text-align: center !important;
}

#savePdf {
	display: block;
	margin: 20px auto;
	width: 30%;
	height: 30px;
	background: #9cf;
}

#btn-save {
	display: block;
	margin: 20px auto;
	width: 50%;
	height: 30px;
	background: #9cf;
	outline: none;
}

</style>

<script>
	var model_name = function(name) {
		document.getElementById("model-name").innerHTML = name;
	}
</script>

</head>
<body class="unselectable" oncontextmenu='return false' onselectstart='return false' ondragstart="return false;" ondrop="return false;">

	<div class="output"></div>
	<div class="container">
		<div class="pdf_page">
		 	<!-- header -->
		 	<div class="header">
				<img src="${RPATH}/images/logo.png" alt="회사로고" />
		 		
		 		<table>
		 			<tr>
		 				<td>견적번호</td>
		 				<td id="estimate-no"></td>
		 			</tr>
					<tr>	 			
		 				<td>견적일</td>
		 				<td id="created-date">2000-01-01</td>
		 			</tr>
					<tr>	 			
		 				<td>견적유효기간</td>
		 				<td id="due-date">2000-01-01</td>
		 			</tr>
		 			<tr class="contact-info">
		 				<td>상담문의</td>
		 				<td>1661-9763</td>
		 			</tr>
		 		</table>
		 	</div>
		</div>
		
		<div class="pdf_page content">		

			<div class="detail">
				<div class="select-title" >상세견적 내용</div>
				<table id="select-item">
					<colgroup>
						<col width="30%">
					</colgroup>
					<tr>
						<td><span class="title-header">◆</span> 모델</td>
						<td id="model-name" class="ta-center">모델명</td>
					</tr>
					
					<tr>
						<td><span class="title-header">◆</span> 옵션</td>
						<td id="options" class="ta-right">
						</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 색상</td>
						<td id="color-name" class="ta-right">화이트</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 차량 가격</td>
						<td id="car-price" class="ta-right">0원</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 옵션 가격</td>
						<td id="option-price" class="ta-right">0원</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 총 가격</td>
						<td id="total-price" class="ta-right">0원</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 계약기간</td>
						<td id="period" class="ta-right">24개월</td>
					</tr>
					<tr>
						<td><span class="title-header">◆</span> 주행거리</td>
						<td id="distance" class="ta-right">3만Km</td>
					</tr>
				</table>
			</div>
			<div class="detail">
				
				<div class="brief">
					<table id="result">
						<tr>
							<td colspan="2">
								<img id="car-image" src="" alt="" />
							</td>
						</tr>
						<tr>
							<td>선납금</td>
							<td>0 만원</td>
						</tr>
						<tr>
							<td>보증금</td>
							<td id="deposit"></td>
						</tr>
						<tr>
							<td>월렌트료</td>
							<td id="rentfee"></td>
						</tr>
					</table>
					<button id="btn-save">이 견적으로 상담받기</button>
				</div>
				
				
			</div>
		</div>
		
		<div class="pdf_page common-item">	
	
				<table>
					<colgroup>
						<col width="20%"/>
						<col width="30%"/>
						<col width="20%"/>
						<col width="30%"/>
					</colgroup>
					<tr>
						<td><span class="detail-header">◉</span> 자동차 보험</td>
						<td>대물 - 1사고당 1억<br>대인 - 배상(책임) 배상II(무한)<br>자기신체사고 - 1인당 최고 1억원<br>
							자차손해 면책제도 가능
						</td>
						<td><span class="detail-header">◉</span> 운전자 범위</td>
						<td>개인 - 직계 가족 및 배우자<br>개인사업자 - 대표 직계 가족 및 직원<br>법인 - 대표 및 임직원</td>
					</tr>
	
					<tr>
						<td rowspan="2"><span class="detail-header">◉</span> 자차면책금</td>
						<td rowspan="2">30 ~ 100만원<br>(면책금 내 수리비의 30%)</td>
						<td><span class="detail-header">◉</span> 운전자 연령</td>
						<td>만 26세 이상</td>
					</tr>
	
					<tr>
						<td><span class="detail-header">◉</span> 정비</td>
						<td>자가정비</td>
					</tr>

					<tr>
						<td><span class="detail-header">◉</span> 만기처리</td>
						<td>인수/반납 선택가능</td>
						<td><span class="detail-header">◉</span> 만기인수가</td>
						<td id="acquisition"></td>
					</tr>
				</table>

		</div> <!-- end of pdf_page -->
		
		<div class="pdf_page">
			<p class="comment">※본 견적서는 참고용이며 계약시 최종 확정된 조건을 반영하여 다시 작성 후 계약에 반영합니다.</p>
<!-- 			<p>고객정보 ? 전화 번호, 이름</p> -->
<!-- 			<p>서비스 항목 : 블랙박스, ...</p> -->

		</div>
		
	</div>

<!-- 	<button id="savePdf">파일 저장</button> -->
	
<script>
window.addEventListener("load", function() {
    var today = new Date();
    
    car = opener.car;
    console.log(opener.userLevel);
    
//    document.querySelector(".output").innerHTML = window.innerWidth + " " + screen.width;
	document.querySelector("#created-date").innerHTML = today.toLocaleDateString('ko-KR'); 
	var due_date = new Date(today.setDate(today.getDate() + 14));
	document.querySelector("#due-date").innerHTML = due_date.toLocaleDateString('ko-KR'); 
    
    document.getElementById("model-name").innerHTML = car.maker + " "
										+ car.model + " "
										+ car.lineup + " " 
										+ car.trim;
	var optionStr = "";
	for(var i=0; i<car.options.length; i++) {
		if (car.options[i].state=="on") {
			if (optionStr != "") {
				optionStr += "<br>";
			}
			
			optionStr += car.options[i].name;
		}
	}
	document.getElementById("options").innerHTML = optionStr;
	
	if (car.color_price != 0) {
		document.getElementById("color-name").innerHTML = car.color_name + "(" 
										+ Number(car.color_price).toLocaleString('en') + " 원)";
	}
	else {
		document.getElementById("color-name").innerHTML = car.color_name;
	}
	document.getElementById("car-price").innerHTML = Number(car.trim_price).toLocaleString('en') + " 원";
	document.getElementById("option-price").innerHTML = Number(car.total_option_price).toLocaleString('en') + " 원";
	document.getElementById("total-price").innerHTML = Number(car.trim_price
										+ car.total_option_price
										+ car.color_price).toLocaleString('en') + " 원";
	
	document.getElementById("period").innerHTML = car.period + " 개월";
	document.getElementById("distance").innerHTML = Number(car.distance / 10000).toLocaleString('en') + "만 Km";
		
	document.getElementById("car-image").src = "${RPATH}/images/car/" + car.image;
	document.getElementById("deposit").innerHTML = Number(car.deposit / 10000).toLocaleString('en') + " 만원<br>(차량가의 " 
										+ car.deposit_ratio * 100
										+ "%)";
	document.getElementById("rentfee").innerHTML = Number(car.rentfee).toLocaleString('en') + " 원";
	document.getElementById("acquisition").innerHTML = Number(car.acquisition / 10000).toLocaleString('en') + " 만원";
});


window.onpageshow = function(event) {
	//console.log(event.persisted);
	// cache에서 로드된 경우에는 
    if (event.persisted) {
        document.location.reload();
        alert("reload");
    }
};

document.getElementById('btn-save').addEventListener('click', function () {
	
	let xhttp = new XMLHttpRequest();
	// XmlHttpRequest의 요청
	xhttp.onreadystatechange = (e)=>{
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		// 콘솔 출력
		//console.log(req);
		// 통신 상태가 완료가 되면.
		if(req.readyState === XMLHttpRequest.DONE) {
			// Http response 응답코드가 200(정상)이면
			if(req.status === 200) {
				
				console.log(req.responseText);	
			
				if(req.responseText === undefined) return;
				
				// json 타입이므로 object 형식으로 변환
				var data = JSON.parse(req.responseText);
				document.getElementById("estimate-no").innerHTML = data.estimate_type + data.estimate_no;
				
				if (data.estimate_type !== "?") {
					// save file
					setTimeout(function() {
						createPdf(data.estimate_type+data.estimate_no);
					}, 100);
	
					alert("파일저장합니다.\n\n[견적번호 " + data.estimate_type + data.estimate_no + "]");
				}
			}
		}
	}
	// http 요청 타입과 주소, 동기식 여부
	xhttp.open("POST", "${CPATH}/esti/save", true);
	// xml 형식을 받을 경우
	//xhttp.overrideMimeType('text/xml');
	
	car.user_id = "${userId}";

	//console.log(JSON.stringify(car));
	xhttp.setRequestHeader('Content-Type', 'application/json')
	// http 요청

	if ("${MEMBERS}".length == 0) {
		alert("처음부터 다시 시작해 주세요");
	}
	else if (("${MEMBERS}" != 0) && (car.user_id.length == 0)) {
		alert("NO USER ID. 다시 MEMBER = " + "${MEMBERS}");
	}
	else {
		//alert(car.user_id);
		xhttp.send(JSON.stringify(car));
	}
});

</script>
</body>
</html>