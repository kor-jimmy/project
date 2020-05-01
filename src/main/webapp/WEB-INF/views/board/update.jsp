<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<h2>게시물 수정</h2>
<hr>
<form action="/board/update" method="post">
<input type="hidden" id="b_no" name="b_no" value="${board.b_no}">

<table class="table table-bordered">
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" required="required" style="width:40%;" value="${board.b_title}"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="m_id" style="width:40%;" readonly="readonly" value="${board.m_id}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea class="text_content" name="b_content" rows="30%" cols="100%">${board.b_content}</textarea></td>
	</tr>
	xxxxxxxxxxxasdzxcvasdsdasdasdfasdfasdfasdfasdfasdfasdfasdfzcvzxcvadsdzxc
</table>
<button type="submit" id="updateBtn" class="btn btn-outline-dark">수정</button>
</form>

<%@include file="../includes/footer.jsp"%>