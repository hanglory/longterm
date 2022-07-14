<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<script language="JavaScript"> 
var isPhoneAuth = false;

function setCookie( name, value, expiredays ){ 
	var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}

function sendSmsMsg(formVal) {
//	var telval= formVal.re_phone.value();
	var phoneval="";
	var customerval = "";
		phoneval = document.getElementById("re_phone").value;
		customerval = document.getElementById("re_name").value;
		carKindSel = formVal.re_credit.value;
		if(!fn_mbtlnumChk(phoneval) ){
			document.getElementById("re_phone").focus();
			return false;
		}
		if(isPhoneAuth){
			alert('문자전송중 입니다. 잠시 기다려 주세요. 문자를 받지 못하셨으면 스팸함을 확인해 주세요.');
			return false;
		}
		isPhoneAuth = true;
//	$(this).val('인증번호확인');
//	addClass('selected');
	var smsSendAuth = {phoneNo: phoneval,
						customerNm: customerval,
						carKindSel: carKindSel,
					 	keyType:"MAIN_STATIC"
					 };
	$.ajax({
		type: "POST",
		url: baseUrl+"bbs/smsSendHelpAjax",
		data    :JSON.stringify(smsSendAuth),
		async: false,
		//dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
				data.smsCode;
				data.keyValue;
				car.authNumber = data.authKey;
				if(data.smsCode == "0000"){
					alert("상담요청이 완료 되었습니다. 곧 상담원이 전화 연락 드리겠습니다.");
					isPhoneAuth = false;
					return false;
				}else{
					alert("현재 문자 전송이 원활하지 않습니다. 잠시후 다시 이용해 주세요.");
					return false;
				}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("문자 전송 실패.")
            return false;
		}
	});
} // <------ 현드폰번호 인증	

function fn_mbtlnumChk(mbtlnum){
	  var regExp = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))(-\d{4})$/;
	  if(!regExp.test(mbtlnum)){
	    alert(mbtlnum+"휴대폰번호가 올바르지 않습니다.");
	    return false;
	  }
	  return true;
}
function autoHypenPhone(str){
    str = str.replace(/[^0-9]/g, '');
    var tmp = '';
    if( str.length < 4){
        return str;
    }else if(str.length < 7){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3);
        return tmp;
    }else if(str.length < 11){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 3);
        tmp += '-';
        tmp += str.substr(6);
        return tmp;
    }else{              
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 4);
        tmp += '-';
        tmp += str.substr(7);
        return tmp;
    }
    return str;
}
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

<style>
	.sector1 {
		height: 972px;
		background-size: cover;
		position: relative;
		margin: 0 auto;
	}

	.sector2 {
		min-width: 1200px;
	}	
	.sector2 img {
		width: 1903px;
	}	
	.sector3 {
		min-width: 1200px;
		height: 306px;
		background-color: #f7f3f0;
	}
	
	.box {
		width: 1040px;
		height: 100%;
		margin: 0px auto;
		padding: 20px 0;
		--background-color: #888;
		--border: 1px solid #000;
	}
	
	.col6 {
		width: 50%;
		height: 50%;
		--display: inline;
		--float: left;
		display: inline-block;
		
		margin: 0 auto;
		--padding: 50px;
	}
	
	.col3 {
		width: 260px;
		--display: inline;
		float: left;
		--border: 1px solid #000;
		--padding: 2px;
	}

	.col3 img {
		width: 100%;
	}
	.sector1::after {
	}
	
	.col6 img {
		display: block;
		width: 80%;
		margin : 0 auto;
	}
	.col6 img:hover {
		transform: scale(1.1);
	}
#hd_pop {z-index:1000;position:relative;margin:0 auto;width:970px;height:0;}
#hd_pop h2 {position:absolute;font-size:0;line-height:0;overflow:hidden}
.hd_pops {position:absolute;border:1px solid #e9e9e9;background:#fff}
.hd_pops_con {}
.hd_pops_footer {padding:10px 0;background:#000;color:#fff;text-align:right;opacity : 1.0;}
.hd_pops_footer button {margin-right:5px;padding:5px 10px;border:0;background:#393939;color:#fff}


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
#vagree2{width:254px; height:236px; padding:10px; top:0; left:-254px; z-index:10000; border:2px solid #222; background:#fff; position:absolute;}
#vagree2 h2{font-weight:bold; font-family:"NanumGothic"; color:#444; font-size:100%}
#vagree2 div{width:232px; border:1px solid #d7d7d7; height:190px; margin-top:5px; padding:10px; background:#fbfbfb; overflow-y:scroll; scrollbar-face-color:#fff; scrollbar-shadow-color:#eaeaea; scrollbar-highlight-color:#eaeaea; scrollbar-3dlight-color:#fff; scrollbar-darkshadow-color:#fff; scrollbar-track-color:#fff; scrollbar-arrow-color:#eaeaea; float:left;}
#vagree2 div h3{font-weight:bold; font-family:"NanumGothic"; color:#707070; font-size:100%}
#vagree2 div ul{margin:5px 0 10px;}
#vagree2 div ul li{font-size:11px; line-height:20px; color:#909090;}
.dn{display:none;}

/* style_new.css */
.car_list {
  display: flex;
  flex-wrap: wrap;
}

.car_item {
  width: 285px;
  display: flex;
  flex-direction:column;
  margin-bottom: 20px;
}

.car_item:not(:nth-child(4n)){
  margin-right: 20px;
}

.car_item img {
  width: 100%;
  height: 188px;
}

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
  padding-left: 16px;
  margin-top: 20px;
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
.car_content .rent {
  padding-right: 16px;
  font-size: 18px;
  font-weight: 500;
}
.car_content .rent .title{
  color: #c2bfbf;
  font-weight: inherit;
  margin-right: 10px;
}
.car_content .rent .price{
  color: #d52323;
  font-weight: inherit;
}

.car_list.thumbnail {
  justify-content: flex-start;				/* space-between;*/
  padding: 0 20px;
  margin: 20px 0 40px 0;
  margin-left: auto;
  margin-right: auto;
}

.car_list.thumbnail .car_item{
  width: 370px;
  height: 420px;
  margin-right: 16px;
}

.car_list.thumbnail .car_item img {
  height: 220px;
}
.car_list.thumbnail .car_content .rent {
  text-align: center;
  /*width: calc(100% - 51px ); */
  display: flex;
  justify-content: center;
}
.car_list.thumbnail .car_content .label{
  background-color: #e1e1e1;
}

@media screen and (max-width: 790px) {
  .car_list {
    display: block;
  }
  
  .car_item {
    width: 100%;
    display: flex;
    flex-direction:column;
    margin-bottom: 16px;
  }
  
  .car_item:not(:nth-child(4n)){
    margin-right: 0;
  }
  
  .car_item img {
    height: 220px;
  }
  
 
  
  .car_content .left_area {
    padding-left: 14px;
  }

  .car_content .left_area li span{
    white-space: nowrap;
    font-size: 13px;
  }

  .car_content .bottom_area {
    padding-left: 14px;
    margin-top: 16px;
  }
  
  .car_content .label {
    width: 45px;
    height: 50px;
    border-top-right-radius: 22px;
    border-top-left-radius: 22px;
    font-size: 12px;
    padding-bottom: 5px;
  }

  .car_content .rent {
    padding-right: 14px;
    font-size: 16px;
  }
  .car_content .rent .title{
    margin-right: 8px;
  }
  
  .car_list.thumbnail {
    justify-content: space-between;
    padding: 0;
    margin: 20px 0 0 0;
    text-align: center;
  }
  
  .car_list.thumbnail .car_item{
    width: 100%;
    height: 420px;
    margin-right: 0;
    margin-bottom: 15px;
  }
  
  .car_list.thumbnail .car_content .rent {
    text-align: right;
    width: calc(100% - 45px);
    justify-content: flex-end;
  }
}
</style>
  <link rel="stylesheet" href="/css/static.css">

<c:if test="${siteinfoVO.id > 0 }">
	<c:if test="${cookie.maindiv.value ne 'done' }">

<div id="hd_pop">
    <h2>팝업레이어 알림</h2>

    <div id="hd_pops_40" class="hd_pops" style="top:${siteinfoVO.top_postion }px;left:${siteinfoVO.left_postion}px">
        <div class="hd_pops_con" style="width:${siteinfoVO.width }px;height:${siteinfoVO.height }px">
            <p><a href="${siteinfoVO.link_url }"><img src="${siteinfoVO.contents }" title="광고이미지" alt="광고이미지" /></a><br style="clear:both;" /> </p>        </div>
        <div class="hd_pops_footer">
            <button class="hd_pops_reject hd_pops_40 24"><strong>24</strong>시간 동안 다시 열람하지 않습니다.</button>
            <button class="hd_pops_close hd_pops_40">닫기</button>
        </div>
    </div>
</div>

<script>
$(function() {
    $(".hd_pops_reject").click(function() {
        $('#hd_pop').css("display", "none");
        setCookie( "maindiv", "done" , 1 );
    });
    $('.hd_pops_close').click(function() {
        var idb = $(this).attr('class').split(' ');
        $('#hd_pop').css('display','none');
    });
//    $("#hd").css("z-index", 1000);
});

$(document).ready(function(){
	cookiedata = document.cookie; 
	if ( cookiedata.indexOf("maindiv=done") < 0 ){ 
	//	document.all['hd_pop'].style.visibility = "visible";
		$('#hp_pop').show();
	} else { 
		$('#hp_pop').hide(); 
	}
});
</script>

</c:if>
</c:if>

<div id="quick">
	<div class="quick-input">
		<form method="post" id="frequestform" name="frequestform" onSubmit="return sendSmsMsg(this)" action="#">
		<input type="hidden" id="re_divi" name="re_divi" value="quick" />
		<h1>상담 문의합니다</h1>
		<ul>
			<li><span><input type="text" id="re_name" name="re_name" required class="focusInput" placeholder="이름"/></span></li>
			<li><span><input type="text" id="re_phone" name="re_phone" required class="focusInput" pattern="(010)-\d{3,4}-\d{4}" placeholder="010-1234-5678"/></span></li>
			<!--<li><span><input type="text" id="qre_ncar" name="re_ncar" required class="focusInput" /><label for="qre_ncar">차종</label></span></li>-->
            <li>
			<span>
				<select id="re_credit" name="re_credit" required class="required">
					<option value="">차량구분</option>
					<option value="신차">신차</option>
					<option value="중고차">중고차</option>
				</select>
			</span>
			</li>
		</ul>
		<div class="agree"><input type="checkbox" id="agree" name="agree" required value="1" /> <label for="agree">개인정보취급방침</label> <a href="javascript:;" class="btn-vagree2"><img src="${RPATH}/images/btn_vagree.png"></a></div>
		<div class="submit"><input type="submit" value="신청하기 >" /></div>
		</form>

		<script type="text/javascript">
			jQuery(function(){
				jQuery(".btn-vagree2").click(function(){
					jQuery("#vagree2").toggleClass("dn");
				});
			});
		</script>
		<div id="vagree2" class="dn">
			<h2>개인정보의 수집 및 이용에 대한 동의</h2>
			<div>
				<h3>1. 개인정보의 수집·이용 목적</h3>
				<ul>
					<li>하모니렌트카(harmonyrentcar.com)는 실시간 무료견적 서비스를 제공하기 위하여 개인정보를 수집하고 있으며, 수집된 정보를 아래와 같이 이용하고 있습니다.</li>
					<li>이용자가 제공한 모든 정보는 상담 목적에 필요한 용도 이외로는 사용되지 않습니다.</li>
				</ul>
				<h3>2. 수집하려는 개인정보의 항목</h3>
				<ul>
					<li>- 필수항목: 성명/회사명, 연락처, 차종, 지역, 개인정보취급방침</li>
				</ul>
				<h3>3. 개인정보의 보유 및 이용 기간</h3>
				<ul>
					<li>개인정보 보유 기간은 상담완료 시 까지이며, 상담 완료시 개인정보 및 관련 정보를 데이터베이스에서 삭제가 됩니다.</li>
				</ul>
				<h3>4. 동의를 거부할 권리 및 동의를 거부</h3>
				<ul>
					<li>하모니렌트카에서는 최소한의 개인정보를 수집하고 있으며, 개인정보 수집동의에에 동의하지 않을 수 있습니다.</li>
					<li>단, 동의를 하지 않을 경우 상담신청이 불가합니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<ul class='car_list thumbnail'>
<c:forEach var="usedCarVO" items="${newUsedCarVO }">
<li class="car_item">
<a href="/bbs/usedcarDetail?car_id=${usedCarVO.id}"><img src="${usedCarVO.image}" alt="">
  <div class="car_content">
    <div class="top_area">
      <div class="left_area">
      <h3>${usedCarVO.trim_name}</h3>
      <ul>
        <li>
          <span class="title">차량유종</span>
          <span class="ellipsis">${usedCarVO.fuel}</span>
        </li>
      </ul>
    </div>
    <div class="right_area">
       <strong class="red">선택항목</strong>
       <script>
        iconList = "${usedCarVO.icon}".split('|');
		for(var nCnt in iconList){
			if(iconList[nCnt] != "")
				document.writeln('<strong class="orange">'+iconList[nCnt]+'</strong>');
		}
		</script>
    </div>
  </div>
  <div class="bottom_area">
    <p class="rent">
      <span class="title">월렌트료</span>
      <span class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_1}" /> 원</span>
    </p>
  </div>
</div></a>
</li>
</c:forEach>
</ul>

<ul class='car_list thumbnail'>
<c:forEach var="usedCarVO" items="${oldUsedCarVO }">
<li class="car_item">
  <a href="/bbs/usedcarDetail?car_id=${usedCarVO.id}"><img src="${usedCarVO.image}" alt="">
   <div class="car_content">
    <div style="display: flex;flex-wrap: wrap; margin-bottom: 10px;">
<script>
        iconList = "${usedCarVO.icon}".split('|');
		for(var nCnt in iconList){
			if(iconList[nCnt] != "")
				document.writeln('<span style="font-size: 12px;color: #fff;border-radius: 5px;padding: 2px 18px;background-color: #4e6c8a;">'+iconList[nCnt]+'</span>');
		}
</script>
    </div>
      <h3>${ usedCarVO.trim_name}</h3>
      <ul>
        <li>
          <span class="title">차량유종</span>
          <span class="ellipsis">${usedCarVO.fuel}</span>
        </li>
        <li>
          <span class="title">주행거리</span>
          <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.distance}" /> Km</span>
        </li>
        <li>
          <span class="title">약정개월</span>
          <span class="ellipsis">${ usedCarVO.period} 개월</span>
        </li>
      </ul>        
    <p class="rent">
      <span class="title">월렌트</span>
      <span class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee}" />원</span>
    </p>
   </div>
  </a>
</li>
</c:forEach>
</ul>
	
		<div class="sector2">

				<img src="${RPATH}/images/total-top2.jpg"  name = "mainvisualimg" usemap="#Map" >

<map name= "Map" id="Map">
    <area shape="rect" coords="1162,315,1351,438" href="https://www.harmonyrent.co.kr/bbs/usedcarRealNew" onmouseover="if(document.images) mainvisualimg.src='${RPATH}/images/main-new.png'" onmouseout="if(document.images) mainvisualimg.src='${RPATH}/images/total-top2.jpg'" onfocus="blur();"/>
    <area shape="rect" coords="1418,326,1604,482" href="https://www.harmonyrent.co.kr/bbs/usedcarReal" onmouseover="if(document.images) mainvisualimg.src='${RPATH}/images/main-used.png'" onmouseout="if(document.images) mainvisualimg.src='${RPATH}/images/total-top2.jpg'" onfocus="blur();"/>
    <area shape="rect" coords="1110,444,1285,627" href="https://www.harmonyrent.co.kr/bbs/usedcarDetail?car_id=368" onmouseover="if(document.images) mainvisualimg.src='${RPATH}/images/main-new2.png'" onmouseout="if(document.images) mainvisualimg.src='${RPATH}/images/total-top2.jpg'" onfocus="blur();"/>
    <area shape="rect" coords="1349,477,1556,667" href="https://www.harmonyrent.co.kr/bbs/usedcarReal" onmouseover="if(document.images) mainvisualimg.src='${RPATH}/images/main-used2.png'" onmouseout="if(document.images) mainvisualimg.src='${RPATH}/images/total-top2.jpg'" onfocus="blur();"/>
    <area shape="rect" coords="750,425,1013,690" href="https://harmonyrent.co.kr/totalrent" onmouseover="if(document.images) mainvisualimg.src='${RPATH}/images/main-total.png'" onmouseout="if(document.images) mainvisualimg.src='${RPATH}/images/total-top2.jpg'" onfocus="blur();"/>
</map>

	</div>
	<div class="sector3">
		<div class="box">
			<div class="col3">
				<a href="https://harmonyrentcar2.imweb.me/Crew"><img src="/images/Link4.png" alt=""></a>
			</div>
			<div class="col3">
				<a href="https://blog.naver.com/harmony_rentcar"><img src="${RPATH}/images/Link2.png" alt="" /></a>
			</div>
			<div class="col3">
				<a href="http://harmonyrentcar.kr"><img src="${RPATH}/images/Link3.png" alt="" /></a>
			</div>
			<div class="col3">
				<a href="http://aprentcar.com/"><img src="${RPATH}/images/Link1.png" alt="" /></a>
			</div>
		</div>
	</div> 
	
