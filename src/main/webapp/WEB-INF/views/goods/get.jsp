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
		var g_no = $("#g_no").val();
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
		$.ajax("/goodsReply/list",{type:"GET",data:{g_no:g_no}, success: function(goodsReply){
			console.log(goodsReply);
			
		}})
	})
</script>
	<h2>게시물 상세</h2>
	<input type="hidden" id="g_no" value="${ goods.g_no }">
	<table>
		<tr>
			<td>상품제목</td>
			<td><c:out value="${goods.g_title }"/></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><c:out value="${goods.m_id }"/></td>
		</tr>
		<tr>
			<td>상품내용</td>
			<td><c:out value="${goods.g_content }"/></td>
		</tr>
	</table>
	<button id="deleteBtn">삭제</button>
	<hr>
	<h4>댓글</h4>
	<table id="goodsReply">
	</table>
</body>
</html>