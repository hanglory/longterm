<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CPATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RPATH" value="${CPATH}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${CPATH}
  	<div class="content">
		<br/><br/>
		<h3>파일 다운로드</h3>
		<a href="${CPATH}/download/file?fileName=eclipse-inst-jre-win64.exe">eclipse-inst-jre-win64</a>
		<a href="${CPATH}/download/file?fileName=ECMPSTC00125_Cyber Security_rB.pdf">download</a>
	</div>
</body>
</html>