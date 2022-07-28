<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 공통변수 처리 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />


<meta name="title" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta name="description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta name="keywords" content="신차장기렌트,중고장기렌트, 24개월장기렌트,1년렌트, 자동차일시불, 자동차할부, 자동차구매,장기렌트보증금">
<meta property="og:site_name" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta property="og:type" content="wepsite">
<meta property="og:title" content="(주)하모니렌트카">
<meta property="og:description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta property="og:image" content="">
<meta property="og:url" content="harmonyrent.co.kr">


<title>하모니렌트카</title>
<link rel="stylesheet" href="/css/static.css" />
<link rel="stylesheet" href="/css/estimate.css" />

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>

/* body { */
/* 	margin: 0; */
/* 	padding: 0; */
/* 	font-size: 20px; */
/* 	--font-family: "Noto Sans KR", "NanumGothic", "Nanum Gothic", "Malgun Gothic", serif; */
/* 	font-family: "NanumGothic", "Malgun Gothic", Georgia, serif; */
/* 	background: #eeeeee; */
/* } */

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
	font-size: 20px;
	font-family: "Noto Sans KR", "Nanum Gothic", "Malgun Gothic", Georgia, serif;
	background: #eeeeee;
}

.pdf_page {
	-height: 100vh;
	-border-bottom: 10px solid #555555;
	width:1050px;
	margin:auto;
}

table {
	border-collapse: collapse;
	width:1050px; 
	margin:auto;	
}

.header {
	display: flex;
	justify-content: space-between;
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
	margin: 10px 0px; --기존100
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
	--background: #ffe;
	  border-top: 1px solid #9d9d9d;
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

.detail-header2 {
	color: #3a7;
	margin-top:10px;
}

.comment {
	color: #d33;
	margin-top:5px;
	margin-bottom:10px;
	--background: #ffffff;
}

.contact-info {
	color: #33c;
}

.add-info {
	padding: 10px;
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

#screen-box {
	display: flex;
	justify-content: center;
	align-items : right;
	flex-direction: column;
	--text-align: center;
}
/*
#btn-save {
	--display: block;
	--margin: 20px auto;
	width: 50%;
	height: 30px;
	background: #9cf;
	outline: none;
}
*/
.vat {
	vertical-align: top;
}

.flex-center {
	display: flex;
	justify-content: center;
	align-items : center;
	flex-direction: column;
	--text-align: center;
}

.add-info input {
	margin: 4px;
	padding: 10px 20px;
}


			div {
				overflow-x: auto;
              /*  width: 1050px; */
              /*  margin: auto; */
                /*text-align: center;*/
                /*border: 2px solid #f2f2f9;*/
			}
			table {
				width: 1050px;
				min-width: 500px;
                color:black;
                
			}
			td {
				padding: 20px;
				border:1px solid #e5e2da;
               
            }
            #subject {
            
            	padding: 20px;
				border:1px solid #e5e2da;
                background-color: #f2f2f9;
                text-align : center;
                font-weight : bold;
            }


body {
  text-align: center;
}
.modal_button {
  padding: 10px;
  font-size: 20px;
  background-color: #ccc;
  margin-top: 20px;
  color: red;
}

.estimeate_modal {
  max-width: 1100px;
  height: 90%;
  background-color: #fff;
  padding: 20px;
  overflow-y: auto;
}

.modal_wrap {
  position: fixed;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  width: 100%;
  height: 100%;
  display: none;
  justify-content: center;
  align-items: center;
  padding: 0 20px;
  z-index:10000;
}

.modal_wrap.on {
  display: flex;
}

.close_wrap {
  text-align: right;
}

.close_wrap img {
  cursor: pointer;
}

.modal_logo {
  width: 200px;
  height: 40px;
  margin-bottom: 20px;
}

.modal_logo img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.table_style .product strong {
  color: #f43e3f;
}
            
</style>

</head>
<body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script>

    window.addEventListener("load", function() {
    /*	
        var content_option = 	"width=device-width, " + 
								"initial-scale="+ screen.width / 1500 + ", " +
								"minimum-scale="+ screen.width / 2400 + ", " +
								"maximum-scale=2.0, " + 
								"user-scalable=yes ";
		document.querySelector("meta[name=viewport]").setAttribute("content", content_option);
	*/ 
		createPdf("하모니렌트카견적서");
	});
    var renderedImg = new Array;
    
    var contWidth = 190, // 너비(mm) (a4에 맞춤)
        padding = 10; //상하좌우 여백(mm)
    
    //이미지를 pdf로 만들기
    // 저장하고자 하는 엘리먼트의 class를 pdf_page로 설정해야 한다.
    function createPdf(filename) {

	
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
	        doc.save(filename + '.pdf'); //pdf 저장
	    
	        curHeight = padding; //y축 초기화
	        renderedImg = new Array; //이미지 배열 초기화
	    
	    });
//	    onCloseModal();
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


  <div class="pdf_page content_box">
   <div class="estimate_header">
      <div class="left_area">
      	<img src="${RPATH }/images/logo2.png" style="padding: 20px 0px;" alt="" />
        <h1 class="mobile_title">
          견 적 서
        </h1>
        <p>
          <strong>■ <input type="text" placeholder="홍길동" value="${estimate.user_name }" name="customer"> 고객</strong>
          <span>님 귀하</span>
        </p>
      </div>
        <h1 class="pc_title">
          견 적 서
        </h1>
        <div class="right_area">
          <ul>
            <li>
              <span class="title">견적번호</span>
              <span class="title_content">${estimate.type}${estimate.estimate_no}</span>
            </li>
            <li>
              <span class="title">견적일</span>
              <span class="title_content"><fmt:formatDate value="${estimate.regdate}" pattern="yyyy-MM-dd"/></span>
            </li>
            <li>
              <span class="title">견적유효기간</span>
              <span class="title_content">${expdate}</span>
            </li>
            <li>
              <span class="title">상담문의</span>
              <span class="title_content">${estimate.tel }</span>
            </li>
          </ul>
        </div>
      </div>

      <div class="estimate_content">
        <div class="img_wrap">
          <img src="${RPATH }/images/car/${car.image}" alt="">
          <span>※ 위 참고 이미지는 실제 판매모델과 다를 수 있습니다.</span>
        </div>
        <div class="right_area">
          <ul class="info_list">
            <li class="info_item">
              <p class="title">모델</p>
              <div class="content_harmony">
                <strong class="name">${car.maker} - ${car.model_name } - ${car.lineup } - ${car.trim_name }</strong>
                <span>(<fmt:formatNumber type="number" maxFractionDigits="3" value="${empty car.price ? 0 : car.price}" />)</span>
              </div>
            </li>
            <li class="info_item">
              <p class="title">색상</p>
              <div class="content_harmony">
                <span>${color.color_name }
							<c:if test="${not empty color.price and color.price != 0}"> 
								(+<fmt:formatNumber type="number" maxFractionDigits="3" value="${color.price}" />)
							</c:if></span>
              </div>
            </li>
            <li class="info_item">
              <p class="title">옵션</p>
              <ul class="content_harmony">
            <c:forEach items="${options }" var="option">
               <li class="ellipsis_two">${option.name } (${option.price })</li>
             </c:forEach>
                <li>
                  <strong>[합계]</strong>
                  <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.option_price}" /></span>
                </li>
              </ul>
            </li>
            <li class="info_item">
              <p class="title">탁송</p>
              <div class="content_harmony">
<c:choose>
	<c:when test="${estimate.tagsong eq ''}">
		<span>선택없음</span>
	</c:when>
	<c:otherwise>
		<span>${estimate.tagsong }</span>
	</c:otherwise>
</c:choose>
              </div>
            </li>
          </ul>
          <p class="total">
            <strong class="color"><fmt:formatNumber type="number" maxFractionDigits="3" value="${car.price + estimate.option_price + color.price}" /> 원</strong>
          </p>
        </div>
      </div>

      <div class="table">
        <div class="table_style table_header">
          <div>구분</div>
          <div class="product">상품</div>
          <div>만기처리</div>
          <div>약정거리</div>
          <div>자동차보험</div>
          <div>자동차세</div>
          <div>선납금</div>
          <div>보증금</div>
          <div>잔존가치</div>
          <div class="color">월납입금</div>
        </div>
        
        
        
        <c:if test="${fn:length(estimateList) == 1 }">
        <ul>
        </c:if>
        <c:if test="${fn:length(estimateList) == 2 }">
        <ul class="content_two">
        </c:if>
        <c:if test="${fn:length(estimateList) == 3 }">
        <ul class="content_three">
        </c:if>
        <c:if test="${fn:length(estimateList) == 4 }">
        <ul class="content_four">
        </c:if>
        
        <c:forEach var="estimate" items="${estimateList }">
          <li class="table_style table_body">
            <div>
              <strong class="ellipsis">장기렌트 (${estimate.period }개월, 개인)</strong>
            </div>
            <div class="product">
              <strong>
              <c:if test="${fn:indexOf(estimate.type,'H') >= 0 }">하이렌트</c:if>
              <c:if test="${fn:indexOf(estimate.type,'M') >= 0 }">마이다스렌트</c:if>
              <c:if test="${fn:indexOf(estimate.type,'N') >= 0 }">무심사</c:if>
              <c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">오너형렌트</c:if>
              </strong>
            </div>
            <div>
            <c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
              <span class="ellipsis">인수형</span>
            </c:if>
            <c:if test="${fn:indexOf(estimate.type,'O') < 0 }">
              <span class="ellipsis">반납/인수 선택형</span>
            </c:if>            
            </div>
            <div>
            <c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
              <span class="ellipsis"> 없음 </span>
            </c:if>
            <c:if test="${fn:indexOf(estimate.type,'O') < 0 }">
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.distance / 10000}" />만km/년</span>
            </c:if>            
            </div>
            <div>
            <c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
              <span class="ellipsis">포함(만 26세 이상, 대물 2억원) </span>
            </c:if>
            <c:if test="${fn:indexOf(estimate.type,'O') < 0 }">
              <span class="ellipsis">포함(만 26세 이상, 대물 1억원) </span>
            </c:if>            

            </div>
            <div>
              <span class="ellipsis">납입금에 포함됨</span>
            </div>
            <c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
            <div class="between">
              <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit_ratio *100}" />%</span>
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit / 10000}" /> 만원</span>
            </div>
            <div class="right">
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.prepayment}" /> 만원</span>
            </div>
            </c:if>
            <c:if test="${fn:indexOf(estimate.type,'O') < 0 }">
            <div class="right">
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.prepayment}" /> 만원</span>
            </div>
            <div class="between">
              <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit_ratio *100}" />%</span>
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.deposit / 10000}" /> 만원</span>
            </div>
            </c:if>                     

            <div class="between">
              <!--  span>
				<c:if test="${fn:indexOf(estimate.type,'H') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 36}">
							<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 48}">
							<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>%
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'N') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 36}">
							<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 48}">
							<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>%
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'M') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							<fmt:formatNumber type="number" value="${(car.janga24+0.04)*100 }"  pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 36}">
							<fmt:formatNumber type="number" value="${(car.janga36+0.04)*100 }"  pattern="#.##"/>%
						</c:when>
						<c:when test="${estimate.period == 48}">
							<fmt:formatNumber type="number" value="${(car.janga48+0.04)*100 }"  pattern="#.##"/>%
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
							(0%)
				</c:if>              
			  </span -->
			  <span>
			  	<c:choose>
			  		<c:when test="${fn:indexOf(estimate.type,'O') >= 0 }">
			  		0%
			  		</c:when>
			  		<c:otherwise>
			  			<fmt:formatNumber type="number" maxFractionDigits="0" value="${estimate.acquisition/cal_price*100 }" />%
			  		</c:otherwise>
			  	</c:choose>
			  </span>
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.acquisition ? 0 : estimate.acquisition/10000 }" />만원</span>
            </div>
            <div class="color between">
              <span>vat 포함</span>
              <strong class="color ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.rentfee}" /> 원</strong>
            </div>
          </li>
        </c:forEach>
        </ul>
      </div>

    <p class="notice2">
       공통사항<br />
      자동차 보험) 대물 - 1사고당 1억, 대인 - 배상(책임) 배상ll(무한), 자기신체사고 - 1인당 최고 1억원, 자차손해 - 면책제도 적용<br />
      자차 면책금) 무심사렌트 - 50만원 ~ 200만원, 기타렌트 30 ~ 100만원 (면책금 자차 수리비의 30%)  <br />
    <br>
      필요서류 <br /> 개인 - 운전면허증, 주민등록등본, 인감증명서, 인감도장 (공통) <br />
      무심사 - 주민등록초본, 인감증명서, 가족관계증명서, 인감도장, 운전경력 증명서, 공증위임장, 재직증명 or 소득증빙서류 <br />
      법인 - 사업자등록증 사본, 법인등기부 등본, 법인 인감증명서, 재무제표(최근2년), 주주명부, 대표이사  개인인감, 개인등본, 신분증 사본
    </p>

    <p class="warning">
      ※ 본 견적서는 참고용이며 계약시 최종 확정된 조건을 반영하여 다시 작성 후 계약에 반영합니다.
    </p>

</div>
 
 		<div class="pdf_page">
			<table>
            
            	<tr>
					<td id="subject" style = "background-color: ##f2f2f9;text-align:center">상품명</td>
					<td style = "font-weight : bold; text-align:center; background-color: #f2f2f9;">상품설명</td>
					
				</tr>
            
				<tr>
					<td id="subject" style="background-color: ##f2f2f9;">무심사렌트</td>
					<td>신용관리에 신경쓰지 못하셨거나, 신용을 회복중인 분들, 안정적으로 소득이 있지만 <br>
                  		  4대보험 증명이 안된다는 이유로 렌트가 어려우신 분들을 위하여 개발한 상품입니다. <br>
							<br>추천고객 : 프리랜서, 개인회생자, 신용불량자, 일용직 근로자, 
                	 		신용등급 8등급 이하 사업자 혹은 개인</td>
							
				</tr>
				<tr>
					<td id="subject" style="background-color: ##f2f2f9;">하이렌트</td>
					<td>일반적으로 분류되는 우수신용 / 중간신용 / 저신용의 기준이 아닌 자사만의 기준으로 <br> 
                    7등급 이상의 고객이라면 우수신용으로 적용하여, 보다 저렴한 렌트료로 이용할 수 있도록 
                    <br>개발한 상품입니다. 계약기간도 24, 36, 48 개월 다양하게 나누어져 있어 기존 계약기간이
					<br>길다고 생각되어 부담스러우셨던 분들에게도 추천드리는 상품입니다. <br>
						<br>추천고객 : 저신용으로 분류되는 7등급이상 고객, 
               			짧은 약정을 원하는 고객</td>
			
				</tr>
                
                <tr>
					<td id="subject" style="background-color: ##f2f2f9;">마이다스렌트</td>
					<td>계약기간이 끝나면 그대로 돌려받는 보증금을 50%로 설정하고 국내 최저가로 <br>
						이용할 수 있는 상품입니다. 초기비용에 대한 부담이 없는 분들은 이 상품을 이용하여 
<br>매월 납입금을 줄일 수 있습니다. <br><br>

추천고객 : 자금에 여유가 있고 세금, 유지비용, 보험료 등의 이유로 
               차량구매보다는 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               렌트를 선호하시는 고객</td>
			
				</tr>
                
                <tr>
					<td id="subject" style="background-color: ##f2f2f9;">오너형렌트</td>
					<td>초기비용(차량가의 70%, 80%, 100%)을 납입하고 계약기간 후 
고객님의 명의로 이전하도록 <br>개발한 인수형 상품입니다. 차량가의 100%를 납입하게되면 취등록세 6~7%만 추가 납입 후 <br> 월 납입금 없이 차량을 이용하시다가 계약기간 이후 고객님의 명의로 이전. (이전비용 회사 부담) <br>
계약기간 36, 48개월로 분류되어 있으며 고객님의 명의로 이전되는만큼
약정km 제한이 없고, <br> 이용기간동안 세금, 보험료도 부과되지 않습니다.<br><br>

추천고객: 국내에서 차량을 가장 저렴하게 구매하고 싶은 고객<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              구매와 렌트의 장점을 모두 누리고 싶은 고객 </td>
				</tr>
			</table>
			<img src="${RPATH }/images/owner.jpg" alt="" />			
		</div>
</body>
</html>
