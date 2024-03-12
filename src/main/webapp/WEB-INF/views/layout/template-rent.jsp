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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="naver-site-verification" content="2f6c71088cc6a9b941612c4591a23a0d11b5644f" />
<meta name="google-site-verification" content="ZygN6jHeo4iTbJ_wbhJr4qYAbrGwssMe-JwCXFSdDWA" />
<meta name="title" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta name="description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta name="keywords" content="신차장기렌트,중고장기렌트, 24개월장기렌트,1년렌트, 자동차일시불, 자동차할부, 자동차구매,장기렌트보증금">
<meta property="og:site_name" content="하모니렌트카의 특별한 렌트  I 하모니크">
<meta property="og:type" content="wepsite">
<meta property="og:title" content="(주)하모니렌트카">
<meta property="og:description" content=" 장기렌트의 모든 솔루션을 하모니렌트카에서 제공합니다. 24개월 신차장기렌트부터 중고장기렌트, 오너형장기렌트까지  합리적인 가격. 온라인 간편 견적신청가능 ">
<meta property="og:image" content="">
<meta property="og:url" content="harmonyrent.co.kr">


<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10978682224">

  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-10978682224');


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-239736615-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-239736615-1');
 gtag('config', 'G-88TSB93GWD');
</script>

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W6VW6MC');</script>
<!-- End Google Tag Manager -->

<!-- Smartlog -->
<script type="text/javascript"> 
    var hpt_info={'_account':'UHPT-19533', '_server': 'a23'};
</script>
<script language="javascript" src="//cdn.smlog.co.kr/core/smart.js" charset="utf-8"></script>
<noscript><img src="//a23.smlog.co.kr/smart_bda.php?_account=19533" style="display:none;width:0;height:0;" border="0"/></noscript> 


 <script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/kas/static/kp.js"></script>
<script type="text/javascript">
      kakaoPixel('3481025403756984027').pageView('1');
</script>   
    
    
<title><tiles:getAsString name="title"></tiles:getAsString></title>
<%-- <link rel="stylesheet" href="${RPATH}/css<tiles:getAsString name="IncludeCSS"/>.css" /> --%>
<link rel="stylesheet" href="/css/header_menu.css" />
<link rel="stylesheet" href="${RPATH}/css/base.css" />
<link rel="shortcut icon" href="${RPATH }/images/favicon.ico" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:choose>
	<c:when test="${fn:indexOf(URI,'tot') >= 0 }">
		<script src="${RPATH}/js/longterm.js"></script>
	</c:when>
	<c:otherwise>
		<script src="${RPATH}/js/longterm.js"></script>
	</c:otherwise>
</c:choose>
<style>

body {
	margin: 0;
	padding: 0;
}
</style>

<script>
	var baseUrl = "${CPATH}/"; 
</script>
</head>
<body>

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-W6VW6MC"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

	<tiles:insertAttribute name="header" />
    <div id="container">
       <tiles:insertAttribute name="body" />
    </div>
    <tiles:insertAttribute name="footer" />


</body>
</html>