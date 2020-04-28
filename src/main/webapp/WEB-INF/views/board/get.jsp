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
				$.ajax("/board/delete", {type: 'POST', data: {b_no: b_no},success: function(result){
					alert(result);
					location.href="/board/list";
				}});
			}
		})
		
		//댓글 목록 ajax
		$.ajax("/reply/list",{type:"GET",data:{b_no:b_no}, success: function(reply){
			console.log(reply);
			$.each(reply, function(idx,r){
 				var tr = $("<tr class='rep'></tr>");
				var button= $("<button class='deleteReply'></button>").text("삭제").attr("r_no",r.r_no);
				var td1 = $("<td></td>").html(r.m_id);
				var td2 = $("<td></td>").html(r.r_content);
				//날짜 양식 맞춰야함.
				var td3 = $("<td></td>").html(r.r_date);
				var td4 = $("<td></td>").html("신고버튼넣을꺼임");
				var td5 = $("<td></td>");
				td5.append(button);
				tr.append(td1,td2,td3,td4,td5);
				$("#replyTable").append(tr);
			})
		}})

		//댓글 등록 ajax
		$("#insertReply").on("click",function(){
			var r = $("#boardReply").serialize();
			var re = confirm("Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?")
			if(re){
				$.ajax("/reply/insert",{type:"POST", data:r, success:function(result){
					alert(result);
					location.href="/board/get?b_no="+b_no;
				}})
			}
		})

		//댓글 삭제 ajax 기능구현부터!
		$(document).on("click",".deleteReply",function(){
			var rno = $(this).attr("r_no");
			var re = confirm("해당 댓글을 삭제하시겠습니까?")
			if(re){
				$.ajax("/reply/delete",{type:"GET", data:{r_no:rno}, success:function(result){
					alert(result)
					location.href="/board/get?b_no="+b_no;
				}})
			}
		})
		
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
	<table id="replyTable" border="1">
	</table>
	<hr>
	<form id="boardReply">
		<input type="hidden" name="b_no" value="<c:out value='${board.b_no }'/>">
		<input type="text" name="m_id" value="tiger" readonly="readonly">
		<input type="text" name="r_content" required="required">
	</form>
	<button type="submit" id="insertReply">댓글등록</button>
</body>
</html>