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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
$(function(){
	var m_id = $("#m_id").val();
	$("#updateBtn").on("click",function(){
		self.location = "/member/update?m_id="+m_id;
	})
	$("#deleteBtn").on("click",function(){
		var re = confirm("정말로 삭제하시겠습니까?");
		if(re){
			$.ajax("/member/delete", {type: 'GET', data: {m_id: m_id},success: function(result){
				alert(result);
				location.href="/member/list";
			}});
		}
	})
})
	</script>
	<h2>회원 상세</h2>
	<input type="hidden" id="m_id" value=${member.m_id }>
	<table border="1">
		<tr>
				<td>아이디</td>
				<td><c:out value="${member.m_id }"/></td>
		</tr>
		<tr>
			<td>암호</td>
			<td><c:out value="${member.m_pwd }"/></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><c:out value="${member.m_nick }"/></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><c:out value="${member.m_email }"/></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><c:out value="${member.m_phone }"/></td>
		</tr>
		<tr>
			<td>등급</td>
			<td><c:out value="${member.m_rate }"/></td>
		</tr>
		<tr>
			<td>장터레벨</td>
			<td><c:out value="${member.m_store }"/></td>
		</tr>
		<tr>
			<td>회원종류</td>
			<td><c:out value="${member.role }"/></td>
		</tr>
	</table>
	<button id="updateBtn">수정</button>
	<button id="deleteBtn">삭제</button>
</body>
</html>