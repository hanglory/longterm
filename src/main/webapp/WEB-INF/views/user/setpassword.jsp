<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="RPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${RPATH}/css/common.css" type="text/css"/>
	<link rel="stylesheet" href="${RPATH}/css/user.css" type="text/css"/>
	
	<title>비밀번호 설정</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
	</style>

</head>
<body>
<style>

html, body {
	margin: 0;
	height: 100%;
}

input.col2 {
	width: 100%;
}

h1 {
	--margin: 20px 0 50px 0;
}

label {
	position: relative;
	word-break: keep-all;
	font-weight: 900;
	
}
label.required::after {
	content: "*";
	position: absolute;
	top: -5px;
	left: -10px;
	color: #c32;
	font-size: 1.3em;
}

.green {
	color: green;
}

#terms-box {
	margin: 10px;
	padding: 10px;
	text-align: left;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: #fbfff3;
}

#terms-box p {
	padding: 0 20px;
	text-indent: 1em;
}

#btn-terms {
	float: right;
}

input[pattern]:invalid{
  color:red;
}

.wrapper {
	background-image: url("${RPATH}/images/others/sky-5376842_960_720.jpg");
	background-size: cover;
}

#formContent {
	opacity: 0.8;
}


</style>
<div class="wrapper">
	<div id="formContent">
		<h1 class="text-3d">비밀번호 설정</h1>
		<form id="setpassword" action="./setnewpassword" method="post">
		
			<table style="width: 90%;margin:0 auto;">

				<colgroup>
					<col width="30%"/>
				</colgroup>

				
				<tr>
					<td><label class="required" for="nickname">아이디</label></td>
					<td><input class="col2" type="text" id="nickname" name="nickname" placeholder="id"/></td>
				</tr>
				<tr>
					<td><label class="required" for="password">비밀번호</label></td>
					<td><input class="col2"  type="password" id="password" name="password" placeholder="비밀번호"/></td>
				</tr>
				<tr>
					<td><label class="required" for="confirm-pw">비밀번호확인</label></td>
					<td><input class="col2"  type="password" id="confirm-pw" name="confirm-pw" placeholder="비밀번호확인"/></td>
				</tr>


			</table>
		</form>
		<div id="message"></div>
		<input type="button" id="btn-change" value="변경"></input>
		
		<div id="formFooter">

					<span style ="color : red"> 비밀번호 재설정시 영업사원에게 먼저   </span><br>
					<span style ="color : red"> 초기화 요청을 해주시기 바랍니다. </span>
					
					
				
			<!--<a href="./searchid">아이디찾기</a><span class="bar">|</span>
			<a href="#">비밀번호 찾기</a><span class="bar">|</span>
			<a href="./login">로그인</a>-->
		</div>
	</div>
</div>
		
<script>
$(function() {
	$('#btn-change').click(function(event) {
		event.preventDefault();
		console.log("submit");
		
		if (document.getElementById("nickname").value.trim().length == 0) {
			alert("아이디를 입력하세요");
			document.getElementById("nickname").focus();
			return false;
		}

		if (document.getElementById("password").value.length == 0) {
			alert("비밀번호를 입력하세요");
			document.getElementById("password").focus();
			return false;
		}
		if (document.getElementById("password").value != 
			document.getElementById("confirm-pw").value) {
			alert("비밀번호가 일치하지 않습니다");
			document.getElementById("confirm-pw").focus();
			return false;
		}
		
		var formdata = $("#setpassword").serialize();

		$.post("${CPATH}/user/setnewpassword", formdata).done(function(data) {
			console.log(data);
			if (data.state == "ok") {
			
				//$('#setpassword').submit();
				location.href = "${CPATH}/member/";
			}
			else {
				alert(data.state);
			}
		});
		console.log(formdata);
	});
	
	document.getElementById("btn-terms").addEventListener("click", function(event) {
		event.preventDefault();
		var elem = document.getElementById("tos");
		if(elem.style.display === "none") {
			elem.style.display = "block";	
		} else {
			elem.style.display = "none";
		}
	});
});

</script>
</body>
</html>