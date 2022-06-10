<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	location.href="/totalrent";
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


header, footer {
	min-width: 1200px;
}

.pc-menu {
	min-width: 1200px;
}
</style>	

	<main>
		<div class="context-box">
			<section>
				<h1 class="no-disp">장기렌트 견적 항목</h1>

				<div>
					<img src="${RPATH}/images/HIRENT2년약정렌트.png" alt="" align="middle"/>
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
						<span class="title-notice">  ※ 각 제조사 모델 변경은 실시간 반영이 어려우므로, 
						다소 차이가 있을 수 있습니다. 자세한 사항은 문의 주십시요.
						</span>
						<span class="title-notice">
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

						<!-- 계약기간 -->
						<div class="category-box">
							<div class="menu-header folder expanded" id="period-header">
								<div class="menu-title index hasItems">07</div>
								<div class="menu-title"><span class="title">계약기간</span></div>
							</div>

							<div class="content">
								<ul id="period" style="width:95%;">
									<li class="period">
										<div class="toggle-select-row">
											<div class="toggle-select__item">
												<input type="radio" id="period-48" name="period" value="48" checked/>
												<label for="period-48"><span>48개월</span></label>
											</div>
										</div>
									</li>
									<li class="period">
										<div class="toggle-select-row">
											<div class="toggle-select__item">
												<input type="radio" id="period-36" name="period" value="36" />
												<label for="period-36"><span>36개월</span></label>
											</div>
										</div>
									</li>
									<li class="period">
										<div class="toggle-select-row">
											<div class="toggle-select__item">
												<input type="radio" id="period-24" name="period" value="24" />
												<label for="period-24"><span>24개월</span></label>
											</div>
										</div>
									</li>
								</ul>

							</div>
						</div>

						
						<!-- Agent를 위한 항목 -->
						<c:if test="${MEMBERS > 0}">

						<!-- 보증금 -->
						<div class="category-box">
							<div class="menu-header expanded" id="period-header">
								<div class="menu-title index hasItems">08</div>
								<div class="menu-title"><span class="title">보증금</span></div>
							</div>

							<div class="content ca">
								<select name="" id="depositratio">
									<option value="0.1">10%</option>
									<option value="0.15">15%</option>
									<option value="0.2">20%</option>
									<option value="0.25">25%</option>
									<option value="0.3">30%</option>
									<option value="0.35">35%</option>
									<option value="0.4">40%</option>
									<option value="0.45">45%</option>
								</select>

							</div>
						</div>
						
						<div class="category-box">
							<div class="menu-header expanded" >
								<div class="menu-title index hasItems">09</div>
								<div class="menu-title"><span class="title">기타</span></div>
							</div>
							
							<div class="content ca">
								<div class="cmb-item">
									<span>탁송</span><br>
									<select name="" id="tagsong">
										<option value="없음" data-price="0">없음</option>
										<option value="서울" data-price="25000">서울</option>
										<option value="경기" data-price="40000">경기</option>
										<option value="인천" data-price="40000">인천</option>
										<option value="강원" data-price="100000">강원</option>
										<option value="대전" data-price="80000">대전</option>
										<option value="세종" data-price="80000">세종</option>
										<option value="충북" data-price="80000">충북</option>
										<option value="충남" data-price="80000">충남</option>
										<option value="부산" data-price="150000">부산</option>
										<option value="대구" data-price="150000">대구</option>
										<option value="울산" data-price="150000">울산</option>
										<option value="경북" data-price="120000">경북</option>
										<option value="경남" data-price="150000">경남</option>
										<option value="광주" data-price="150000">광주</option>
										<option value="전북" data-price="120000">전북</option>
										<option value="전남" data-price="150000">전남</option>
										<option value="제주" data-price="320000">제주</option>
									</select>
								</div>
								
								<div class="cmb-item">
									<span>블랙박스</span><br>
									<select name="" id="blackbox">
										<option value="없음" data-price="0">없음</option>
										<option value="모비스" data-price="200000">모비스</option>
									</select>
								</div>
								
								<div class="cmb-item">
									<span>수수료</span><span>(0.0 ~ 3.0%)</span><br>
									<input class="" type="number" id="commission" placeholder="" min="0.0" max="3.0" step="0.1"/>%
								
								</div>

							</div>
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
								<div class="left">옵션가격</div>
								<div class="right result" id="option-price"></div>
							</div>

							<div class="row">
								<div class="left">색상</div>
								<div class="right result" id="color-name"></div>
							</div>

							<div class="row">
								<div class="left">합계</div>
								<div class="right result" id="price-total"></div>
							</div>

							<div class="row">
								<div class="left">보증금</div>
								<div class="right result" id="deposit-summary"></div>
							</div>
	
							<div class="row">
								<div class="left">계약기간</div>
								<div class="right result" id="period-summary"></div>
							</div>
	
							<div class="row">
								<div class="left">주행거리</div>
								<div class="right result" id="distance-summary"></div>
							</div>
	
							<c:if test="${MEMBERS > 0 }">
							<div class="row">
								<div class="left">수수료</div>
								<div class="right result" id="agency-fee-rate"></div>
							</div>
							</c:if>

						</div>

					
						<div class="resultfee">
							<div class="">고객님께서 선택하신 차량의 렌트료는</div>
							<div>월 <span id="rentfee" class="result">0원</span> 입니다.</div>
						</div>
						
						<div id="btn-estimate">고객용 상세견적서 보기</div>

					</div>
					
				</div> <!-- 견적 -->
			</section>
		</div>
		
		<!-- 광고 -->
		<div id="lower-section"></div>
		<style>

		</style>
		
		<div class="adsbox">
			<img src="${RPATH}/images/견적서하단내용.png" alt="" />
			<img src="${RPATH}/images/견적서하단내용2.png" alt="" />
		</div>

		<form action=""></form>
	</main>
	
<script>
window.addEventListener("load", function() {
	car.deposit_ratio = 0.1;
	car.period = 48;
	
	input = document.getElementById("sel-type");
	input.focus();
	input.value = "H";

});
</script>

<%@ include file="./estimate/estimate-form.jsp" %>
<%@ include file="popupmodal.jsp" %>
	