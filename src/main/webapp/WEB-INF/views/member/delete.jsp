<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btnDel").on("click",function(){
			console.log("탈퇴버튼 동작");
		})
	})
</script>

	<h2>회원탈퇴</h2>
	<div class="btn-group btn-group-justified">
		<a href="/member/get?m_id=${member.m_id }" class="btn btn-primary">회원정보</a>
   		<a href="/member/mypage?m_id=${member.m_id }" class="btn btn-primary">작성글</a>
   		<a href="/member/delete?m_id=${member.m_id }" class="btn btn-primary">회원탈퇴</a>
 	</div>
	<form>
		<ul class="list-group">
			<li class="list-group-item">
			<strong>id</strong>
			<div><input type="text"></div>
			</li>
			<li class="list-group-item">
			<strong>암호</strong>
			<div><input type="password" id="pwd"></div>
			</li>
		</ul>
		<button id="btnDel">탈퇴</button>
	</form>


<%@include file="../includes/footer.jsp"%>