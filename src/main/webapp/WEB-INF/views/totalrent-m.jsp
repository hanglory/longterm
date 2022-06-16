<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


footer {
	min-width: 1200px;
}

header {

	display: table;
	width: 100%;
	margin: 10px 0px;
	border-bottom: 1px solid #000;
	font-family: "나눔스퀘어";
	font-size: 17px;

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

</style>	
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
			                    </ul>
							</div>
						</div>

				<div class="category-box-notice">
					<div class="menu-title">
						<span class="title-notice">  ※ 각 제조사 모델 변경은 실시간 반영이 어려우므로, <br>
						다소 차이가 있을 수 있습니다. 자세한 사항은 문의 주십시요.
						</span> <br>
						<span class="title-notice" style="color:red;">
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
						
						<div class="category-box">
								<div class="content" style="text-align:center;"><span style="font-size:18px;">총 차량가</span>
								<div style="font-size:18px; color:brown;" id="price-total"></div></div>
							</div>
						

						
						<!-- Agent를 위한 항목 -->
						<c:if test="${userLevel > 0 }">


						
						<div class="category-box">
							<div class="menu-header expanded" >
								<div class="menu-title index hasItems">09</div>
								<div class="menu-title"><span class="title">기타</span></div>
							</div>
							
							<div class="content ca">
								<div class="cmb-item">
									<span>탁송</span>
									<select name="" id="tagsong">
										
										<option value="없음" data-price="0">없음</option>
										<option value="서울" data-price="55000">서울</option>
										<option value="경기" data-price="80000">경기</option>
										<option value="인천" data-price="60000">인천</option>
										<option value="강원" data-price="140000">강원</option>
										<option value="대전" data-price="100000">대전</option>
										<option value="세종" data-price="100000">세종</option>
										<option value="충북" data-price="120000">충북</option>
										<option value="충남" data-price="110000">충남</option>
										<option value="부산" data-price="170000">부산</option>
										<option value="대구" data-price="150000">대구</option>
										<option value="울산" data-price="170000">울산</option>
										<option value="경북" data-price="150000">경북</option>
										<option value="경남" data-price="190000">경남</option>
										<option value="광주" data-price="160000">광주</option>
										<option value="전북" data-price="150000">전북</option>
										<option value="전남" data-price="190000">전남</option>
									</select>
								</div>
								
								<div class="cmb-item">
									<span>블랙박스</span>
									<select name="" id="blackbox">
										<option value="없음" data-price="0">없음</option>
										<option value="모비스" data-price="200000">모비스</option>
									</select>									
								</div>
								<div class="cmb-item">
									<span>추가수수료(0.0 ~ 3.0%)</span>
									<input class="" type="number" id="commission" placeholder="" min="0.0" max="3.0" step="0.1"/>%
								<br><span style="color:red">무심사의 경우 추가수수료가 적용 되지 않습니다.</span>
								</div>
							</div>
							<span style="color:red; margin-left:10px; "> 제주지역은 목포까지만 차량 탁송이 가능합니다.</span> 
							
							
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
							공통사항
							<div class="row">
								<div class="left">주행거리</div>
								<div class="right result" id="distance-summary"></div>
							</div>

						</div>
					</div>

					
				</div> <!-- 견적 -->
			</section>
		</div>


<h2 style="text-align : center; margin-top:100px;">상품별 견적 비교</h2>

<div style="max-width: 1200px;height:250px;margin: 30px auto;">						

	<div id="totalrent">
		<input type="checkbox" id="choice" name="choice" data-name="하이렌트" data-id="hi"><span id = "total-sub">&nbsp;하이렌트</span>
			<ul >
				<li class="toggle-select-row2 selected">
					<div class="cmb-item2">
					<span>보증금</span>
						<select name="" id="depositratio_hi">
							<option value="0.1">10%</option>
							<option value="0.15">15%</option>
							<option value="0.2">20%</option>
							<option value="0.25">25%</option>
							<option value="0.3">30%</option>
							<option value="0.35">35%</option>
							<option value="0.4">40%</option>
							<option value="0.45">45%</option>
						</select>
						<span id="deposit_hi" class="result" style="width:100%;"></span>	
					
					
						
					
					<div class="cmb-item2">
					<span>선납금</span>
						<input class="" type="number" id="preprice_hi" placeholder=""  min="0" max="10000" step="1" style="width:30%"/>만원	
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
			<input type="checkbox" id="choice" name="choice" data-name="마이렌트" data-id="my"><span id = "total-sub">&nbsp;마이다스렌트</span>
				<ul>
					<li class="toggle-select-row2 selected">
						<div class="cmb-item2" >
							<span>보증금</span>
							<label for="option-10943">50%</label>
							<span id="deposit_my" class="result" style="width:100%;text-align:left;"></span>
						</div>
						
							
						
						<div class="cmb-item2">
							<span>선납금</span>
							<input class="" type="number" id="preprice_my" placeholder="" min="0" max="10000" step="1" style="width:30%"/>만원
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
			<input type="checkbox" id="choice" name="choice" data-name="오너형" data-id="ou"><span id = "total-sub">&nbsp;오너형렌트</span>
			<ul>
				<li class="toggle-select-row2 selected">
					<div class="cmb-item2">
						<span>초기비용</span>
						<select name="" id="depositratio_ou">
							<option value="0.7">70%</option>
							<option value="0.8">80%</option>
							<option value="1.0">전액</option>
						</select>
						<span id="deposit_ou" class="result" style="width:100%;text-align:left;"></span>
					</div>
					<div class="cmb-item2" style="visibility:hidden;">
						<span>선납금</span>
						<input class="" type="number" id="preprice_ou" placeholder="" min="0" max="10000" step="1" style="width:30%"/>만원
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
					<input type="checkbox" id="choice" name="choice" data-name="무심사" data-id="no"><span id = "total-sub">&nbsp;무심사렌트</span>
					<ul>
						<li class="toggle-select-row2 selected">
							<div class="cmb-item2">
							<span>보증금</span>
							<label for="option-10943" id="depositrate_no">10%</label>
							<span id="deposit_no" class="result" style="width:100%;text-align:left;"></span>
							</div>
							
							
							
							<div class="cmb-item2">
							<span>선납금</span>
							<input class="" type="number" id="preprice_no" placeholder="" min="0" max="10000" step="1" style="width:30%"/>만원
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
<br><br>
						<div class="add-info flex-center">
							<input type="text" id="customer" name="customer" placeholder="   고객이름" style="height:35px; width:95%; margin-bottom:5px;"/>
							<input type="tel" id="phone" name="tel" placeholder="   010-1234-5678" pattern="(010)-\d{3,4}-\d{4}" title="연락처" style="height:35px;width:95%;margin-bottom:5px;"/><br>
							<input type="number" id="authNumber" name="authNumber" placeholder="   인증번호" class="authNumber" style="display:none;height:35px;width:95%;margin-bottom:5px;" maxlength=6 /><br>
							<button id="authHpno" style="background-color:rgb(0 123 255 / 48%);" name="authHpno" style="height:35px;">인증번호받기</button><br>
						</div>
					</div>
</c:if>

<div id="btn-estimate2">고객용 상세견적서 보기</div>		
		
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
window.addEventListener("load", function() {
	car.deposit_ratio = 0.1;
	car.period = 48;
	car.depositratio_ou = 0.7;
	car.period_ou = 48;
	
	input = document.getElementById("sel-type");
	input.focus();
	input.value = "H";

});
</script>

<%@ include file="./estimate/estimate-form_tot.jsp" %>
<%@ include file="popupmodal.jsp" %>





    </div>

</body>
</html>
	