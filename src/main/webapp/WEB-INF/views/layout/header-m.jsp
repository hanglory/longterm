<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.harmony.longterm.session.SessionConfig" %> 

<style>


.logo {
	--position: relative;
}


header {
	--height: var(--logo-height);
	z-index: 10;
	background: #fff;
	position: sticky;
	top: 0px;
	border-bottom: 1px solid #e7e7e7;
	border-top: 1px solid #e7e7e7;
}

.logo-img {
	width: 200px;
	height: 50%;
	--padding: 25% 0;
	--border-bottom: 1px solid #e7e7e7;
	text-align: center;
	padding: 10px 0;
	display: block;
	margin: 0 auto;
}

header ul {
	--height: var(--logo-height);
	display: table;
	table-layout: fixed;
	width: 100%;
	
}

header ul:after {

}

header li {
	display: table-cell;
	position: relative;
	text-align: center;
	height: var(--logo-height);
	vertical-align : middle;
}

header .selected:after {
	position: absolute;
	width: 80%;
	height: 3px;
	bottom: 10px;
	left: 10%;
	border-bottom: 3px solid #000;
	content: "";
}

header li a {
	text-decoration: none;
	color: #000000;
}
</style>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-0C1034LNQW"></script>

<a href="${CPATH}/"><img class="logo-img" src="${RPATH}/images/logo2.png" alt="" align="middle"></a>

<header class="header-box">
	<ul>
		<li><a href="${CPATH}/">홈</a></li>
		<li><a href="${CPATH}/company">회사소개</a></li>  
		<li><a href="${CPATH}/totalrent">전체견적</a></li>
        <li><a href="${CPATH}/bbs/usedcarRealNew">즉시출고신차</a></li>
        <li><a href="${CPATH}/bbs/usedcarReal">즉시출고중고</a></li>
        <li><a href="${CPATH}/bbs/board">자료실</a></li>
		<li><a href="${CPATH}/bbs/board_faq">FaQ</a></li>
<c:if test="${userLevel > 0 }">
        <li><a href="/download">계약/설명서</a></li>
</c:if>
	<c:if test="${userLevel > 1 }">
		<li><a href="${CPATH}/admin/estimatelist">관리자</a></li>
	</c:if>

<div id="tbtn2" style="width: 80px;"> 
            <a href="tel:1588-5802"><img src ="images/btn_call2.png"/></a>
	      </div>		
	</ul>
</header>


