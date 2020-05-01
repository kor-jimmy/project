<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
$(function(){
	// $(".categories").on("click", function(){
	// 	var dist = $(this).attr("id");
	// 	$.ajax("/board/list", {data: {c_dist: dist}, success: function(cat){
	// 		$("#c_no").val(cat.c_no);
	// 		$("#c_dist").val(cat.c_dist);
	// 	}});
	// });
});
</script>
<h2>카테고리 목록</h2>
<ul>
	<c:forEach var="cat" items="${ list }">
		<a href="/board/list">
			<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
		</a>
	</c:forEach>
</ul>
<%@include file="../includes/footer.jsp"%>