<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 공통변수 처리 -->
<c:set var="URI" value=" ${requestScope['javax.servlet.forward.request_uri']}" scope="application"/>
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RPATH" value="${CPATH}" scope="application"/>
<c:set var="MEMBERS" value="0" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- 안드로이드 홈화면추가시 상단 주소창 제거 -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" href="/images/favicon.ico">
<!-- ios홈화면추가시 상단 주소창 제거 -->
<meta name="apple-mobile-web-app-capable" content="yes">

<title><tiles:getAsString name="title"></tiles:getAsString></title>
<!-- link rel="stylesheet" href="${RPATH}/css<tiles:getAsString name="IncludeCSS"/>.css" / -->
<link rel="stylesheet" href="/css/header_menu.css" />
<link rel="stylesheet" href="${RPATH}/css/base-m.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <link href="css/bootstrap.min.css" rel="stylesheet"> -->

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

</style>

<script>
	var baseUrl = "${CPATH}/"; 
</script>

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W7CQQ8B');</script>
<!-- End Google Tag Manager -->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-0C1034LNQW"></script>

<!-- Global site tag (gtag.js) - Google Ads: 779171832 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-779171832"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-779171832');
</script>
<!-- Event snippet for 모바일전화 conversion page
In your html page, add the snippet and call gtag_report_conversion when someone clicks on the chosen link or button. -->
<script>
function gtag_report_conversion(url) {
  var callback = function () {
    if (typeof(url) != 'undefined') {
      window.location = url;
    }
  };
  gtag('event', 'conversion', {
      'send_to': 'AW-779171832/klS5CLOm5M4BEPjvxPMC',
      'event_callback': callback
  });
  return false;
}
</script>


</head>
<body>


	<tiles:insertAttribute name="header" />
    <div id="container">
       <tiles:insertAttribute name="body" />
    </div>
    <tiles:insertAttribute name="footer" />

<!-- Google Tag Manager (noscript)  -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-W7CQQ8B"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->


</body>
</html>