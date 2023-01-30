<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.harmony.longterm.session.SessionConfig" %> 

<link rel="stylesheet" href="${RPATH}/css/header_menu_mem.css" />
<style>
.navbar {
	border: none;
	border-radius: 0;
}

.navbar-default {
	background-color: #194959;
}

.navbar-default .navbar-brand {
	color: #d7e2e9;
}

.navbar-default .navbar-brand:hover, .navbar-default .navbar-brand:focus
	{
	color: #e5dbdb;
}

.navbar-default .navbar-text {
	color: #d7e2e9;
}

.navbar-default .navbar-nav>li>a {
	color: #d7e2e9;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus
	{
	color: #e5dbdb;
}

.navbar-default .navbar-nav>li>.dropdown-menu {
	background-color: #69899f;
}

.navbar-default .navbar-nav>li>.dropdown-menu>li>a {
	color: #d7e2e9;
}

.navbar-default .navbar-nav>li>.dropdown-menu>li>a:hover,
	.navbar-default .navbar-nav>li>.dropdown-menu>li>a:focus {
	color: #e5dbdb;
	background-color: #425766;
}

.navbar-default .navbar-nav>li>.dropdown-menu>li>.divider {
	background-color: #69899f;
}

.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:hover,
	.navbar-default .navbar-nav>.active>a:focus {
	color: #e5dbdb;
	background-color: #425766;
}

.navbar-default .navbar-nav>.open>a, .navbar-default .navbar-nav>.open>a:hover,
	.navbar-default .navbar-nav>.open>a:focus {
	color: #e5dbdb;
	background-color: #425766;
}

.navbar-default .navbar-toggle {
	border-color: #425766;
}

.navbar-default .navbar-toggle:hover, .navbar-default .navbar-toggle:focus
	{
	background-color: #425766;
}

.navbar-default .navbar-toggle .icon-bar {
	background-color: #d7e2e9;
}

.navbar-default .navbar-collapse, .navbar-default .navbar-form {
	border-color: #d7e2e9;
}

.navbar-default .navbar-link {
	color: #d7e2e9;
}

.navbar-default .navbar-link:hover {
	color: #e5dbdb;
}


.container-fluid::after {
	display:block;
	content: "";
	clear: both;
}
.company-logo {
	--display: none;
	float: left;
} 

@media ( max-width : 767px) {
	.navbar-default .navbar-nav .open .dropdown-menu>li>a {
		color: #d7e2e9;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>li>a:hover,
		.navbar-default .navbar-nav .open .dropdown-menu>li>a:focus {
		color: #e5dbdb;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>.active>a,
		.navbar-default .navbar-nav .open .dropdown-menu>.active>a:hover,
		.navbar-default .navbar-nav .open .dropdown-menu>.active>a:focus {
		color: #e5dbdb;
		background-color: #425766;
	}
	

}

.login-info {
	border-bottom: 1px solid #ccc;
	text-align: right;
	padding: 0px 20px;
}

.login-info span {
	margin: 0px;
	padding: 0px;
}

.login-info button {
	--display: inline-block;
	text-decoration: none;
	border: none;
	background-color: rgb(42, 145, 180);
	color: #fff;
	margin: 0;
	padding: 4px;
	min-width: 80px;
}
</style>

<header class="noselect">
		<div class="login-info">
			<span>${userId} 님</span>
			<button onclick="location.href='${CPATH}/member/${userId}/estimatelist';">마이페이지</button>
			<c:if test="${userLevel == 10 }">
			<button onclick="location.href='${CPATH}/admin/estimatelist'" value="관리자">관리자</button>
			</c:if>
			<button onclick="javascript:logout();" value="로그아웃">로그아웃</button>
		</div>
</header>
    <nav class="nav_head_menu">
<!--    
      <div class="logo__nav">
        <a href="/main"><img src="${RPATH}/images/logo2.png" alt="" /></a>
      </div>
 -->       
      <ul class="nav-links">
            <li><a href="${CPATH}/">홈</a></li>
            <li><a href="${CPATH}/totalrent">전체견적</a></li>
            <li><a href="${CPATH}/download">계약/설명서</a></li>
 <c:if test="${userLevel >= 5 }">           
            <li><a href="${CPATH}/member/${userId}/bankAccountMy">전용계좌 발급</a></li>
 </c:if>

      </ul>
    
    </nav>      
 <script>
// 메뉴 768 이하일때 햄버거 메뉴로 변경하고 클릭시 메뉴리스트 보여줌.
const burger = document.querySelector(".burger");
const nav = document.querySelector(".nav-links");
const navlinks = document.querySelectorAll(".nav-links li");
const navAnimation = () => {
  navlinks.forEach((link, index) => {
    // 애니메이션이 있을 때
    if (link.style.animation) {
      // 애니메이션 비움
      link.style.animation = "";
    } else {
      // 애니메이션 없을 때 애니메이션을 추가
      // 딜레이 간격을 줘서 li가 하나씩 차례대로 나타나도록 설정
      
      link.style.animation = `navLinkFade 0.0s ease forwards ${
        index / 7 + 0.0       
      }s`;
    }
  });
};
const handleNav = () => {
  nav.classList.toggle("nav-active");
  //nav Animation
  navAnimation();
  //burger Animation
  burger.classList.toggle("toggle");
};
const navSlide = () => {
  burger.addEventListener("click", handleNav);
};

const setNavTransition = (width) => {
  if (width > 768) {
    nav.style.transition = "";
  } else {
    nav.style.transition = "transform 0.5s ease-in";
  }
};

const handleResize = () => {
  const width = event.target.innerWidth;
  setNavTransition(width);
};

const init = () => {
  // Toggle Nav
  window.addEventListener("resize", handleResize);
  navSlide();
};

init();
</script>
 
<script>
	function logout() {
		location.replace('${CPATH}/user/logout');
	}

</script>
