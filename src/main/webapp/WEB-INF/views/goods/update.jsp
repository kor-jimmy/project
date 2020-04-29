<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>상품수정</h2>
	<form action="/goods/update" method="post">
	<input type="hidden" id="g_no" value="g_no">
	<table>
		<tr>
			<td>상품 제목</td>
			<td><input type="text" id="g_title" name="g_title" value=${goods.title } required="required"></td>
		</tr>
		<tr>
			<td>코드</td>
			<td><input type="number" id="gc_code" name="gc_code" value=${goods.gc_code } required="required"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" id="m_id" name="m_id" value=${goods.m_id } required="required"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="number" id="g_price" name="g_price" value=${goods.g_price } required="required"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea id="g_content" name="g_content" row="3">${goods.g_content }</textarea></td>
		</tr>
	</table>
	<button type="submit" id="updateBtn">등록</button>
	</form>
</body>
</html>