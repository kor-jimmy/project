<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../header.jsp"%>
<script>
	$(function(){
		var b_no = $("#b_no").val();
		//시큐리티 csrf
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		
		//게시물 수정
		$("#updateBtn").on("click",function(){
			self.location = "/admin/notice/update?b_no="+b_no;
		})
		
		
		//게시물 삭제
		$("#deleteBtn").on("click",function(){
			
			var re = confirm("해당 공지사항을 삭제 하시겠습니까?");
				if(re){
					$.ajax("/admin/notice/delete", {
						type: 'POST', 
						data: {b_no: b_no},
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false, 
						success: function(result){
						if( result == "0"){
							swal({
								  title: "게시물 삭제에 실패 하였습니다.",
								  icon: "warning",
								  button: "확인"
								})
						}else{
							location.href="/admin/notice/notice?categoryNum="+$("#c_no").val();
						}
					}}); 
				}       
		});
	})
</script>

<div class="col mt-4">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">공지사항 상세</h6>
		</div>
		
		<!-- Card Body -->
		<div class="card-body">
			<table class="table table-bordered">
				<tr>
					<td width="20%">분류</td>
					<td>
						<c:if test="${board.c_no == 10001}">일반</c:if>
						<c:if test="${board.c_no == 10002}">징계/정책</c:if>
						<c:if test="${board.c_no == 10003}">업데이트</c:if>
						<c:if test="${board.c_no == 10004}">이벤트</c:if>
						<c:if test="${board.c_no == 10010}">관리자</c:if>
					</td>
				</tr>
				<tr>
					<td>공지사항 제목</td>
					<td>${board.b_title }</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${board.m_id }</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>${board.b_content }</td>
				</tr>
			</table>
			<input type="hidden" id="c_no" value="${board.c_no }"/>
			<input type="hidden" id="b_no" value="${board.b_no }"/>
			<button id="updateBtn" class="btn btn-outline-dark">수정</button>
			<button id="deleteBtn" class="btn btn-outline-dark">삭제</button>
		</div>
	</div>
</div>

<%@include file="../footer.jsp"%>