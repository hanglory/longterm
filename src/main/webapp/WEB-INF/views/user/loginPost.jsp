<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
DESTINATION : ${destination }<br>
USER ID: ${userId }

<%
	String dest = (String)session.getAttribute("destination");

	if (dest != null) {
		response.sendRedirect(session.getAttribute("destination").toString());
	}

%>

</body>
</html>