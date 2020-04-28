<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>게시물 수정</h2>
<hr>
<form action="/board/update" method="post">
<input type="hidden" id="b_no" name="b_no" value="${board.b_no}">
<table>
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" required="required" value="${board.b_title}"></td>
	</tr>
	<tr>
		<td>카테고리번호</td>
		<td><input type="number" name="c_no" readonly="readonly" value="${board.c_no}"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="m_id" readonly="readonly" value="${board.m_id}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="b_content" row="3">${board.b_content}</textarea></td>
	</tr>
</table>
<button type="submit" id="updateBtn">수정</button>
</form>
</body>
</html>