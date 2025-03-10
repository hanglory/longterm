<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
    
  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/style_new.css">
  <style>
 body { color:#5e5c5c; } 
 /* 게시판 목록 */
#bo_list {position:relative}
#bo_list:after {display:block; visibility:hidden; clear:both; content:""}
.logo-img {
	width: 200px;
	height: 50%;
	--padding: 25% 0;
	--border-bottom: 1px solid #e7e7e7;
	text-align: center;
	padding: 10px 0;
	display: block;
	margin: 0 auto;
}
      
      footer{display:none;}
.likeTbl{width:100%; margin-bottom:20px; }
.likeTbl > ul{display:table; width:100%; }
.likeTbl > ul > li{display:table-row; width:100%; height:50px;}
.likeTbl > ul > li > div{display:table-cell; }
.likeTbl > ul > li.likeTblTh{background:#057590; }
.likeTbl > ul > li.likeTblTh > div{padding:15px 0;border-top:1px solid #d7e1e5; border-bottom:1px solid #d7e1e5;color:#FFFFFF; vertical-align:middle; text-align:center; }
.likeTbl > ul > li.likeTblTh > div a{color:#999;}
.likeTbl > ul > li.likeTblTd > div{padding:2px 2px; border-bottom:1px solid #d7e1e5;; vertical-align:middle; }
.likeTbl > ul > li:hover.likeTblTd{background:#191919; }
.likeTbl > ul > li.likeTblTd .td_subject a{-webkit-transition-duration: 0.2s; -webkit-transition-timing-function: ease; transition-duration: 0.2s; transition-timing-function: ease; }
.likeTbl > ul > li:hover.likeTblTd .td_subject a{padding-left:5px;}
.likeTbl > ul > li.likeTblTd .td_subject .bo_tit a{display:block; color:#999;}
.likeTbl > ul > li.likeTblTd .td_subject .bo_tit a em{font-style:normal; }
.likeTbl > ul > li:hover.likeTblTd .td_subject .bo_tit a em span,
.likeTbl > ul > li:hover.likeTblTd .td_subject .bo_tit a em i{color:#333 !important; }

.bo_notice,
.bo_notice > div {background:#f0f5f8 !important;}
.likeTbl > ul > li.bo_notice  .td_subject .bo_tit a{color:#ddd !important;}
.likeTbl .td_board {width:95px; text-align:center; overflow:hidden; white-space:nowrap;}
.likeTbl .td_zero2 {text-align:center; color:#002c9f;}     
.likeTbl .td_chk {width:80px; text-align:center}
.likeTbl .td_zero {text-align:center; color:#002c9f;}
.likeTbl .td_date {width:60px; text-align:center; font-style: italic; }
.likeTbl .td_datetime {width:60px; text-align:center; font-style: italic; color:#999; font-size:11px; font-family:verdana; }
.likeTbl .td_group {width:100px; text-align:center}
.likeTbl .td_mb_id {width:100px; text-align:center}
.likeTbl .td_mng {width:80px; text-align:center}
.likeTbl .td_name {width:90px; text-align:center; padding:10px 0}
.likeTbl .td_nick {width:100px; text-align:center}
.likeTbl .td_num {width:40px; ; text-align:center; color:#17010; font-size:15px; }
.likeTbl .td_num2 {width:90px; ; text-align:center; color:#999; font-size:11px; }
.likeTbl .td_numbig {width:80px; text-align:center}
.likeTbl .txt_active {color:#5d910b}
.likeTbl .txt_expired {color:#ccc}

.td_subject img {margin-left:5px}

/*.likeTbl .profile_img {display:inline-block; ; margin-right:2px}*/
.likeTbl .profile_img img{border-radius:50%}
.likeTbl .cnt_cmt{display:inline-block; background:#242424; color:#fff; font-size:11px; height:16px; line-height:16px; padding:0 5px; border-radius:3px; vertical-align:middle; }

.likeTbl .bo_tit .fa-download{width:16px; height:16px; line-height:16px; background:#ddd; color:#999; text-align:center; font-size:10px; border-radius:2px; margin-right:2px; vertical-align:middle; margin-right:2px}
.likeTbl .bo_tit .fa-link{width:16px; height:16px; line-height:16px; background:#ddd; color:#999; text-align:center; font-size:10px; border-radius:2px; margin-right:2px; vertical-align:middle; margin-right:2px; font-weight: normal; }
.likeTbl .bo_tit .new_icon{display:inline-block; width: 16px; line-height:16px ; font-size:0.833em; color:#999; background:#ddd; text-align:center; border-radius: 2px; vertical-align:middle; margin-right:2px}
.likeTbl .bo_tit .hot_icon{display:inline-block; width: 16px; line-height:16px ; font-size:0.833em; color:#999; background:#ddd; text-align:center; border-radius: 2px; ; vertical-align:middle; margin-right:2px; font-weight:normal}
.likeTbl .bo_tit .fa-lock{display: inline-block; line-height: 14px; width: 16px; font-size: 0.833em; color: #fff; background: #333; text-align: center; border-radius: 2px; font-size: 12px; border:1px solid #000}
.likeTbl .bo_tit a{font-size:14px; }

.onlyMvV{display:none; }
.likeTbl > ul > li > div.mvInlinev i{display:none; }

.qnaIco{display:inline-block; font-size:12px; margin-right:5px; border-radius:3px; background:#999; width:80px; height:24px; line-height:24px; color:#fff; text-align:center; }
.qnaIco1{background:#005f99;}
.qnaIco2{background:#057590}
.qnaIco3{background:rgba(255,255,255,0.4)}
.qnaIco i{display:inline-block !important; }


      
      
@media all and (max-width: 1200px)
{

	.likeTbl > ul{display:table; width:100%; }
	.likeTbl > ul > li{display:table-row; width:100%; height:20px;}
	.likeTbl > ul > li > div{display:table-cell; }
/*
	.likeTbl > ul{display:block !important; }
	.likeTbl > ul > li{display:block !important; overflow:hidden; border-bottom:1px solid #ddd; position:relative; }
	.likeTbl > ul > li > div{display:block; border-bottom:0px !important; padding:0px;  }
*/	
	.likeTbl > ul > li.likeTblTh{background:#057590; }
	.likeTbl > ul > li.likeTblTh > div{padding:15px 0;border-top:1px solid #d7e1e5; border-bottom:1px solid #d7e1e5;color:#FFFFFF; vertical-align:middle; text-align:center; }
	.likeTbl > ul > li.likeTblTd{padding:7px 15px 15px; text-align:left; }
	.likeTbl > ul > li.likeTblTd > div{padding:0px; border-bottom:0px; }

	.likeTbl > ul > li > div.mvInlineN{display:none; }
/*	.likeTbl > ul > li > div.mvInlinev {display:inline-block; width:auto !important; padding:0 5px; font-size:10px; } */
	.likeTbl > ul > li > div.mvInlinev {padding:0 2px; font-size:10px; }
	.likeTbl > ul > li > div.mvInlinev i{display:inline-block; margin-left:3px; }
	.likeTbl > ul > li > div.mvInlinev:before{content:""; color:#ddd; }
	.likeTbl > ul > li > div.mvInlinev.td_name:before{content:" "}
	.likeTbl > ul > li > div.mvInlinev.td_name{padding-left:2px; }
	.likeTbl > ul > li > div.mvInlinev.td_num2{padding-left:0px; margin-top:7px; margin-left:-8px; }
	.likeTbl > ul > li > div.td_subject{display:block; }
	.likeTbl > ul > li > div.td_subject a{padding:0 0 8px 0; }
	.likeTbl > ul > li > div.td_subject a.bo_cate_link{display:inline-block; padding-top:8px; }
/*	.likeTbl > ul > li > div.td_chk{position:absolute; right:0px; top:0px; } */

	.likeTbl > ul > li:hover.likeTblTd .td_subject a{padding-left:0px; }
	.likeTbl > ul > li.likeTblTd .td_subject .bo_tit a{padding-top:8px; }
	.onlyMvV{display:inline-block; margin-left:-5px; }
	.qnaIco{display:inline-block; font-size:10px; margin-right:5px; border-radius:3px; background:#999; width:60px; height:20px; line-height:20px; color:#fff; text-align:center; }
	.qnaIco1{background:#005f99;}
	.qnaIco2{background:#057590}
	
}

.fa-eye:before {
    content: "\f06e";
}
.fa-clock-o:before {
    content: "\f017";
}  
  </style>
  
<script>
var usedcar = {
		maker : "",
		trim_name : "",
		car_no:"",
		rentfee_min : "",
		rentfee_max : "",
		deposit : "",
		orderby : "",
		car_type : "신차",
		pageSize : 15,
		page : 1
	}
var isList = <%=request.getParameter("isList")%>;
if( isList)
	usedcar.pageSize = 200;
$(function(){

	$('#maker_ui').on('click','li',function() {
		$('#maker').removeClass('active');
		$('.active').removeClass('active');
		let selStr = $(this).data('maker');
		let htmlStr = "";
		usedcar.maker = selStr;
		usedcar.trim_name = "";
		usedcar.rentfee_min = "";
		usedcar.rentfee_max = "";
		usedcar.deposit = "";
		usedcar.orderby = "";
		$(this).addClass('active');
		displaySelect();
	});

	$('#rentfee_ul').on('click','li',function() {
		$('#lirentfee').removeClass('active');
		$('.active').removeClass('active');
		let selStr = $(this).data('lirentfee');
//		selStr = $(this).val('lirentfee');
		let htmlStr = "";
		usedcar.maker = "";
		usedcar.trim_name = "";
		if(selStr == "40"){ //50만원 미만
			usedcar.rentfee_min = "";
			usedcar.rentfee_max = "499999";
		}else if(selStr == "50"){ //50만원대
			usedcar.rentfee_min = "500000";
			usedcar.rentfee_max = "599999";			
		}else if(selStr == "60"){
			usedcar.rentfee_min = "600000";
			usedcar.rentfee_max = "699999";
		}else if(selStr == "70"){
			usedcar.rentfee_min = "700000";
			usedcar.rentfee_max = "";			
		}else{
			usedcar.rentfee_min = "";
			usedcar.rentfee_max = "";						
		}
		
		usedcar.deposit = "";
		usedcar.orderby = "";
		$(this).addClass('active');
		displaySelect();

	});
	$('#deposit_ul').on('click','li',function() {
		$('#deposit').removeClass('active');
		$('.active').removeClass('active');
		let selStr = $(this).data('deposit');
		let htmlStr = "";
		usedcar.maker = "";
		usedcar.trim_name = "";
		usedcar.rentfee_min = "";
		usedcar.rentfee_max = "";
		usedcar.deposit = selStr;
		usedcar.orderby = "";
		$(this).addClass('active');
		displaySelect();

	});
	$('#no_trim_search').click(function(){
		if( $('#no_trim').val() ==""){
			alert('차량번호나 이름을 입력해 주세요.');
			$('#no_trim').focus();
			return false;
		}
//		usedcar.maker = "";
		usedcar.trim_name = $('#no_trim').val();
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
//		usedcar.orderby = "";
		usedcar.car_no = $('#no_trim').val();
		displaySelect();

	});
    
        	$('#model_asc').click(function(){
		$('#model_desc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "SALES_BIZ_ITEM_NM";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});
	$('#model_desc').click(function(){
		$('#model_asc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "SALES_BIZ_ITEM_NM DESC";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});	
    
    
    
	
	$('#price_asc').click(function(){
		$('#price_desc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "trim_price";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});
	$('#price_desc').click(function(){
		$('#price_asc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "trim_price DESC";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});	
	$('#year_asc').click(function(){
		$('#year_desc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "vehicle_year";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});
	$('#year_desc').click(function(){
		$('#year_asc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "vehicle_year DESC";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});	
	$('#mile_asc').click(function(){
		$('#mile_desc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "distance";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});
	$('#mile_desc').click(function(){
		$('#mile_asc').removeClass('sort_active');
//		usedcar.maker = "";
//		usedcar.trim_name = "";
//		usedcar.rentfee_min = "";
//		usedcar.rentfee_max = "";
//		usedcar.deposit = "";
		usedcar.orderby = "distance DESC";
//		usedcar.car_no = $('#no_trim').val();
		$(this).addClass('sort_active');
		displaySelect();

	});
	
	$('#text_list_all').click(function(){
		if(isList ){
			usedcar.pageSize = 15;
			isList = 0;
		}
		else{
			usedcar.pageSize = 200;
			isList = 1;
		}		
/*		
		usedcar.maker = "";
		usedcar.trim_name = "";
		usedcar.rentfee_min = "";
		usedcar.rentfee_max = "";
		usedcar.deposit = "";
		usedcar.orderby = "";
*/		
		displaySelect();

	});
    
    
    
	initFunction();
    
    });
    
    function ListClick(){
    
    
   if(isList){
			usedcar.pageSize = 15;
			isList = 0;
		}
		else{
			usedcar.pageSize = 200;
			isList = 1;
		}
    
    displaySelect();
    
}  
    
    
    
	function displaySelect(){
		usedcar.page = 1;
		var dataURL = ""
		if(isList){
			dataURL = "/bpm/NewCarListAjax";
		}else{
			dataURL = "/bbs/usedcarAjax";
		}
		$.ajax({
			type: "POST",
			url: dataURL,
			//dataType: "json",
	        contentType: "application/json",
			data: JSON.stringify(usedcar),
			success: function(data) {
				if(isList){
					$('#text_list_all').html('<span class="qnaIco qnaIco2">펼쳐보기</span>');
					div_html_list(data);
				}
				else{
					$('#text_list_all').html('<span class="qnaIco qnaIco1">실시간현황</span>');
					div_html(data);
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            alert("실패.")
			}
		});
	}	
	function initFunction(){
		
		usedcar.maker = "";
		usedcar.trim_name = "";
		usedcar.rentfee_min = "";
		usedcar.rentfee_max = "";
		usedcar.deposit = "";
		usedcar.orderby = "";
		displaySelect();

	}	


function div_html(data){
	let htmlStr = "";
	var iconList;
	for(let i=0; i<data.length; i++) {
		
	 	if(i % 3 == 0)
	   		htmlStr += "<ul class='car_list thumbnail'>";
    	htmlStr += '<li class="car_item">';
        
        if(data[i].id == "1991"){
   
        htmlStr += '<a href="javascript:ListClick();"><img src="'+data[i].image+'" alt="">';}
              

     else {
        htmlStr += '<a href="usedcarDetail?car_id='+data[i].id+'"><img src="'+data[i].image+'" alt="">';}
        
        htmlStr += '<div class="car_content">';
        htmlStr += '  <div class="top_area">';
        htmlStr += '    <div class="left_area">';
        htmlStr += '      <h3>'+data[i].trim_name+'</h3>';
        htmlStr += '      <ul>';
        htmlStr += '        <li>';
        htmlStr += '          <span class="title">차량유종</span>';
        htmlStr += '          <span class="ellipsis">'+data[i].fuel+'</span>';
        htmlStr += '        </li>';
        htmlStr += '        <li>';
//	        htmlStr += '          <span class="title">차량등급</span>';
//	        htmlStr += '          <span class="ellipsis">라운지</span>';
        htmlStr += '        </li>';
        htmlStr += '        <li>';
        htmlStr += '          <span class="title">보증금</span>';
//      htmlStr += '          <span class="ellipsis">'+data[i].deposit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</span>';
        htmlStr += '          <span class="ellipsis">문의</span>';
        htmlStr += '        </li>';
        htmlStr += '      </ul>';
        htmlStr += '    </div>';
       	htmlStr += '    <div class="right_area">';
     	htmlStr += '       <strong class="red">선택항목</strong>';
        iconList = data[i].icon.split('|');
		for(var nCnt in iconList){
			if(iconList[nCnt] != "")
				htmlStr += '<strong class="orange">'+iconList[nCnt]+'</strong>'
		}
//     	htmlStr += '         <strong class="orange">'+data[i].icon+'</strong>';
     	htmlStr += '    </div>';
     	htmlStr += '  </div>';
     	htmlStr += '  <div class="bottom_area">';
     	htmlStr += '    <p class="rent">';
     	htmlStr += '      <span class="title">월렌트료(vat포함)</span>';
     	htmlStr += '      <span class="price">'+data[i].rentfee_1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</span>';
     	htmlStr += '    </p>';
     	htmlStr += '  </div>';
     	htmlStr += '</div></a>';
     	htmlStr += '</li>';
 		if(i % 3 == 2)
	   		htmlStr += "</ul>";
	}
	$('#carList').html("");
	$('#carList').html(htmlStr);
	if(data.length > 0){
		htmlStr = '<button onclick="javascript:goPage('+data[0].paging.prevPageNo+')" class="prev">◀</button>';
        for( i=data[0].paging.startPageNo; i <= data[0].paging.endPageNo; i++){
        	if(i == data[0].paging.pageNo){
        		htmlStr += '<button onclick="javascript:goPage('+i+')" style="background-color: yellow;">'+i+'</button>';
        	}else{
        		htmlStr += '<button onClick="javascript:goPage('+i+')">'+i+'</button>';
        	}
        }
		htmlStr +='<button onclick="javascript:goPage('+data[0].paging.nextPageNo+')" class="next">▶</button>';
	}	
		$('#page_box').html("");
		$('#page_box').html(htmlStr);
	
}
    
var htmlOpt =[];
var htmlcolor =[];
    
function div_html_list(data){
	let htmlStr = "";
	var iconList;

	htmlStr += '<div class="likeTbl">';
	htmlStr += '  <ul>';
	htmlStr += '    <li class="likeTblTr likeTblTh">';
	htmlStr += '   	 <div class="mvInlineN td_zero">번호</div>';
	htmlStr += '   	 <div class="mvInlineN td_num">차량번호</div>';
	htmlStr += '   	 <div class="mvInlinev td_board">모델명</div>';
    htmlStr += '   	 <div class="mvInlinev td_board">색상</div>';
	htmlStr += '   	 <div class="mvInlinev td_chk">연료</div>';
	htmlStr += '  	 <div class="mvInlineN td_num">연식</div>';
	htmlStr += '   	 <div class="mvInlineN td_num">신차가격</div>';
	htmlStr += '     <div class="mvInlineN td_zero">약정기간</div>';
	htmlStr += '     <div class="mvInlinev td_zero">보증금</div>';
	htmlStr += '     <div class="mvInlinev td_zero">렌트료</div>';
    htmlStr += '   	 <div class="mvInlinev td_zero2">옵션</div>';
	htmlStr += '    </li>';
	
	for(let i=0; i<data.length; i++) {
        
		if(!isEmpty(data[i].CAR_OPT_CD) ) {
	        htmlOpt.push(data[i].CAR_OPT_CD);
	        htmlOpt[i] = htmlOpt[i].replace(/OPT001/g,'하이패스').replace(/OPT002/g,'전동시트').replace(/OPT003/g,'내비+후방카메라').replace(/OPT004/g,'썬루프').replace(/OPT005/g,'버튼시동&스마트키').replace(/OPT006/g,'열선시트').replace(/OPT007/g,'통풍시트').replace(/OPT008/g,'크루즈컨트롤').replace(/OPT009/g,'열선핸들').replace(/OPT010/g,'전방감지센서').replace(/OPT011/g,'차선이탈방지').replace(/OPT012/g,'디스플레이+후방카메라').replace(/OPT013/g,'후측방충돌방지').replace(/OPT014/g,'무선충전').replace(/OPT015/g,'가죽시트').replace(/OPT016/g,'스마트크루즈컨트롤').replace(/OPT017/g,'전자식변속다이얼').replace(/OPT018/g,'블루링크/커넥터');
		}
       htmlcolor.push(data[i].CAR_COLOR);
        
//        htmlOpt[i] = htmlOpt[i].replace(/OPT001/g,'하이패스').replace(/OPT002/g,'전동시트').replace(/OPT003/g,'내비+후방카메라').replace(/OPT004/g,'썬루프').replace(/OPT005/g,'버튼시동&스마트키').replace(/OPT006/g,'열선시트').replace(/OPT007/g,'통풍시트').replace(/OPT008/g,'크루즈컨트롤').replace(/OPT009/g,'열선핸들').replace(/OPT010/g,'전방감지센서').replace(/OPT011/g,'차선이탈방지').replace(/OPT012/g,'디스플레이+후방카메라').replace(/OPT013/g,'후측방충돌방지').replace(/OPT014/g,'무선충전').replace(/OPT015/g,'가죽시트').replace(/OPT016/g,'스마트크루즈컨트롤').replace(/OPT017/g,'전자식변속다이얼').replace(/OPT018/g,'블루링크/커넥터');

    	htmlStr += '<li class="bo_notice likeTblTr likeTblTd">';
		htmlStr += '  <div class="mvInlineN td_zero">'+(i+1)+'</div>';
        htmlStr += '  <div class="mvInlineN td_num">'+Right(data[i].CAR_NO,4)+'</div>';
        htmlStr += '  <div class="mvInlinev td_board">'+data[i].SALES_BIZ_ITEM_NM+'</div>';
        htmlStr += '  <div class="mvInlinev td_zero2"><button onclick="btn2('+i+')">보기</button></div>';
        htmlStr += '  <div class="mvInlinev td_chk">'+data[i].FUEL_NM+'</div>';
        htmlStr += '  <div class="mvInlineN td_num">'+data[i].vehicle_year.substring(0,4)+'.'+data[i].vehicle_year.substring(4,6)+'</div>';
        htmlStr += '  <div class="mvInlineN td_num">'+data[i].trim_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'</div>';
        
        
         if(data[i].BASE_MM==""){
          htmlStr += '  <div class="mvInlineN td_zero">문의</div>';  
            
        }else{
        htmlStr += '  <div class="mvInlineN td_zero">'+data[i].BASE_MM+'</div>';}
        
         if(data[i].deposit < 100 || data[i].rentfee < 100){
         htmlStr += '  <div class="mvInlinev td_zero">문의</div>';
        htmlStr += '  <div class="mvInlinev td_zero">문의</div>'; }else{   
            
        htmlStr += '  <div class="mvInlinev td_zero">'+data[i].deposit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'</div>';
        htmlStr += '  <div class="mvInlinev td_zero">'+data[i].rentfee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'</div>'; }
        
        
         htmlStr += '  <div class="mvInlinev td_zero2"><button onclick="btn('+i+')">보기</button></div>';
        htmlStr += '</li>'
	}
    htmlStr += '</ul>'
    htmlStr += '</div>'
    
	$('#carList').html("");
	$('#carList').html(htmlStr);
	$('#page_box').html("");

	
}

    
       function btn(index){
        
        
       alert("해당차량의 상세옵션은 " + htmlOpt[index] + "입니다.");
        
    }
    
      function btn2(index){
        
        
       alert("해당차량의 색상은 " + htmlcolor[index] + "입니다.");
        
    }

  	/**
  	 * 문자열이 빈 문자열인지 체크하여 결과값을 리턴한다. 
  	 * @param str		: 체크할 문자열
  	 */
  	function isEmpty(str){
  		
  		if(typeof str == "undefined" || str == null || str == "")
  			return true;
  		else
  			return false ;
  	}
function goPage(pageNo){
	usedcar.page = pageNo;
//	usedcar.car_no = $('#no_trim').val();
	$(this).addClass('sort_active');
	$.ajax({
		type: "POST",
		url: "/bbs/usedcarAjax",
		//dataType: "json",
        contentType: "application/json",
		data: JSON.stringify(usedcar),
		success: function(data) {
			div_html(data);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("실패.")
		}
	});
}
function trim_no_search(){
	if( $('#no_trim').val() ==""){
		alert('차량번호나 이름을 입력해 주세요.');
		$('#no_trim').focus();
		return false;
	}
//	usedcar.maker = "";
	usedcar.trim_name = $('#no_trim').val();
//	usedcar.rentfee_min = "";
//	usedcar.rentfee_max = "";
//	usedcar.deposit = "";
//	usedcar.orderby = "";
	usedcar.car_no = $('#no_trim').val();
	$.ajax({
		type: "POST",
		url: "/bbs/usedcarAjax",
		//dataType: "json",
        contentType: "application/json",
		data: JSON.stringify(usedcar),
		success: function(data) {
			div_html(data);

		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("실패.")
		}
	});
	return false;
}

function Right(Str, Num){
	if (Num <= 0)
		return "";
	else if (Num > String(Str).length)
		return Str;
	else {
		var iLen = String(Str).length;
		return String(Str).substring(iLen, iLen - Num);
	 }
}
</script>

  <div class="content_box">
    <div class="filter">
      <div class="filter_item">
        <p class="filter_title">제조사</p>
        <ul id="maker_ui">
          <li id="maker" data-maker="" class="active"><a href="javascript:;">전체</a></li>
          <li id="maker" data-maker="현대"><a href="javascript:;">현대</a></li>
          <li id="maker" data-maker="기아"><a href="javascript:;">기아</a></li>
          <li id="maker" data-maker="로노삼성"><a href="javascript:;">르노삼성</a></li>
          <li id="maker" data-maker="쉐보레"><a href="javascript:;">쉐보레</a></li>
          <li id="maker" data-maker="쌍용"><a href="javascript:;">쌍용</a></li>
        </ul>
      </div>
      <div class="filter_item">
        <p class="filter_title">월렌트료</p>
        <ul id="rentfee_ul">
          <li id="lirentfee" data-lirentfee="" class="active"><a href="javascript:;">전체</a></li>
          <li id="lirentfee" data-lirentfee="40"><a href="javascript:;">50만원 미만</a></li>
          <li id="lirentfee" data-lirentfee="50"><a href="javascript:;">50만원대</a></li>
          <li id="lirentfee" data-lirentfee="60"><a href="javascript:;">60만원대</a></li>
          <li id="lirentfee" data-lirentfee="70"><a href="javascript:;">70만원 이상</a></li>
        </ul>
      </div>
      <div class="filter_item">
        <p class="filter_title">보증금</p>
        <ul id="deposit_ul">
          <li id="deposit" data-deposit="0" class="active"><a href="javascript:;">전체</a></li>
          <li id="deposit" data-deposit="2000000"><a href="javascript:;">200만원 이하</a></li>
          <li id="deposit" data-deposit="3000000"><a href="javascript:;">300만원 이하</a></li>
          <li id="deposit" data-deposit="5000000"><a href="javascript:;">500만원 이하</a></li>
          <li id="deposit" data-deposit="10000000"><a href="javascript:;">1000만원 이하</a></li>
        </ul>
      </div>
      <form onSubmit="return trim_no_search()">
      <div class="search">
        <input type="text" id="no_trim" name="no_trim" placeholder="차량번호 또는 차종을 입력해주세요.">
        <input  TYPE="IMAGE" src="/images/search.svg" name="Submit" value="Submit" style="width:16px;height:16px">
      </div>
       </form> 
    </div>
    <div class="order">
      <div style="align:left;clear:right;color:blue;">
      	<button id="text_list_all"><span class="qnaIco qnaIco1">리스트보기</span></button>
      </div>
        
       <div class="order_item">
        <span>모델명</span>
        <div class="button_wrap">
          <button id="model_asc"><span>▲</span></button>
          <button id="model_desc"><span>▼</span></button>
        </div>
      </div>     

      <div class="order_item">
        <span>가격순</span>
        <div class="button_wrap">
          <button id="price_asc" class="sort_active"><span>▲</span></button>
          <button id="price_desc"><span>▼</span></button>
        </div>
      </div>
      <div class="order_item">
        <span>연식순</span>
        <div class="button_wrap">
          <button id="year_asc"><span>▲</span></button>
          <button id="year_desc"><span>▼</span></button>
        </div>
      </div>
      <!--  
      <div class="order_item">
        <span>주행거리순</span>
        <div class="button_wrap">
          <button id="mile_asc"><span>▲</span></button>
          <button id="mile_desc"><span>▼</span></button>
        </div>
      </div>
      -->
    </div>

	<div id="carList">


	</div>      
    <div id="page_box" class="page_box">

  	</div>

</div>
  

<script>
window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
