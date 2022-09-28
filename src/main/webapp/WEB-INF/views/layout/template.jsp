<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 공통변수 처리 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />

<title><tiles:getAsString name="title"></tiles:getAsString></title>
<link rel="stylesheet" href="resources/css<tiles:getAsString name="IncludeCSS"/>.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>

body {
	margin: 0;
	padding: 0;
}
</style>


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