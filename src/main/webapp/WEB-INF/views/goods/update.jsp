<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

	<h2>상품수정</h2>
	<form action="/goods/update" method="post">
	<input type="hidden" id="g_no" name="g_no" value="${goods.g_no}">
	<table>
		<tr>
			<td>상품 제목</td>
			<td><input type="text" name="g_title" required="required" value="${goods.g_title }"></td>
		</tr>
		<tr>
			<td>코드</td>
			<td><input type="number" name="gc_code" required="required" value="${goods.gc_code }"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="m_id" readonly="readonly" value="${goods.m_id }"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="number" name="g_price" required="required" value="${goods.g_price }"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="g_content" row="3">${goods.g_content }</textarea></td>
		</tr>
	</table>
	<button type="submit" id="updateBtn">등록</button>
	</form>
<%@include file="../includes/footer.jsp"%>