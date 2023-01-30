<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/detail_style.css">
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
			if(iconListArr[i] == iconList[nCnt]){
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
	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "14e79358f12c520";
if(window.wcs) {
wcs_do();
}
</script>
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
            <li>
              <span class="title">보증금</span>
              <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.deposit}" />원</span>
            </li>
          </ul>
          <div class="term">
            <h3>상품별 렌트료</h3>
            <ul>
            
<c:if test="${(usedCarVO.car_type).equals('신차')}">
              <li>
                <span class="title">무심사렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee}" />원</span>
              </li>
              <li>
                <span class="title">하이렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_24}" />원</span>
              </li>
              <li>
                <span class="title">마이다스렌트</span>
                <span class="desc"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_1}" />원</span>
              </li>
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

<script>

window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
