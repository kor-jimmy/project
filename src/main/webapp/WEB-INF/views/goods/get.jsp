<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		var gr_no = $("#gr_no").val();
		$("#deleteBtn").on("click",function(){
			console.log(gr_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax("/goodsReply/delete", {type: 'GET', data: {gr_no: gr_no},success: function(result){
					alert(result);
					location.href="/goodsReply/list";
				}});
			}
		})
		$.ajax("/goodsReply/list",{type:"GET",data:{gr_no:gr_no}, success: function(goodsReply){
			var goodsReplyList = goodsReply;
			console.log(goodsReplyList);
			$.each(JSON.parse(GoodsReply), function(idx,r){
				console.log(r.m_id)
			})
		}})
	})
</script>
	<h2>게시물 상세</h2>
	<input type="hidden" id="gr_no" value="${ goodsReply.gr_no }">
	<table>
		<tr>
			<td>게시물번호</td>
			<td><c:out value="${goodsReply.gr_no }"/></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><c:out value="${goodsReply.g_id }"/></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><c:out value="${goodsReply.m_id }"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><c:out value="${goodsReply.gr_content }"/></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${goodsReply.gr_date }"/></td>
		</tr>
	</table>
	<button id="deleteBtn">삭제</button>
	<hr>
	<h4>댓글</h4>
	<table id="goodsReplyTable">
	</table>
</body>
</html>