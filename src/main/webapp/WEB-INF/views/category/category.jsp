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
	$(".categories").on("click", function(){
		var id = $(this).attr("id");
		$.ajax("/category/get", {data: {c_no: id}, success: function(cat){
			$("#c_no").val(cat.c_no);
			$("#c_dist").val(cat.c_dist);
		}});
	});
});
</script>
<h2>카테고리 목록</h2>
<ul>
	<c:forEach var="cat" items="${ list }">
		<li><div class="categories" id="${ cat.c_no }"><c:out value="${ cat.c_dist }"/></div></li>
	</c:forEach>
</ul>
</body>
</html>