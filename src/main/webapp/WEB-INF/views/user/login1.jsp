<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=no, width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<link rel="stylesheet" href="../css/common.css" type="text/css"/>
<title>로그인</title>

<style>

	.login-input-wrap {
		--box-shadow: 0 0 2px 2px #444444;
	}
	
	.login-input-wrap input {
		border: none;
		width:330px;
		height:30px;
		font-size: 14px;
		margin-top: 10px;
		margin-left: 10px;
		box-shadow: 0 0 2px 0px #444444;
	}
	
	@media screen and (max-width: 768px) {
		.login-input-wrap input {
			width: 90%;
			margin: 5px auto;
		}
	}
	
	.bar {
		padding: 0 5px;
	}
</style>
</head>
<body>

	<div class="context-box" style="text-align: center;">
		<h1>사용자 로그인</h1>

		<c:if test="${userLevel==0}">
			<div class="login-input-wrap">
				<p style="color: red; padding: 50px;margin:0 auto;">PASSWORD가 일치하지 않습니다. 다시 입력해 주세요</p>
			</div>
		</c:if>
		
		<c:if test="${userLevel == -1 }">
			<div class="login-input-wrap">
				<p style="color: red; padding: 50px;margin:0 auto;">승인되지 않은 사용자입니다. 관리자에게 연락하세요.</p>
			</div>
		</c:if>
		
		<form action="${pageContext.request.contextPath}/user/loginPost" method="post">
			<div class="login-input-wrap">
				<input type="text" id="name" name="name" placeholder="이름을 입력하세요"/>
			</div>
			
			<div class="login-input-wrap">
				<input type="password" id="password" name="password" placeholder="암호를 입력하세요"/>
			</div>
			
			<div class="login-input-wrap">
				<input type="submit" value="로그인" />
			</div>
		</form>

		<br><br>
		<div>
			<a href="./searchid">아이디 찾기</a><span class="bar">|</span>
			<a href="#">비밀번호 찾기</a><span class="bar">|</span>
			<a href="#">회원가입</a>
		</div>
		<c:if test="${userLevel>0}">
			<p>${userId} 님이 입장하셨습니다.</p>
		</c:if>
		
		<c:if test="${userLevel == 10}">
			<a href="./regist">새 사용자 등록</a>
		</c:if>
	</div>
</body>
</html>