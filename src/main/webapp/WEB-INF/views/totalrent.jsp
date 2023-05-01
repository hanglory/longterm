<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type='text/javascript'> 
window.onpageshow =  function(event) {
    //back 이벤트 일 경우
    if (event.persisted) {
    		//todo
    		window.location.reload();
    }
}
window.onload = function(){ 
	if(navigator.userAgent.match(/inapp|NAVER|KAKAOTALK|Snapchat|Line|WirtschaftsWoche|Thunderbird|Instagram|everytimeApp|WhatsApp|Electron|wadiz|AliApp|zumapp|iPhone(.*)Whale|Android(.*)Whale|kakaostory|band|twitter|DaumApps|DaumDevice\/mobile|FB_IAB|FB4A|FBAN|FBIOS|FBSS|SamsungBrowser\/[^1]/i))
	{ 
		document.body.innerHTML = ''; 
		if(navigator.userAgent.match(/iPhone|iPad/i)){ 
			window.open(location.href, "_self");
		}else{ 
			location.href='intent://'+location.href.replace(/https?:\/\//i,'')+'#Intent;scheme=http;package=com.android.chrome;end'; 
		} 
	} 
} 
</script>
	    
<script>
function check() {
	if ($("input:checkbox[name='ck[]']").is(":checked")==false) {
		alert("개인정보 수집 동의란에 체크해주세요.");
		$("#ck1").focus();
		return;
	}
}
</script>    
 
<!-- 수수료 3까지만 입력되게 -->        
<script>
$(document).on("keyup", "input[name^=commission]", function() {
    var val= $(this).val();

    if(val > 3) {
        alert("최대 수수료는 3% 입니다.");
        $(this).val('');
    }
});
</script>    
  <!-- 수수료 3까지만 입력되게 끝-->     
  

    <div id="container">

<style>
.folder:after {
	position: absolute;
	right : 5px;
	top: 10px;
	content: url("${RPATH}/images/삼각형.png");
	transition: all ease 0.3s;
}
.folder.expanded:after {
	transform: rotate(180deg) translateY(-5px);
}

.adsbox {
	--max-width: 1000px;
	text-align: center;
	margin: 0 auto;
	margin-top : 100px;

}

.footer img, .adsbox img {
	width: 1200px;
}


header, footer {
	min-width: 1200px;
}

.pc-menu {
	min-width: 1200px;
}

div,
input,
textarea {
  box-sizing: border-box;
}

.form-background {
  background-color: blueviolet;
  padding: 50px;
}

.form-white {
  background-color: white;
  padding: 50px;
  width: 600px;

  margin: auto;
}

.form-white h1 {
  font-size: 20px;
  margin-bottom: 40px;
}

.form-label {
  display: block;
  margin: 10px 0px 10px 0px;
}

.form-input {
  padding: 10px;
  font-size: 20px;
  border: 1px solid black;
  border-radius: 5px;
  width: 100%;
}

.form-Email,
.form-Content {
  width: 100%;
  padding: 7px;
}

.form-Fname {
  width: 50%;
  float: left;
  padding: 7px;
}

.form-Lname {
  width: 50%;
  float: left;
  padding: 7px;
}

.form-button {
  padding: 10px;
  font-size: 18px;
  display: block;
  margin-left: auto;
}

.add-info flex-center input{

height: 30px;

}




* {padding: 0;margin: 0;}
body, html {height: 100%;}
.modal .btn{cursor: pointer;border: 1px solid #999999;text-align: center;border-radius: 5px;outline: none;font-weight: 500;}
.dimLayer{display: block;width: 100%;background-color: rgba(0, 0, 0, 0.3);position: fixed;left: 0;top: 0px;margin: 0;padding: 0;z-index: 9998;}
.modal{width: 600px;height: 252px;border-radius: 10px;padding: 80px 24px;box-sizing: border-box;text-align: center;}
.modal-section{background: #ffffff;box-sizing: border-box;display: none;position: absolute;top: 50%;left: 50%;-webkit-transform: translate(-50%, -50%);-ms-transform: translate(-50%, -50%);-moz-transform: translate(-50%, -50%);-o-transform: translate(-50%, -50%);transform: translate(-50%, -50%);display: none;z-index: 9999;}
.menu_msg{font-size: 21px;font-weight: 500;}
.enroll_box p{padding-bottom: 56px;}
.gray_btn {width: 90px;background: #ffffff;color: #999999;height: 36px;line-height: 36px;transition: 0.5s;font-size: 17px;}
.pink_btn {width: 90px;background: #ed197a;color: #fff;height: 36px;line-height: 36px;transition: 0.5s;font-size: 17px;border: none;}
</style>	




<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/css/static.css" />
<link rel="stylesheet" href="/css/estimate.css" />

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
        
        
 <!-- 전환페이지 설정 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript">

function change(){

var _nasa={};
if(window.wcs) _nasa["cnv"] = wcs.cnv("1","10"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고

}
</script>        
        
     <!-- 다음 전환페이지 설정 -->    
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/kas/static/kp.js"></script>
<script type="text/javascript">

	function changedaum(){
      kakaoPixel('3481025403756984027').pageView();
      kakaoPixel('3481025403756984027').signUp('Subscription');
}
</script>        

	<main>
		<div class="context-box">
			<section>
				<h1 class="no-disp">장기렌트 견적 항목</h1>

				<div>
					<img src="${RPATH}/images/totalrent.png" alt="" align="middle"/>
				</div>
				<div class="longterm-main">

					<div class="longterm-select noselect">
					
						<div class="category-box">
							<div class="menu-header expanded" id="maker-header">
								<div class="menu-title index hasItems">01</div>
								<div class="menu-title"><span class="title">제조사</span></div>
							</div>
					
							<div class="content">
								<ul id="maker">
			                        <li class="maker" data-maker="현대">
			                        	<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/현대.png" alt="" />
			                        		<span style="display:block; text-align:center;">현대</span>
			                        	</div>
			                        </li>
			                        <li class="maker" data-maker="기아">
			               				<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/기아.png" alt="" />
			                        		<span style="display:block; text-align:center;">기아</span>
			                        	</div>
			                        </li>
			                        <li class="maker" data-maker="제네시스">
										<div  class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/제네시스.png" alt="" />
			                        		<span style="display:block; text-align:center;">제네시스</span>
			                        	</div>
									</li>
			                        <li class="maker" data-maker="쉐보레">
			               				<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/쉐보레.png" alt="" />
			                        		<span style="display:block; text-align:center;">쉐보레</span>
			                        	</div>
									</li>
			                        <li class="maker" data-maker="르노삼성">
			               				<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/르노삼성.png" alt="" />
			                        		<span style="display:block; text-align:center;">르노삼성</span>
			                        	</div>									
									</li>
			                        <li class="maker" data-maker="쌍용">
			                        	<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/쌍용.png" alt="" />
			                        		<span style="display:block; text-align:center;">쌍용</span>
			                        	</div>
									</li>
					  <li class="maker" data-maker="벤츠">
			                        	<div class="imagecontainer">
			                        		<img src="${RPATH}/images/logo/벤츠.png" alt="" />
			                        		<span style="display:block; text-align:center;">벤츠</span>
			                        	</div>
									</li>
			                    </ul>
							</div>
						</div>

				<div class="category-box-notice">
					<div class="menu-title">
						<span class="title-notice">  ※ 각 제조사 모델 변경은 실시간 반영이 어려우므로, 
						다소 차이가 있을 수 있습니다. 자세한 사항은 문의 주십시요.
						</span>
						<span class="title-notice" style = "color:red;">
							※ 5천만원 이상의 고가차량일 경우, 보증금 20% 이상부터 설정할 수 있습니다. </span>
					</div>
				</div>

						<div class="category-box">
							<div class="menu-header folder expanded" id="model-header">
								<div class="menu-title index">02</div>
								<div class="menu-title"><span class="title">모델</span></div>
							</div>
							
							<div class="content">
								<ul id="model">
								</ul>
							</div>
						</div>


						<div class="category-box">
							<div class="menu-header folder expanded" id="lineup-header">
								<div class="menu-title index">03</div>
								<div class="menu-title"><span class="title">라인업</span></div>
							</div>
							
							<div class="content">
								<ul id="lineup">
								</ul>
							</div>
						</div>

						<div class="category-box">
							<div class="menu-header folder expanded" id="trim-header">
								<div class="menu-title index">04</div>
								<div class="menu-title"><span class="title">트림</span></div>
							</div>
							
							<div class="content">
								<ul id="trim" style="width:95%">
								</ul>
							</div>
						</div>

						<div class="category-box">
							<div class="menu-header folder expanded" id="option-header">
								<div class="menu-title index">05</div>
								<div class="menu-title"><span class="title">옵션</span></div>
	
							</div>
							<div class="content">
								<ul id="option" style="width:95%;">
								</ul>
							</div>
						</div>

						<div class="category-box">
							<div class="menu-header folder expanded" id="color-header">
								<div class="menu-title index">06</div>
								<div class="menu-title"><span class="title">색상</span></div>
							</div>
							
							<div class="content">
								<ul id="colortable">
								</ul>
							</div>
						</div>

						<!-- Agent를 위한 항목 -->
						<c:if test="${userLevel > 0 }">
<script>car.agent_fee_rate_no = 0;</script>
						
						<div class="category-box">
							<div class="menu-header expanded" >
								<div class="menu-title index hasItems">07</div>
								<div class="menu-title"><span class="title">기타</span></div>
							</div>
							
							<div class="content ca">
								<div class="cmb-item">
									<span>탁송</span>
									<select name="" id="tagsong">
										<option value="없음" data-price="0">없음</option>
										<option value="서울" data-price="65000">서울</option>
										<option value="경기" data-price="90000">경기</option>
										<option value="인천" data-price="75000">인천</option>
										<option value="강원" data-price="160000">강원</option>
										<option value="대전" data-price="110000">대전</option>
										<option value="세종" data-price="110000">세종</option>
										<option value="충북" data-price="150000">충북</option>
										<option value="충남" data-price="150000">충남</option>
										<option value="부산" data-price="190000">부산</option>
										<option value="대구" data-price="170000">대구</option>
										<option value="울산" data-price="190000">울산</option>
										<option value="경북" data-price="190000">경북</option>
										<option value="경남" data-price="200000">경남</option>
										<option value="광주" data-price="170000">광주</option>
										<option value="전북" data-price="160000">전북</option>
										<option value="전남" data-price="220000">전남</option>
									</select>
								</div>
								
								<div class="cmb-item">
									<span>블랙박스</span>
									<select name="" id="blackbox">
                            							 <option value="모비스" data-price="250000">모비스</option>
                           							</select>      								
								</div>
								<div class="cmb-item">
									<span>추가수수료(1.0 ~ 3.0%)</span>
									<input class="" type="number" id="commission" name="commission" placeholder="" min="0.0" max="3.0" step="0.1"/>%
								<span style="color:red">무심사의 경우 추가수수료가 적용 되지 않습니다.</span>
								</div>
							</div>
							<span style="color:red; margin-left:40px; ">* 제주지역은 목포까지만 차량 탁송이 가능합니다.</span> 
							
						</div>
						</c:if>
					</div>


					<!-- 견적 결과 -->
					<div class="longterm-result">
						<div id="car-image">
							<img src="${RPATH}/images/로고배경.png" alt="차량이미지"></img>
						</div>
						
						<div class='notice'><img src="${RPATH }/images/notice.png" alt="안내문" /></div>
						<div class="rentcontent">
							<div class="row">
								<div class="left">모델</div>
								<div class="right result" id="carname"></div>
							</div>
							
							<div class="row">
								<div class="left">기본가격</div>
								<div class="right result" id="car-price"></div>
							</div>
							
							<div class="row">
								<div class="left">추가 옵션</div>
								<div class="right result" id="option-price"></div>
							</div>

							<div class="row">
								<div class="left">색상</div>
								<div class="right result" id="color-name"></div>
							</div>

							<div class="row">
								<div class="left">총 차량가</div>
								<div class="right result" id="price-total"></div>
							</div>
<!--  
							<div class="row">
								<div class="left">보증금</div>
								<div class="right result" id="deposit-summary"></div>
							</div>
	
							<div class="row">
								<div class="left">계약기간</div>
								<div class="right result" id="period-summary"></div>
							</div>
-->	
							&nbsp;&nbsp;공통사항
						     <div class="row">
						<div class="left">주행거리</div>
                                    
						<select id="distance-summary" class="right result" >
							<option value="30000" selected>3만km/년 </option>
							<option value="20000">2만km/년</option>
							
						</select>
					</div>

						</div>
					</div>

					
				</div> <!-- 견적 -->
			</section>
		</div>


<h2 style="text-align : center; margin-top:100px;">상품별 견적 비교</h2>

<div style="max-width: 1200px;height:150px;margin: 30px auto;">						

	<div id="totalrent">
		<input type="checkbox" id="choice" name="choice" data-name="하이렌트" data-id="hi"><span id = "total-sub"> &nbsp;&nbsp;하이렌트</span>
			<ul >
				<li class="toggle-select-row2 selected">
					<div class="cmb-item2">
					<span>보증금</span>
						<select name="depositratio_hi" id="depositratio_hi">
							<option value="0.1">10%</option>
							<option value="0.15">15%</option>
							<option value="0.2">20%</option>
							<option value="0.25">25%</option>
							<option value="0.3">30%</option>
							<option value="0.35">35%</option>
							<option value="0.4">40%</option>
							<option value="0.45">45%</option>
						</select><span id="deposit_hi" class="result" style="display:inline-block;width:130px;text-align:right;font-size:14px;"></span>
					</div>
					<div class="cmb-item2">
						<span>선납금</span>
						<input class="" type="number" id="preprice_hi" placeholder=""  min="0" max="10000" step="1" style="width:50%"/>만원
					</div>
					<div class="cmb-item2">
						<span>계약기간</span>
						<select name="" id="period_hi">
							<option value="48">48</option>
							<option value="36">36</option>
							<option value="24">24</option>
						</select>
					</div>
					<div> <span id="rentfee_hi" class="result">0원/월</span></div>
				</li>
			</ul>
		</div>

						<!-- 보증금 -->
		<div id="totalrent">
			<input type="checkbox" id="choice" name="choice" data-name="마이렌트" data-id="my"><span id = "total-sub"> &nbsp;&nbsp;마이다스렌트</span>
				<ul>
					<li class="toggle-select-row2 selected">
						<div class="cmb-item2" >
							<span>보증금</span>
							<label for="option-10943">50%</label>
							<span id="deposit_my" class="result" style="display:inline-block;width:130px;text-align:right;font-size:14px;"></span>
						</div>
						<div class="cmb-item2">
							<span>선납금</span>
							<input class="" type="number" id="preprice_my" placeholder="" min="0" max="10000" step="1" style="width:50%"/>만원
						</div>														
						<div class="cmb-item2">
							<span>계약기간</span>
								<select name="" id="period_my">
									<option value="48">48</option>
									<option value="36">36</option>
								</select>
						</div>
						<div> <span id="rentfee_my" class="result">0원/월</span></div>
					</li>
				</ul>
		</div>

						<!-- 보증금 -->
		<div id="totalrent">
			<input type="checkbox" id="choice" name="choice" data-name="오너형" data-id="ou"><span id = "total-sub"> &nbsp;&nbsp;오너형</span>
			<ul>
				<li class="toggle-select-row2 selected">
					<div class="cmb-item2">
						<span>초기비용</span>
						<select name="" id="depositratio_ou">
							<option value="0.7">70%</option>
							<option value="0.8">80%</option>
							<option value="1.0">전액</option>
						</select>
						<span id="deposit_ou" class="result" style="display:inline-block;width:110px;text-align:right;font-size:14px;"></span>
					</div>
					<div class="cmb-item2" style="visibility:hidden;">
						<span>선납금</span>
						<input class="" type="number" id="preprice_ou" placeholder="" min="0" max="10000" step="1" style="width:50%"/>만원
					</div>
					<div class="cmb-item2">
						<span>계약기간</span>
						<select name="" id="period_ou">
							<option value="48">48</option>
							<option value="36">36</option>
						</select>
					</div>
					<div> <span id="rentfee_ou" class="result">0원/월</span></div>
				</li>
			</ul>
		</div>

						<!-- 보증금 -->
		<div id="totalrent">
					<input type="checkbox" id="choice" name="choice" data-name="무심사" data-id="no"><span id = "total-sub"> &nbsp;&nbsp;무심사</span>
					<ul>
						<li class="toggle-select-row2 selected">
							<div class="cmb-item2">
							<span>보증금</span>
							<label for="option-10943" id="depositrate_no">10%</label>
							<span id="deposit_no" class="result" style="display:inline-block;width:130px;text-align:right;font-size:14px;"></span>
							</div>
							<div class="cmb-item2">
							<span>선납금</span>
							<input class="" type="number" id="preprice_no" placeholder="" min="0" max="10000" step="1" style="width:50%"/>만원
							</div>							

							<div class="cmb-item2">
							<span>계약기간</span>
								<select name="" id="period_no">
									<option value="0.2">48</option>
								</select>
							</div>
							<div> <span id="rentfee_no" class="result">0원/월</span></div>
						</li>
					</ul>
		</div>
							
</div>


<c:if test="${userLevel <= 0 || empty userLevel }">
					<div style="text-align : center;">
                  
						<div class="add-info flex-center">
            <form name="f" method="post" style="color:red; font-weight:bold;">
            <input type="checkbox" id="ck1" name="ck[]" value="y" checked="checked" onclick="check()" > 개인정보 수집 동의

</form>
                            <a href="javascript:check()"><input type="text" id="customer" name="customer" placeholder="고객이름"/> </a>
							<a href="javascript:check()"><input type="tel" id="phone" name="tel" placeholder="010-1234-5678" pattern="(010)-\d{3,4}-\d{4}" title="연락처"/></a>
							<a href="javascript:check()"><input type="number" id="authNumber" name="authNumber" placeholder="인증번호" class="authNumber" style="display:none" maxlength=6 /></a>
							<button id="authHpno" style="background-color:rgb(0 123 255 / 48%);" name="authHpno">인증번호받기</button>
						</div>
					</div>
</c:if>		
<div id="btn-estimate2" onclick="change();changedaum();">고객용 상세견적서 보기</div>
		
		
<!-- 광고 -->
	<!--	<div id="lower-section"></div>
		<style>

		</style>
		
		<div class="adsbox">
			<img src="${RPATH}/images/견적서하단내용.png" alt="" />
			<img src="${RPATH}/images/견적서하단내용2.png" alt="" />
		</div>

		<form action=""></form> -->
	</main>
 <script>
car.blackbox = "모비스";
car.blackbox_price = "250000";
</script> 
	
<script>
window.addEventListener("load", function() {
/*	
	car.deposit_ratio = 0.1;
	car.period = 48;
	car.depositratio_ou = 0.7;
	car.period_ou = 48;
	
	input = document.getElementById("sel-type");
	input.focus();
	input.value = "H";
*/
});
</script>

<%@ include file="./estimate/estimate-form_tot.jsp" %>
<%@ include file="popupmodal.jsp" %>


    </div>

</body>
</html>
	