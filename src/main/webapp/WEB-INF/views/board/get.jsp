<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		var b_no = $("#b_no").val();
		$("#updateBtn").on("click",function(){
			self.location = "/board/update?b_no="+b_no;
		})
		$("#deleteBtn").on("click",function(){
			console.log(b_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax("/board/delete", {type: 'GET', data: {b_no: b_no},success: function(result){
					alert(result);
					location.href="/board/list";
				}});
			}
		})
		$.ajax("/reply/list",{type:"GET",data:{b_no:b_no}, success: function(reply){
			var replyList = reply;
			console.log(replyList);
			$.each(JSON.parse(reply), function(idx,r){
				console.log(r.m_id)
/* 				var tr = $("<tr></tr>")
				var td1 = $("<td></td>").html(reply.m_id);
				var td2 = $("<td></td>").html(reply.r_content);
				//날짜 양식 맞춰야함.
				var td3 = $("<td></td>").html(reply.r_date);
				var td4 = $("<td></td>").html("신고버튼넣을꺼임");
				tr.append(td1,td2,td3,td4);
				$("#replyTable").append(tr); */
			})
		}})

		
	})
</script>
	<h2>게시물 상세</h2>
	<input type="hidden" id="b_no" value="${ board.b_no }">
	Love : <c:out value="${board.b_lovecnt }"/>/ Hate : <c:out value="${board.b_hatecnt }"/>/ 조회수 : <c:out value="${board.b_hit }"/>
	<table>
		<tr>
			<td>게시물번호</td>
			<td><c:out value="${board.b_no }"/></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><c:out value="${board.m_id }"/></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><c:out value="${board.b_title }"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><c:out value="${board.b_content }"/></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_updatedate }"/></td>
		</tr>
	</table>
	<button id="updateBtn">수정</button>
	<button id="deleteBtn">삭제</button>
	<hr>
	<h4>댓글</h4>
	<table id="replyTable">
	</table>
</body>
</html>