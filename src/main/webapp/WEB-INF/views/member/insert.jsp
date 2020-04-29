<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		})
</script>
	<h2>회원등록</h2>
	<hr>
	<form action="/member/insert" method="post">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="m_id" required="required"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="text" name="m_pwd" required="required"></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="m_nick" required="required"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="m_email" required="required"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="m_phone" required="required"></td>
		</tr>
	</table>
	<button type="submit" id="insertBtn">회원등록</button>
	</form>
<%@include file="../includes/footer.jsp"%>