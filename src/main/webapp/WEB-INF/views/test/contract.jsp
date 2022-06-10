<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <title>하모니렌트카</title>
    
    <style type="text/css">
        *{
            margin:0;
            padding:0;
        }
        
        .cont {
            font-size: 30px;
            font-weight: bold;
            line-height: 530px;
            text-align: center;
        }
        .cont1 { background-color: #F29B76; }
        .cont2 { background-color: #EA68A2; }
        .cont3 { background-color: #32B16C; }
        .cont4 { background-color: #556FB5; } 
        .nav {
            overflow: hidden;
            overflow-y: scroll;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 200;
            width: 200px;
            height: 100%;
            border: 2px solid #000;
            background: #fff;
        }
        .nav .menu {
            display: block;
            height: 70px;
            margin-top: 20px;
            background-color: #EA68A2;
        }
        button { 
            position:fixed;
            top:0;
            right:0;
            z-index:100;
            width:100px;
            height:50px;
        }
        .bnt_open { right:110px; }
        
        /* 바디에 스크롤 막는 방법 */
        .not_scroll{
            position: fixed;
            overflow: hidden;
            width: 100%;
            height: 100%
        }
        .not_scroll .cont {
            position: relative;
            top: 0;
        }
        </style>   
</head>
<body>

    <button type="button" class="bnt_open">메뉴보기</button>
    <button type="button" class="bnt_close">메뉴닫기</button>
    <div style="display:none" class="nav">
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
        <a class="menu">menu1</a>
    </div>
    <div class="pdf_page cont cont1">content1</div>
    <div class="pdf_page cont cont2">content2</div>
    <div class="pdf_page cont cont3">content3</div>
    <div class="pdf_page cont cont4">content4</div>

    <button id="savePdf">저장</button>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>

    <script type = "text/javascript" src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type = "text/javascript" src = "https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<script>

    $(function() {
        $("#savePdf").click(function() {
            //$(".ad_i, .wrap_chart_btn").css("display", "none"); // 불필요한 태그 숨김
            //document.getElementById("loading").style.display = "block"; // 로딩 이미지 보이기
          //$("#loading").show(); jquery 사용할 경우
            //$("#main_frame", parent.document).parents("body").find("#loading").show(); // 부모 frame에 있는 loading 보이기
      
          // setTImeout을 하는 이유는 html2canvas를 불러오는게 너무 빨라서 앞의 js가 먹혀도 반영되지 않은 것처럼 보임
          // 따라서 0.1 초 지연 발생 시킴
            setTimeout(function() {
              createPdf();
            }, 100);
        });
    });

    var renderedImg = new Array;
    
    var contWidth = 190, // 너비(mm) (a4에 맞춤)
        padding = 10; //상하좌우 여백(mm)
    
    function createPdf() { //이미지를 pdf로 만들기
    //document.getElementById("loading").style.display = "block"; // 로딩 이미지 보이기
    
    var lists = document.querySelectorAll(".pdf_page"),
        deferreds = [],
        doc = new jsPDF("p", "mm", "a4"),
        listsLeng = lists.length;
    
    for (var i = 0; i < listsLeng; i++) { // pdf_page 적용된 태그 개수만큼 이미지 생성
        var deferred = $.Deferred();
        deferreds.push(deferred.promise());
        generateCanvas(i, doc, deferred, lists[i]);
    }
    
    $.when.apply($, deferreds).then(function () { // 이미지 렌더링이 끝난 후
        var sorted = renderedImg.sort(function(a,b){return a.num < b.num ? -1 : 1;}), // 순서대로 정렬
            curHeight = padding, //위 여백 (이미지가 들어가기 시작할 y축)
            sortedLeng = sorted.length;
    
        for (var i = 0; i < sortedLeng; i++) {
        var sortedHeight = sorted[i].height, //이미지 높이
            sortedImage = sorted[i].image; //이미지
    
        if( curHeight + sortedHeight > 297 - padding * 2 ){ // a4 높이에 맞게 남은 공간이 이미지높이보다 작을 경우 페이지 추가
            doc.addPage(); // 페이지를 추가함
            curHeight = padding; // 이미지가 들어갈 y축을 초기 여백값으로 초기화
            doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
            curHeight += sortedHeight; // y축 = 여백 + 새로 들어간 이미지 높이
        } else { // 페이지에 남은 공간보다 이미지가 작으면 페이지 추가하지 않음
            doc.addImage(sortedImage, 'jpeg', padding , curHeight, contWidth, sortedHeight); //이미지 넣기
            curHeight += sortedHeight; // y축 = 기존y축 + 새로들어간 이미지 높이
        }
        }
        doc.save('resultReport.pdf'); //pdf 저장
    
        curHeight = padding; //y축 초기화
        renderedImg = new Array; //이미지 배열 초기화
    
       // document.getElementById("loading").style.display = "none"; // 로딩 이미지 숨기기
        //$("#loading").hide(); jquery 사용할 경우
        //$("#main_frame", parent.document).parents("body").find("#loading").hide(); 부모 frame에 loading 태그가 있는 경우
        //$(".ad_i, .wrap_chart_btn").css("display", ""); 기존에 숨겼던 태그를 다시 보이게 하기
    });
    }
    
    function generateCanvas(i, doc, deferred, curList) { //페이지를 이미지로 만들기
        var pdfWidth = $(curList).outerWidth() * 0.2645, //px -> mm로 변환
            pdfHeight = $(curList).outerHeight() * 0.2645,
            heightCalc = contWidth * pdfHeight / pdfWidth; //비율에 맞게 높이 조절
		window.scrollTo(0,0); 
		console.log(curList);
        html2canvas( curList, {
	        	scrollX: 0,
	            scrollY: 0
        	}).then(function (canvas) {
	            var img = canvas.toDataURL('image/jpeg', 1.0); //이미지 형식 지정
	            renderedImg.push({num:i, image:img, height:heightCalc}); //renderedImg 배열에 이미지 데이터 저장(뒤죽박죽 방지)     
	            deferred.resolve(); //결과 보내기
        });
    }

</script>
</body>
</html>