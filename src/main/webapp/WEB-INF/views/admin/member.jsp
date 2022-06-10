<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<style>
input[type=text], input[type=date], input[type=submit] {
	height: 2em;
}

table {
	width: 95%;
	margin: 20px auto;
	border-collapse: collapse;
	font-size: 1.2em;
}

th {
	color: #332;
	background-color: #ccc;
	border: 1px solid #aaa;
}
td {
	padding: 4px;
	text-align: center;
	border: 1px solid #aaa;
}

td > input, td > select {
	width: 100%;
	height: 100%;
	border: none;
	outline: none;
	text-align: center;
	background-color: white;
}

td:last-child {
	padding: 0;
}

td:last-child button {
	width: 45%;
	height: 100%;
}

/* text-align : center */
.tac {
	text-align : center;
}

/* text-align : right */
.tar {
	text-align : right;
}
</style>


	<h1>회원 리스트</h1>
	<form action="${CPATH}/admin/member">
		<input type="text" id="name" name="name" placeholder="이름"  
				value="<%= request.getParameter("name") == null ? "" : request.getParameter("name") %>" />
		<input type="text" id="nickname" name="nickname" placeholder="아이디" 
				value="<%= request.getParameter("nickname") == null ? "" : request.getParameter("nickname") %>" />
		<input type="text" id="company" name="company" placeholder="회사" 
				value="<%= request.getParameter("company") ==null ? "" : request.getParameter("company") %>" />
        <input type="submit" value="   검색    " />
	</form>
	<div>
		<span>${count} 개가 있습니다.</span>
		<table id="list">
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>전화번호</th>
				<th>레벨</th>
				<th>회사</th>
				<th>담당자</th>
				<th>상태</th>
				<th>등록일</th>
				<th></th>
			</tr>
			<c:forEach var="user" items="${users }">
			<tr data-id="${user.id }">
				<td>${user.name }</td>
				<td>${user.nickname }</td>
				<td>${user.phone }</td>
				<td contenteditable='true'>
					${user.level }
				</td>
				<td>${user.company }</td>
				<td>${user.manager }</td>
				<td>
					<select>
						<option value="승인안됨" <c:if test="${user.state eq '승인안됨'}">selected </c:if>>승인안됨</option>
						<option value="승인" <c:if test="${user.state eq '승인'}">selected </c:if>>승인</option>
						<option value="탈퇴" <c:if test="${user.state eq '탈퇴'}">selected </c:if>>탈퇴</option>
					</select>
					
					
				</td>
				<td><fmt:formatDate value="${user.regdate }" pattern="yyyy-MM-dd"/></td>
				<td>
					<button onclick="initPassword(this);">암호초기화</button>
					<button onclick="changeUser(this);">수정</button>
				</td>
			</tr>
			</c:forEach>

		</table>
	</div>


<script>

document.querySelector("table").addEventListener("click", (e)=>{
	
	if (e.target.nodeName == "TD") {
		console.log(e.target.parentElement.dataset.id);
		e.preventDefault();
	}
	else if (e.target.nodeName == "TH") {

		e.preventDefault();
	}
});

var initPassword = (bt) => {
	console.log(bt.parentElement.parentElement.dataset.id);
}

var changeUser = (bt) => {
	
	var trNode = bt.parentElement.parentElement; 
	var s = trNode.getElementsByTagName('SELECT');
	var member = {
		id : bt.parentElement.parentElement.dataset.id,
		level : trNode.getElementsByTagName('TD')[3].innerText,
		state : trNode.getElementsByTagName('SELECT')[0][trNode.getElementsByTagName('SELECT')[0].selectedIndex].value,
	};
	

	console.log(member);
	var result = confirm("멤버 정보를 수정하시겠습니까?");
	if (!result) return;
	
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == xhr.DONE ) {
			if (xhr.status == 200 || xhr.status == 201) {
				console.log(xhr.responseText);
			} else {
				console.log(xhr.responseText);
			}
		}
	};
	
	xhr.open("POST", "${CPATH}/admin/memberchange");
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(member));

};
</script>
