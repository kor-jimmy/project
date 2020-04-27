<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
	})
</script>
</head>
<body>
<h2>게시물 등록</h2>
<hr>
<form action="/board/insert" method="post">
<table>
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" required="required"></td>
	</tr>
	<tr>
		<td>카테고리번호</td>
		<td><input type="number" name="c_no" readonly="readonly" value="1"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="m_id" readonly="readonly" value="tiger"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="b_content" row="3"></textarea></td>
	</tr>
</table>
<button type="submit" id="insertBtn">게시물 등록</button>
<button type="reset" id="resetBtn">리셋</button>
</form>
</body>
</html>