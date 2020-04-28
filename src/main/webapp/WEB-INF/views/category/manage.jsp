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
	$("#insertBtn").on("click", function(){
		var c_no = $("#c_no").val();
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist};
		$.ajax("/category/insert", {type: 'POST', data: data, success: function(re){
			alert(re);
			location.href ="/category/manage";
		}});
	});

	$(".categories").on("click", function(){
		var id = $(this).attr("id");
		$.ajax("/category/get", {data: {c_no: id}, success: function(cat){
			$("#c_no").val(cat.c_no);
			$("#c_dist").val(cat.c_dist);
		}});
	});

	$("#updateBtn").on("click", function(){
		var c_no = $("#c_no").val();
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist}
		$.ajax("/category/update", {type: 'POST', data: data, success: function(re){
			alert(re);
			location.href ="/category/manage";
		}});
	});
	
	$("#deleteBtn").on("click", function(){
		var c_no = $("#c_no").val();
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist}
		$.ajax("/category/delete", {type: 'POST', data: data, success: function(re){
			alert(re);
			location.href ="/category/manage";
		}});
	});
});
</script>
<h2>카테고리 관리</h2>
<table>
	<tr>
		<td>번호</td>
		<td><input type="number" id="c_no" name="c_no"></td>
	</tr>
	<tr>
		<td>카테고리명</td>
		<td><input type="text" id="c_dist" name="c_dist"></td>
	</tr>
</table>
<button id="insertBtn">등록</button>
<button id="updateBtn">수정</button>
<button id="deleteBtn">삭제</button>

<ul>
	<c:forEach var="cat" items="${ list }">
		<li><div class="categories" id="${ cat.c_no }"><c:out value="${ cat.c_no } :   ${ cat.c_dist }"/></div></li>
	</c:forEach>
</ul>
</body>
</html>