<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 공통변수 처리 -->
<c:set var="URI" value=" ${requestScope['javax.servlet.forward.request_uri']}" scope="application"/>
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RPATH" value="${CPATH}" scope="application"/>
<c:set var="MEMBERS" value="1" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- 안드로이드 홈화면추가시 상단 주소창 제거 -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" href="/images/favicon.ico">

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
<link rel="stylesheet" href="${RPATH}/css<tiles:getAsString name="IncludeCSS"/>.css" />
<link rel="stylesheet" href="${RPATH}/css/baseMember.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:choose>
	<c:when test="${fn:indexOf(URI,'tot') >= 0 }">
		<script src="${RPATH}/js/longterm_new-m.js"></script>
	</c:when>
	<c:otherwise>
		<script src="${RPATH}/js/longterm-m.js"></script>
	</c:otherwise>
</c:choose>
<style>

* {
	margin: 0;
	padding: 0;
  	-webkit-box-sizing: border-box;
          box-sizing: border-box;
	
}

html {
	height: 100%;
}
body {
	font-size:14px;
	font-family:"NanumGothic", "Nanum Gothic","Malgun Gothic",sans-serif;

}

.notice {
	font-size: 5em;
	font-weight: 900;
	text-align: center;
}
</style>

<script>
	var baseUrl = "${CPATH}/"; 
	var userLevel = "${userLevel}";
</script>

</head>
<body>

	<tiles:insertAttribute name="header" />
    <div id="container">
       <tiles:insertAttribute name="body" />
    </div>
    <tiles:insertAttribute name="footer" />
</body>
</html>