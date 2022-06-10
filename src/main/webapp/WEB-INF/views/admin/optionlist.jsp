<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<select>
	<option value="현대">현대</option>
</select>

<table>
	<c:forEach var="option" items="${options }" varStatus="status">
		<tr>
			<td>${option.option_id }</td>
			<td>${option.name }</td>
			<td>${option.price }</td>
			<td>${option.trim_id }</td>
			<td>${option.ranking }</td>
			<td>${option.exc }</td>

		</tr>
	</c:forEach>
</table>