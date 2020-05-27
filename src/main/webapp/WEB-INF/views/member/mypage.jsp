<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax("/member/getBoard",function(result){
			$.each(result,function(idx,item){
				var li1 = $("<li></li>").html(item.b_no);
				var li2 = $("<li></li>").html(item.b_title);
				var li3 = $("<li></li>").html(item.b_title);
					
			})
			
		})	
	})
</script>	
	
	<h2 id="mpTitle">${member.m_id }님의 작성글</h2>
	<div class="btn-group btn-group-justified">
		<a href="/member/get?m_id=${member.m_id }" class="btn btn-primary">회원정보</a>
   		<a href="/member/mypage?m_id=${member.m_id }" class="btn btn-primary">작성글</a>
   		<a href="/member/delete?m_id=${member.m_id }" class="btn btn-primary">회원탈퇴</a>
 	</div>
	
	<div>
		<h4>내가 작성한 게시물</h4>
		<div></div>
	</div>
	<div>
		<h4>내가 등록한 굿즈</h4>
	</div>
	<div>
		<h4>내가 작성한 댓글</h4>
	</div>
<%@include file="../includes/footer.jsp"%>