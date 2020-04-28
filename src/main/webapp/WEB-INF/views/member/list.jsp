<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#insertBtn").on("click",function(){
			self.location = "/member/insert";
			})
		})
</script>
	<h2>회원목록</h2>
	<table border="1">
		<thead>
			<tr>
				<td>아이디</td>
				<td>암호</td>
				<td>닉네임</td>
				<td>이메일</td>
				<td>전화번호</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="mem">
				<tr>
					<td><c:out value="${mem.m_id }"></c:out></td>
					<td><c:out value="${mem.m_pwd }"></c:out></td>
					<td><c:out value="${mem.m_nick }"></c:out></td>
					<td><c:out value="${mem.m_email }"></c:out></td>
					<td><c:out value="${mem.m_phone }"></c:out></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<hr>
	<button id="insertBtn">회원 등록</button>
</body>
</html>