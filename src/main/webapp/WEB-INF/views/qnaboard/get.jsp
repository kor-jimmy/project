<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link href="/resources/css/button.css" rel="stylesheet">
<link href="/resources/css/boardTable.css" rel="stylesheet">
<link href="/resources/css/elements.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		var qb_no = $("#qb_no").val();
		var c_no = $("#c_no").val();  

		$("#updateBtn").on("click",function(){
			self.location = "/qnaboard/update?categoryNum="+c_no+"&qb_no="+qb_no;
		})
		
		$("#deleteBtn").on("click",function(){
			//console.log(qb_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax("/qnaboard/delete", {type: 'GET', data: {qb_no: qb_no},success: function(result){
					alert(result);
					location.href="/qnaboard/list?categoryNum="+c_no;
				}});
			}
		})

		$("#replyInsertBtn").on("click",function(){
			self.location = "/qnaboard/insert?c_no="+c_no+"&qb_no="+qb_no;
			})

		$("#listBtn").on("click",function(){
			self.location = "/qnaboard/list?categoryNum="+c_no;
			})	
})
</script>
	<h2>QNA 상세</h2>
	<input type="hidden" id="qb_no" value="${ qnaboard.qb_no }">
	<input type="hidden" id="c_no" value="${ qnaboard.c_no }">
	<table class="table table-bordered opacity-table">
		<tr>
			<td colspan="4"><h3><c:out value="${qnaboard.qb_title }"/></h3></td>
		</tr>
		<tr>
			<td width="20%" align="center">작성자</td>
			<td width="25%"><c:out value="${qnaboard.m_id }"/></td>
			<td width="20%" align="center">작성시간</td>
			<td width="35%"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${qnaboard.qb_date }"/></td>
		</tr>
		<tr>
			<td height="500px" colspan="4">
			<div class="contents-padding" id="contents">${qnaboard.qb_content }</div></td>
		</tr>
	</table>
	

	<sec:authentication property="principal" var="pinfo"/>
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq qnaboard.m_id}">
			<button id="replyInsertBtn" class="btn btn-outline-light mainBtn">답글</button>
			<button id="deleteBtn" class="btn btn-outline-light grayBtn">삭제</button>
			<button id="updateBtn" class="btn btn-outline-light subBtn">수정</button>
		</c:if>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_MASTER')">
		<button id="replyInsertBtn" class="btn btn-outline-light mainBtn">답글</button>
	</sec:authorize>
	
	<button id="listBtn" class="btn btn-outline-light typeBtn">목록</button>
	
<%@include file="../includes/footer.jsp"%>