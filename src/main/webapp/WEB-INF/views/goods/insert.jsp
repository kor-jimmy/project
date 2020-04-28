<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>상품등록</h2>
	<form>
	<table>
		<tr>
			<td>상품 제목</td>
			<td><input type="text" name="g_title" required="required"></td>
		</tr>
		<tr>
			<td>코드</td>
			<td><input type="number" name="g_no" readonly="readonly" value="1"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="m_id" readonly="readonly" value="tiger"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="number" name="g_price" readonly="readonly" value="1000"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="g_content" row="3"></textarea></td>
		</tr>
	</table>
	</form>
	<button type="submit" id="insertBtn">등록</button>
	<button type="reset" id="resetBtn">취소</button>
</body>
</html>