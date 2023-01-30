<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/member-estimate.css" />
<link rel="stylesheet" href="/css/baseMember.css" />

<style>
#memo {
	border: none;
	outline: none;
	resize: none;
}

select#state-sel {
	padding : 0 20px 0 0;
	border: none;
	outline: none;
	-webkit-appearance:none;
	-moz-appearance: none;
	appearance: none;
	background-color: transparent;
	background: url('${RPATH}/images/arrow-down.png') no-repeat 98% 50% ;
	background-size: 20%;
}
select#state-sel::-ms-expand{ 
	display: none; /* 화살표 없애기 for IE10, 11*/
}


</style>
<script>

	// 팝업노출
function showLayerPopup() {
	alert('test');
	$('#layerPopup').after("<div id='dim'/>");
	$('#layerPopup').css("display", "block");

//	document.querySelector('.optionBox').style.display = "none";
//	document.querySelector('.main').style.display = "block";
}

	// 팝업닫기
	function closeLayerPopup(){
		$('#layerPopup').css("display","none");
		$('div#dim').remove();
	}

</script>

<table id="detail" data-id='${estimate.estimate_no}'>
	<tr>
		<th>항목</th>
		<th>내용</th>
	</tr>
	<tr>
		<td>견적번호</td>
		<td>${estimate.type}${estimate.estimate_no}</td>
	</tr>
	<tr>
		<td>차량</td>
		<td>${car.maker} - ${car.model_name } - ${car.lineup } - ${car.trim_name }</td>
	</tr>
	<tr>
		<td>차량가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty car.price ? 0 : car.price}" /> 원</td>
	</tr>

	<tr>
		<td>옵션가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.option_price ? 0 : estimate.option_price}" /> 원</td>
	</tr>
	
	<tr>
		<td>색상</td>
		<td>
			${color.color_name }
			<c:if test="${not empty color.price and color.price != 0}"> 
			(+ <fmt:formatNumber type="number" maxFractionDigits="3" value="${color.price}" /> 원)
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td>총 가격</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${car.price + estimate.option_price + color.price}" /> 원</td>
	</tr>

	<tr>
		<td>선택옵션</td>
		<td>
			<ul>
			<c:forEach items="${options }" var="option">
				<li>${option.name }</li>
			</c:forEach>
			</ul>
		</td>
	</tr>
	<tr>
		<td>주행거리</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.distance ? 0 : estimate.distance/10000 }" /> 만KM</td>
	</tr>
	<tr>
		<td>계약기간</td>
		<td>${estimate.period }개월</td>
	</tr>

	<tr>
		<td>월렌트료</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.rentfee ? 0 : estimate.rentfee }" /> 원</td>
	</tr>

	<tr>
		<td>보증금</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.deposit ? 0 : estimate.deposit }" /> 원</td>
	</tr>
	<tr>
		<td>만기인수가</td>
		<td>
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.acquisition ? 0 : estimate.acquisition }" /> 원
			<c:if test="${userLevel == 10 }"> 
				<c:if test="${fn:indexOf(estimate.type,'H') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'N') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.1)*100 }" pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.1)*100 }" pattern="#.##"/>	%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'M') >= 0 }">
					<c:choose>
						<c:when test="${estimate.period == 24}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga24+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 36}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga36+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
						<c:when test="${estimate.period == 48}">
							/ 잔가(<fmt:formatNumber type="number" value="${(car.janga48+0.04)*100 }"  pattern="#.##"/>%)
						</c:when>
					</c:choose>
				</c:if>
				<c:if test="${fn:indexOf(estimate.type,'O') >= 0 }">
							/ 잔가(0%)
				</c:if>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>수수료</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${estimate.agent_fee }" /> (${estimate.agent_fee_rate } %)</td>
	</tr>	
	<tr>
		<td>탁송</td>
		<td>${estimate.tagsong }</td>
	</tr>
	
	<tr>
		<td>블랙박스</td>
		<td>${estimate.blackbox }</td>
	</tr>
	
	<tr>
		<td>기타 비용</td>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${empty estimate.etcprice ? 0 : estimate.etcprice}" /> 원</td>
	</tr>
	
	<tr>
		<td>고객</td>
		<td>
			${estimate.customer } / ${estimate.tel } / ${estimate.email }
		</td>
	</tr>
		
	<tr>
		<td>진행상황</td>
		<td>
			
			<select name="" id="state-sel">
				<option value="문의" <c:if test="${estimate.state=='문의'}">selected </c:if> >문의</option>
				<option value="상담보류" <c:if test="${estimate.state=='상담보류'}">selected </c:if> >상담보류</option>
				<option value="상담취소" <c:if test="${estimate.state=='상담취소'}">selected </c:if> >상담취소</option>
				<option value="계약" <c:if test="${estimate.state=='계약'}">selected </c:if> >계약</option>
				<option value="출고완료" <c:if test="${estimate.state=='출고완료'}">selected </c:if> >출고완료</option>
				<option value="계약취소" <c:if test="${estimate.state=='계약취소'}">selected </c:if> >계약취소</option>

			</select> 
		</td>
	</tr>

	<tr>
		<td>메모</td>
		<td>
			<textarea id="memo" placeholder="메모를 작성하세요" rows="10" style="width:100%;">${estimate.memo }</textarea>
		</td>
	</tr>
</table>


