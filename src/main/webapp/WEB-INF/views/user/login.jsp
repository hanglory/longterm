<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="RPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=no, width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<link rel="stylesheet" href="${RPATH}/css/common.css" type="text/css"/>
<link rel="stylesheet" href="${RPATH}/css/user.css" type="text/css"/>
<title>로그인</title>
<script type='text/javascript'> 
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

html, body {
	height: 100%;
}

h2 {
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  text-transform: uppercase;
  display:inline-block;
  margin: 40px 8px 10px 8px; 
  color: #cccccc;
}






/* TABS */

h2.inactive {
  color: #cccccc;
}

h2.active {
  color: #0d0d0d;
  border-bottom: 2px solid #5fbae9;
}






/* ANIMATIONS */

/* Simple CSS3 Fade-in-down Animation */
.fadeInDown {
  -webkit-animation-name: fadeInDown;
  animation-name: fadeInDown;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
}

@-webkit-keyframes fadeInDown {
  0% {
    opacity: 0;
    -webkit-transform: translate3d(0, -100%, 0);
    transform: translate3d(0, -100%, 0);
  }
  100% {
    opacity: 1;
    -webkit-transform: none;
    transform: none;
  }
}

@keyframes fadeInDown {
  0% {
    opacity: 0;
    -webkit-transform: translate3d(0, -100%, 0);
    transform: translate3d(0, -100%, 0);
  }
  100% {
    opacity: 1;
    -webkit-transform: none;
    transform: none;
  }
}

/* Simple CSS3 Fade-in Animation */
@-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@keyframes fadeIn { from { opacity:0; } to { opacity:1; } }

.fadeIn {
  opacity:0;
  -webkit-animation:fadeIn ease-in 1;
  -moz-animation:fadeIn ease-in 1;
  animation:fadeIn ease-in 1;

  -webkit-animation-fill-mode:forwards;
  -moz-animation-fill-mode:forwards;
  animation-fill-mode:forwards;

  -webkit-animation-duration:1s;
  -moz-animation-duration:1s;
  animation-duration:1s;
}

.fadeIn.first {
  -webkit-animation-delay: 0.4s;
  -moz-animation-delay: 0.4s;
  animation-delay: 0.4s;
}

.fadeIn.second {
  -webkit-animation-delay: 0.6s;
  -moz-animation-delay: 0.6s;
  animation-delay: 0.6s;
}

.fadeIn.third {
  -webkit-animation-delay: 0.8s;
  -moz-animation-delay: 0.8s;
  animation-delay: 0.8s;
}

.fadeIn.fourth {
  -webkit-animation-delay: 1s;
  -moz-animation-delay: 1s;
  animation-delay: 1s;
}

/* Simple CSS3 Fade-in Animation */
.underlineHover:after {
  display: block;
  left: 0;
  bottom: -10px;
  width: 0;
  height: 2px;
  background-color: #56baed;
  content: "";
  transition: width 0.2s;
}

.underlineHover:hover {
  color: #0d0d0d;
}

.underlineHover:hover:after{
  width: 100%;
}



/* OTHERS */

#icon {
  width:60%;
}


</style>
</head>
<body>

<div class="wrapper fadeInDown noselect">
  <div id="formContent">
    <!-- Tabs Titles -->
<!--     <h2 class="active"> Sign In </h2> -->
<!--     <h2 class="inactive underlineHover">Sign Up </h2> -->
	<h1 class="text-3d">Harmony RentCar</h1>
	
    <!-- Icon -->
    <div class="fadeIn first">
<%--       <img src="${RPATH}/images/logo.png" id="icon" alt="User Icon" /> --%>
    </div>

    <!-- Login Form -->
    <form action="${pageContext.request.contextPath}/user/loginPost" method="post">
      <input type="text" id="name" class="fadeIn second" name="name" placeholder="id" autofocus/>
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="password"/>
      <input type="submit" class="fadeIn fourth" value="Log In"/>
    </form>

	<c:if test="${userLevel > 0 }">
		<p>로그인 되어 있는 상태입니다</p>
		<a href="${CPATH}/member/">Member</a>
		<a href="${CPATH}/user/logout">로그아웃</a>
	</c:if>
	
    <div id="formFooter">
<!-- 			<a href="./searchid">아이디 찾기</a><span class="bar">|</span> -->
			<a href="./setpassword">비밀번호 재설정</a><span class="bar">|</span>
			<a href="./regist">회원가입</a>
    </div>

  </div>
</div>
</body>
</html>