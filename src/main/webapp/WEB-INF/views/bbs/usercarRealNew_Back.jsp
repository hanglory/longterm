<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/style_new.css">
<script>
var usedcar = {
		maker : "",
		trim_name : "",
		car_no:"",
		rentfee_min : "",
		rentfee_max : "",
		deposit : "",
		orderby : "",
		car_type : "신차"
	}

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
		
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		
		//car.UpdateSummary();
	});

	$('#rentfee_ul').on('click','li',function() {
		$('#lirentfee').removeClass('active');
		$('.active').removeClass('active');
		let selStr = $(this).data('lirentfee');
//		selStr = $(this).val('lirentfee');
		let htmlStr = "";
		usedcar.maker = "";
		usedcar.trim_name = "";
		if(selStr == "20"){ //30만원 미만
			usedcar.rentfee_min = "";
			usedcar.rentfee_max = "299999";
		}else if(selStr == "30"){ //30만원대
			usedcar.rentfee_min = "300000";
			usedcar.rentfee_max = "399999";			
		}else if(selStr == "40"){
			usedcar.rentfee_min = "400000";
			usedcar.rentfee_max = "499999";
		}else if(selStr == "50"){
			usedcar.rentfee_min = "500000";
			usedcar.rentfee_max = "";			
		}else{
			usedcar.rentfee_min = "";
			usedcar.rentfee_max = "";						
		}
		
		usedcar.deposit = "";
		usedcar.orderby = "";
		$(this).addClass('active');
		
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		
		//car.UpdateSummary();
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
		
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		
		//car.UpdateSummary();
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
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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

		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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

		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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

		$.ajax({
			type: "POST",
			url: "usedcarAjax",
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
	});
	
	usedcar.maker = "";
	usedcar.trim_name = "";
	usedcar.rentfee_min = "";
	usedcar.rentfee_max = "";
	usedcar.deposit = "";
	usedcar.orderby = "";
	$.ajax({
		type: "POST",
		url: baseUrl+"usedcarAjax",
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
});
function div_html(data){
	let htmlStr = "";
	var iconList;
	for(let i=0; i<data.length; i++) {
		
	 	if(i % 3 == 0)
	   		htmlStr += "<ul class='car_list thumbnail'>";
    	htmlStr += '<li class="car_item">';
		htmlStr += '<a href="usedcarDetail?car_id='+data[i].id+'"><img src="'+data[i].image+'" alt="">';
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
        htmlStr += '          <span class="ellipsis">'+data[i].deposit+'원</span>';
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
     	htmlStr += '      <span class="title">월렌트</span>';
     	htmlStr += '      <span class="price">'+data[i].rentfee+'원</span>';
     	htmlStr += '    </p>';
     	htmlStr += '  </div>';
     	htmlStr += '</div></a>';
     	htmlStr += '</li>';
 		if(i % 3 == 2)
	   		htmlStr += "</ul>";
	}
	$('#carList').html("");
	$('#carList').html(htmlStr);
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
		url: "usedcarAjax",
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
          <li id="lirentfee" data-lirentfee="20"><a href="javascript:;">30만원 미만</a></li>
          <li id="lirentfee" data-lirentfee="30"><a href="javascript:;">30만원대</a></li>
          <li id="lirentfee" data-lirentfee="40"><a href="javascript:;">40만원대</a></li>
          <li id="lirentfee" data-lirentfee="50"><a href="javascript:;">50만원 이상</a></li>
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
      <div class="order_item">
        <span>주행거리순</span>
        <div class="button_wrap">
          <button id="mile_asc"><span>▲</span></button>
          <button id="mile_desc"><span>▼</span></button>
        </div>
      </div>
    </div>

	<div id="carList">


	</div>      

</div>
  

<script>
window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
