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
		var gr_no = $("#gr_no").val();
		
		$("#deleteBtn").on("click",function(){
			console.log(g_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax("/goods/delete", {type: 'POST', data: {g_no: g_no},success: function(result){
					alert(result);
					location.href="/goods/list";
				}});
			}
		})
		$.ajax("/goodsReply/list",{type:"GET",data:{g_no:g_no}, success: function(goodsReply){
			console.log(goodsReply);
			$.each(goodsReply, function(idx,r){
 				var tr = $("<tr></tr>");
 				var button = $("<button class='deleteReply'></button>").text("삭제").attr("gr_no",r.gr_no);
				var td1 = $("<td></td>").html(r.gr_no);
				var td2 = $("<td></td>").html(r.g_no);
				var td3 = $("<td></td>").html(r.m_id);
				var td4 = $("<td></td>").html(r.gr_content) 
				var td5 = $("<td></td>").html(r.gr_date);
				var td6 = $("<td></td>");
				td6.append(button)
				tr.append(td1,td2,td3,td4,td5,td6);
				$("#goodsReplyTable").append(tr);
			})
		}})

		$(document).on("click",".deleteReply",function(){
			var grno = $(this).attr("gr_no");
			var re = confirm("진짜로 댓글을 삭제하겠습니까?");
			if(re){
				$.ajax("/goodsReply/delete", {type:"POST", data:{gr_no:grno}, success:function(result){
						alert(result);
				}})
			}
		})
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
	<table id="goodsReplyTable">
	</table>
	
</body>
</html>