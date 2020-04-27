<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>게시물 상세</h2>
	Love : <c:out value="${board.b_lovecnt }"/>/ Hate : <c:out value="${board.b_hatecnt }"/>/ 조회수 : <c:out value="${board.b_hit }"/>
	<table>
		<tr>
			<td>게시물번호</td>
			<td><c:out value="${board.b_no }"/></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><c:out value="${board.m_id }"/></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><c:out value="${board.b_title }"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><c:out value="${board.b_content }"/></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_updatedate }"/></td>
		</tr>
	</table>
	<button id="updateBtn">수정</button>
	<button id="deleteBtn">삭제</button>
</body>
</html>