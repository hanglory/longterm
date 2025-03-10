<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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

<script>
	function logout() {
		location.replace('${CPATH}/user/logout');
	}

</script>

<header class="noselect">
<c:if test="${userLevel > 0 }">
		<div class="login-info">
			<span>${userId} 님</span>
			<button onclick="location.href='${CPATH}/member/${userId}/estimatelist';">마이페이지</button>
			<c:if test="${userLevel > 1 }">
			<button onclick="location.href='${CPATH}/admin/estimatelist'" value="관리자">관리자</button>
			</c:if>
			<button onclick="javascript:logout();" value="로그아웃">로그아웃</button>
		</div>
</c:if>		
		<div class="logo">
			<a href="${CPATH}/">
				<img src="${RPATH}/images/logo.png" alt="" />
			</a>
		</div>
</header>


<nav class="pc-menu">
	<h1 class="no-disp">PC MENU</h1>
	<div class="menu-board clearfix">
           
	<ul class="nav-menu ">
		<li class="menu-item">
			<a href="${CPATH}/">
			<div class="middle"><span>홈</span></div>
			</a>
		</li>
		<li class="menu-item">
			<a href="${CPATH}/totalrent">
	    	<div class="middle"><span>견적내기</span></div>
			</a>
		</li>
		
		<li class="menu-item">
	    	<div class="middle"><span>즉시출고</span></div>
          <ul class="sub_menu">
            <li class="sub_item"><a href="${CPATH}/bbs/usedcarRealNew">신차렌트</a></li>
            <li class="sub_item"><a href="${CPATH}/bbs/usedcarReal">중고렌트</a></li>
          </ul>
		</li>
		
		<li class="menu-item">
	    	<div class="middle"><span>게시판</span></div>
          <ul class="sub_menu">
            <li class="sub_item"><a href="${CPATH}/bbs/board">자료실</a></li>
            <li class="sub_item"><a href="${CPATH}/bbs/board_faq">F a Q</a></li>
          </ul>
		</li>
<c:if test="${userLevel > 0 }">
        <li class="menu-item">
           <a href="/download"><div class="middle"><span>다운로드</span><span style="font-size:17px;">(계약서,설명서)</span></div></a>
       	</li>
</c:if>       	
	</ul>
	</div>
</nav>
