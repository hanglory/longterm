<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/detail_style.css">
<style>
#quick{width:127px; top:102px; right:137px; position:absolute;}
#quick .quick-input{width:200px; border:1px solid #478ed1; background:#f1f6f6; float:left;}
#quick .quick-btn{width:195px; margin-top:5px; float:left;}

#quick .quick-input h1{padding-top:20px; font-weight:600; font-size:16px; text-align:center; color:#478ed1; display:block;}
#quick .quick-input ul{padding:5px 25px 15px; float:left;}
#quick .quick-input ul li{margin-top:3px; float:left;}
#quick .quick-input ul li input{width:150px; height:24px; border:1px solid #242424; background:#fbfbfb;}
#quick .quick-input span{margin-right:1px; position:relative; _display:inline; float:left;}
#quick .quick-input span label{top:5px; left:6px; position:absolute; letter-spacing:-1px; color:#999;}
#quick .quick-input div.agree{width:140px; margin-top:2px; margin-left:30px; font-size:11px; color:#999; float:left;}
#quick .quick-input div.agree a{margin:3px 5px; text-align:center; display:block;}
#quick .quick-input div.submit{width:127px; float:left;}
#quick .quick-input div.submit input{width: 200px; height:29px; font-weight:600; color:#fff; border:0; background:#478ed1;}
.car_content {
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  border: 1px solid #eee;
  padding-top: 16px;
  height: 175px
}

.car_content .top_area {
  display: flex;
  justify-content: space-between;
}

.car_content .left_area {
  padding-left: 16px;
  width: calc(100% - 60px);
}

.car_content .left_area h3 {
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 3px;
}
.car_content .left_area li {
  display: flex;
}

.car_content .left_area li span{
  white-space: nowrap;
  font-size: 14px;
}
.car_content .left_area .title {
  color: #cacaca;
  display: inline-block;
  margin-right: 8px;
}
  
.car_content .right_area strong {
  display: block;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
  font-size: 13px;
  color: #fff;
  padding: 2px 0;
  width: 75px;
  margin-bottom: 4px;
  text-align: center;
}

.car_content .right_area strong.red {
 background-color: #ed145b;
}
.car_content .right_area strong.orange {
 background-color: #f26522;
}

.car_content .bottom_area {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-left: 10px;
  margin-top: 0px;
  margin-bottom: 20px;
}

.car_content .label {
  width: 51px;
  height: 60px;
  border-top-right-radius: 40px;
  border-top-left-radius: 40px;
  font-size: 13px;
  font-weight: 500;
  display: flex;
  justify-content: center;
  align-items: flex-end;
  padding-bottom: 6px;
  background-color: #7accc8;
}
.car_content .label.new {
  color: #f90000;
}
.car_content .label.used {
  color: #0a10ff;
}
.car_content .pop_rent {
  padding-right: 16px;
  font-size: 18px;
  font-weight: 500;
}
.car_content .pop_rent .title{
  color: #c2bfbf;
  font-weight: inherit;
  margin-right: 10px;
}
.car_content .pop_rent .price{
  color: #d52323;
  font-weight: inherit;
}
    
    
    #btn-promotion{
        
    width: 20%;
    margin: 40px auto;
    text-align: center;
    line-height: 2em;
    font-size: 1.2em;
    height: 2em;
    background: rgb(42, 144, 168);
    color: white;
    cursor: pointer;
        
    }    

</style>
<script>
var optionListArr = ["네비게이션","전동시트","블랙박스","전방감지센서","후방감지센서","후방카메라","크루즈컨트롤","스마트키","하이패스","열선시트","통풍시트","열선핸들","썬루프"];
var iconListArr = ["엔진오일2회","엔진오일4회","즉시출고","신차급"];

$(function(){
	var htmlStr = '';
	var optionList = "${usedCarVO.options }".split('|');
	var allcnt=0;
	for(i=0; optionListArr.length > i ; i++){
		let optionFlag = false;
		if(allcnt%3 == 0){
			htmlStr += '<ul class="option_list">';		
		}
		htmlStr += '<li class="option_item">';
		htmlStr += '<p>'+optionListArr[i]+'</p>';
		htmlStr += ' <label class="check_lable">';
//        htmlStr += '   <input type="checkbox">';
		for (var nArrCnt in optionList) {
			if(optionListArr[i] == optionList[nArrCnt]){
				optionFlag=true;
				break;
			}
		}
		if(optionFlag){
//	        htmlStr += '   <input type="checkbox">';
			htmlStr += '   <div class="round_check_style_click">';
			htmlStr += '      <img src="/images/check_white.svg" alt="">';
			htmlStr += '   </div>';
	        htmlStr += '   <span class="label_text true">장착</span>';			
		}else{
			htmlStr += '   <div class="round_check_style">';
			htmlStr += '      <img src="/images/check_white.svg" alt="">';
			htmlStr += '   </div>';
			htmlStr += '   <span class="label_text false">미장착</span>';
		}
        htmlStr += ' </label>';
        htmlStr += '</li>';
		if(allcnt%3 == 2){
			htmlStr += '</ul>';		
		}
		allcnt++;
	}
	var iconList = "${usedCarVO.icon }".split('|');
	for(i=0; iconListArr.length >i ; i++){
		let iconFlag = false;
		if(allcnt%3 == 0){
			htmlStr += '<ul class="option_list">';		
		}
		htmlStr += '<li class="option_item">';
		htmlStr += '<p>'+iconListArr[i]+'</p>';
		htmlStr += ' <label class="check_lable">';
//        htmlStr += '   <input type="checkbox">';
		for (var nCnt in iconList) {
			if(iconListArr[i] == iconList[nCnt].replace(" ","")){
				iconFlag=true;
				break;
			}
		}
		if(iconFlag){
//	        htmlStr += '   <input type="checkbox">';
			htmlStr += '   <div class="round_check_style_click">';
			htmlStr += '      <img src="/images/check_white.svg" alt="">';
			htmlStr += '   </div>';
	        htmlStr += '   <span class="label_text true">확인</span>';			
		}else{
			htmlStr += '   <div class="round_check_style">';
			htmlStr += '      <img src="/images/check_white.svg" alt="">';
			htmlStr += '   </div>';
			htmlStr += '   <span class="label_text false">미확인</span>';
		}
        htmlStr += ' </label>';
        htmlStr += '</li>';
		if(allcnt%3 == 2){
			htmlStr += '</ul>';		
		}
		allcnt++;
	}
	
	$('#optionListHtml').html("");
	$('#optionListHtml').html(htmlStr);
});

</script>

        <% 
	int isMobile = 0;
	String agent = request.getHeader("USER-AGENT");
	String[] mobileos = {"iPhone","iPod","Android","BlackBerry","Windows CE","Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
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
    
    
    
   <div class="content_box">
    <h1>${usedCarVO.trim_name }</h1>
    <div class="car">
      <div class="img_wrap">
        <img class="img_cover" src="${usedCarVO.image }" alt="">
      </div>
      <div class="right_area">
        <div class="top_area">
          <ul class="car_info">
            <li>
              <span class="title">차량년식</span>
              <span class="desc">${fn:substring(usedCarVO.vehicle_year,0,4)}년 ${fn:substring(usedCarVO.vehicle_year,4,6)}월식</span>
            </li>
            <li>
              <span class="title">주행거리</span>
              <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.distance}" />km</span>
            </li>

<c:if test="${(usedCarVO.car_type).equals('신차')}">
<li>
              <span class="title">보증금</span>
	<span class="desc">상품에 따라 다름</span>	 
            </li>
  </c:if>

<c:if test="${(usedCarVO.car_type).equals('중고차')}">
            <li>
              <span class="title">보증금</span>
	<span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.deposit}" />원</span>	 
            </li>
</c:if>

          </ul>
          <div class="term">
            <h3>상품별 렌트료(vat포함)</h3>
            <ul>
            
            
<c:if test="${(usedCarVO.car_type).equals('신차')}">
	<c:if test="${reqParam.agent_fee == 0|| empty reqParam.agent_fee }">
              <li>
                <span class="title">무심사렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee}" />원<br/>(48개월기준)</span>
              </li>
              <li>
                <span class="title">하이렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_24}" />원<br/>(48개월기준)</span>
              </li>
              <li>
                <span class="title">마이다스렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_1}" />원<br/>(48개월기준)</span>
              </li>
    </c:if>
    <c:if test="${reqParam.agent_fee != 0 && !empty reqParam.agent_fee}">
              <li>
                <span class="title">무심사렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${reqParam.rentfee_no}" />원<br/>(${reqParam.period_no }개월기준)</span>
              </li>
              <li>
                <span class="title">하이렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${reqParam.rentfee_hi}" />원<br/>(${reqParam.period_hi }개월기준)</span>
              </li>
              <li>
                <span class="title">마이다스렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${reqParam.rentfee_my}" />원<br/>(${reqParam.period_my }개월기준)</span>
              </li>
    </c:if>
</c:if>
<c:if test="${(usedCarVO.car_type).equals('중고차') }">
              <li>
                <span class="title">${usedCarVO.period}개월렌트료</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee}" />원</span>
              </li>
              <li>
                <span class="title">24개월렌트료</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_24}" />원</span>
              </li>
</c:if>              
            </ul>
          </div>
        </div>
        <div class="rent">
          <h3>렌트조건</h3>
          <ul>
            <li>만 26세 이상</li>
            <li>운전경력 1년 이상</li>
            <li>소득증빙 3개월</li>
          </ul>
        </div>
      </div>
    </div>

       
       
    <div class="option_wrap">
      <div class="option">
        <h2>옵션 정보</h2>
        <div class="option_content" id="optionListHtml">
 
        </div>
      </div>
    </div>
    <div class="editor_area">
${usedCarVO.contents }
    </div>
  </div>
    
   <% if( isMobile != 1 ){ %> 
<c:forEach var="usedCarVoPop" items="${usedCarVOPop }">
<div id="quick">
	<div class="quick-input">
		<li class="car_item">
		<a href="/bbs/usedcarDetail?car_id=${usedCarVoPop.id}"><img src="${usedCarVoPop.image}" width="100%" height="100%">
		  <div class="car_content">
		    <div class="top_area">
		      <div class="left_area">
		      <h2>${usedCarVoPop.trim_name}</h2>
		       <p class="pop_rent">
		          <span class="title">차량유종</span>
		          <span class="ellipsis">${usedCarVoPop.fuel}</span>
		       </p>
		    </div>
		  </div>
		  <div class="bottom_area">
		    <p class="pop_rent">
		      <span class="title">월렌트료</span>
		      <span class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVoPop.rentfee}" /> 원</span>
		    </p>
		  </div>
		</div></a>
		</li>	
	</div>
</div>
</c:forEach>
         <% } %>
<script>

window.addEventListener("load", function() {
	//getEstimateList();
});

jQuery(document).ready(function(){
	var quick_rmenu = jQuery("#quick");
	var quick_rtop = 102;
	jQuery(document).ready(function(){
		jQuery(window).scroll(function(){
			quick_rmenu.stop().animate({"top":jQuery(document).scrollTop()+quick_rtop+"px"}, 1000 );
		});
	});
	$("#re_phone").on("propertychange change keyup paste input", function() {
		var _val = $(this).val();
		
		var tel_val = autoHypenPhone(_val) ;
		$(this).val(tel_val);
	});	
});
</script>
