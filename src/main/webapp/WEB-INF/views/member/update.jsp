<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
	<h2>회원수정</h2>
	<hr>
	<form action="/member/update" method="post">
	<input type="hidden" id="m_id" name="m_id" value=${member.m_id }>
	<table>
		<tr>
		<td>닉네임</td>
		<td><input type="text" name="m_nick" id="m_nick" value="${member.m_nick }"></td>
		</tr>
		<tr>
		<td>이메일</td>
		<td><input type="text" name="m_email" id="m_email" value="${member.m_email }"></td>
		</tr>
		<tr>
		<td>전화번호</td>
		<td><input type="text" name="m_phone" id="m_phone" value="${member.m_phone }"></td>
		</tr>
	</table>
	<button type="submit" id="updateBtn">수정</button>
	</form>
<%@include file="../includes/footer.jsp"%>