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
<meta name="naver-site-verification" content="2f6c71088cc6a9b941612c4591a23a0d11b5644f" />
<meta name="google-site-verification" content="ZygN6jHeo4iTbJ_wbhJr4qYAbrGwssMe-JwCXFSdDWA" />

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

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W7CQQ8B');</script>
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