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
        
        var today = new Date();
        console.log(document.documentElement.clientWidth);
        var option = "width=device-width, " + 
        				"initial-scale="+ screen.width / 1500 + ", " +
        				"minimum-scale="+ screen.width / 2400 + ", " +
        				"maximum-scale=2.0, " + 
        				"user-scalable=yes ";
//        document.querySelector(".output").innerHTML = window.innerWidth + " " + screen.width;
		document.querySelector("#created-date").innerHTML = today.toLocaleDateString('ko-KR'); 
        //document.querySelector("meta[name=viewport]").setAttribute("content",	option);
    });

    var renderedImg = new Array;
    
    var contWidth = 190, // 너비(mm) (a4에 맞춤)
        padding = 10; //상하좌우 여백(mm)
    
    //이미지를 pdf로 만들기
    // 저장하고자 하는 엘리먼트의 class를 pdf_page로 설정해야 한다.
    function createPdf() {
	    
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
	        doc.save('resultReport.pdf'); //pdf 저장
	    
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

	body {
		margin: 0;
		padding: 0;
		font-size: 16px;
		font-family:"HY궁서", "HY바다M", "NanumGothic", "Nanum Gothic","Malgun Gothic",sans-serif;
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
		--height: 100vh;
		--border-bottom: 10px solid #555555;
	}
	
	table {
		border-collapse: collapse;
	}

	header {
		display: flex;
		justify-content: space-between;
		border-bottom: 10px solid #555555;
		margin: 0px 0px 50px 0px;
	}
	
	header img {
		width: 200px;
		margin: 0 20px;
		object-fit: scale-down;
		align-self: center;
	}
	
	header table {
		margin: 0 20px;
	}
	
	header td {
		padding: 5px;
	}
	
	header tr:not(:last-child) td {
		border-bottom: 1px solid #dddddd;
	}
	
	.content {
		margin: 100px 0px;
		padding: 20px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	    align-items: stretch;
	}
	
 	.detail {
 		flex: 0 1 48%;
 	}
 	
	.detail .title {
		padding: 20px ;
		font-weight: 900;
		font-size: 1.5rem;
	}
	
	.detail table {
		border-top: 8px solid #883322;
		border-bottom: 8px solid #883322;
	}
	
	.detail td {
		padding: 10px 20px;
	}
	
	.detail table td:nth-child(1) {
		width: 15%;
		font-family: "NanumGothic";
		text-align: center;
		border-right: 1px solid #000;
	}
	
	.detail table td:nth-child(2) {
		width: 35%;
	}

	.detail img {
		width: 200px;
	}
	
	.ta-center {
		text-align: center;
	}
	
	.ta-right {
		text-align: right;
	}
	
	.detail tr:not(:last-child) td {
		border-bottom: 1px solid #bbbbbb;
	}

	.common-item {
		margin: 0px 0px;
		background: #ffe;
		border-top: 4px solid #882222;
		border-bottom: 4px solid #882222;
	}
	
	.common-item table {
		width: 100%;
	}
	
	.common-item table tr:not(:last-child) td {
		border-bottom: 1px solid #aaaaaa;
	}
	
	.memo-box {
		padding: 40px;
		--background: #89a;
	}
	textarea {
		--display: block;
		--margin: 50px auto;
		width: 100%;
		--padding: 5%;
		height: 100px;
		resize: none;
		
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
		 	<header>
				<img src="${RPATH}/images/logo.png" alt="회사로고" />
		 		
		 		<table>
		 			<tr>
<%-- 		 				<td rowspan=3><img src="${RPATH}/images/logo.png" alt="" /></td> --%>
		 				<td>견적번호</td>
		 				<td>xxxxxxxx</td>
		 			</tr>
					<tr>	 			
		 				<td>작성일</td>
		 				<td id="created-date">2000-01-01</td>
		 			</tr>
		 			<tr>
		 				<td>상담문의</td>
		 				<td>000-0000-0000</td>
		 			</tr>
		 		</table>
		 	</header>
		</div>
		
		<div class="pdf_page content">		

					<div class="detail">
						<div class="title" >상세견적 내용</div>
						<table>
							<tr>
								<td>♦◆◉모  델</td>
								<td id="model-name">모델명</td>
							</tr>
							
							<tr>
								<td>옵션</td>
								<td>옵션1<br>옵션2<br>옵션3<br>
									옵션4<br>옵션5<br>옵션6<br>
									옵션7<br>옵션8<br>옵션7<br>
									옵션10<br>옵션11<br>옵션12<br>
									옵션13<br>옵션14<br>옵션15<br>
									옵션16<br>옵션17<br>옵션18<br>
								</td>
							</tr>
							<tr>
								<td>색상</td>
								<td class="ta-center">화이트</td>
							</tr>
							<tr>
								<td>차량가격</td>
								<td class="ta-right">0원</td>
							</tr>
							<tr>
								<td>옵션가격</td>
								<td class="ta-right">0원</td>
							</tr>
							<tr>
								<td>총가격</td>
								<td class="ta-right">0원</td>
							</tr>
							<tr>
								<td>계약기간</td>
								<td class="ta-right">24개월</td>
							</tr>
							<tr>
								<td>주행거리</td>
								<td class="ta-right">3만Km</td>
							</tr>
						</table>
					</div>
					<div class="detail">
						<img src="${RPATH}/images/car/G80.png" alt="" />
						<div class="brief">
	
							보증금
							월렌트료
						</div>
					</div>
		</div>
		
		<div class="pdf_page common-item">	
	
				<table>
					<tr>
						<td>자동차 보험</td>
						<td></td>
						<td>운전자 범위</td>
						<td></td>
					</tr>
	
					<tr>
						<td>자차면책금</td>
						<td></td>
						<td>운전자 연령</td>
						<td></td>
					</tr>
	
					<tr>
						<td>만기처리</td>
						<td>인수/반납 선택가능</td>
						<td>만기인수가</td>
						<td></td>
					</tr>
					
					<tr>
						<td>정비</td>
						<td></td>
						<td></td>
						<td>자동차세 포함</td>
					</tr>
	
				</table>

		</div> <!-- end of pdf_page -->
		
		<div class="pdf_page">
			<div class="memo-box">
				<p>메모</p>
				<textarea placeholder="내용을 작성해 주세요"></textarea>
			</div>
		</div>
		
	</div>

<button id="savePdf">PDF 저장</button>
</body>
</html>