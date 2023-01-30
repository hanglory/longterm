<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 공통변수 처리 -->
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RPATH" value="${CPATH}" scope="application"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />


<meta name="title" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta name="description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta name="keywords" content="신차장기렌트,중고장기렌트, 24개월장기렌트,1년렌트, 자동차일시불, 자동차할부, 자동차구매,장기렌트보증금">
<meta property="og:site_name" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta property="og:type" content="wepsite">
<meta property="og:title" content="(주)하모니렌트카">
<meta property="og:description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta property="og:image" content="">
<meta property="og:url" content="harmonyrent.co.kr">


<title><tiles:getAsString name="title"></tiles:getAsString></title>
<!--  <link rel="stylesheet" href="${RPATH}/css<tiles:getAsString name="IncludeCSS"/>.css" /> -->
<link rel="stylesheet" href="${RPATH}/css/admin.css" />
<link rel="stylesheet" href="/css/static.css">
<link rel="stylesheet" href="/css/adm-form.css"> 
<link rel="shortcut icon" href="${RPATH }/images/favicon.ico" type="image/x-icon">
<!-- include libraries(jQuery, bootstrap) --> 
<script src="//code.jquery.com/jquery-3.5.1.min.js"></script> 

<!--  <script src="${RPATH}/js/longterm.js"></script>  -->

<script>
	var baseUrl = "${CPATH}/"; 
</script>
</head>
<body>
		<tiles:insertAttribute name="header" />
			<!-- aside 부분 -->
<!-- 			<div class="aside"> -->
<%-- 				<tiles:insertAttribute name="nav" /> --%>
<!-- 			</div> -->
		
			<!-- content 부분 -->
    	<tiles:insertAttribute name="body" />
</body>
</html>