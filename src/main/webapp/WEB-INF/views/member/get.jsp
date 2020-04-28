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
	<h2>회원 상세</h2>
	<table border="1">
		<tr>
				<td>아이디</td>
				<td><c:out value="${member.m_id }"/></td>
		</tr>
		<tr>
			<td>암호</td>
			<td><c:out value="${member.m_pwd }"/></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><c:out value="${member.m_nick }"/></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><c:out value="${member.m_email }"/></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><c:out value="${member.m_phone }"/></td>
		</tr>
		<tr>
			<td>등급</td>
			<td><c:out value="${member.m_rate }"/></td>
		</tr>
		<tr>
			<td>장터레벨</td>
			<td><c:out value="${member.m_store }"/></td>
		</tr>
		<tr>
			<td>회원종류</td>
			<td><c:out value="${member.role }"/></td>
		</tr>
	</table>
</body>
</html>