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
	<h2>상품목록</h2>
	
	<tabel>
		<thead>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="">
				<tr>
					<td><c:out value="${member.m_id }"></c:out></td>
					<td><a href="/member/get?m_id=${member.m_id }"><c:out value="${member.m_pwd }"></c:out></a></td>
					<td><c:out value="${member.m_nick }"></c:out></td>
					<td><c:out value="${member.m_email }"></c:out></td>
					<td><c:out value="${member.m_phone }"></c:out></td>
				</tr>
			</c:forEach>
		</tbody>
	</tabel>
</body>
</html>