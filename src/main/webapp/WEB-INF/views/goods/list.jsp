<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#insertBtn").on("click",function(){
		self.location = "/goods/insert";
	})
	$.ajax("/category/goodsCateList",{success:function(result){
//		console.log(result)
		$.each(result,function(idx,item){
			var c_dist= $("<span></span>").html(result[idx].c_dist);
			var nbsp="  ";
			$("#goodsType").append(c_dist,nbsp);
		})
	}})
})
</script>
	<h2>상품목록</h2>
	<hr>
	<div id="goodsType">
	<h5>상품 종류별 보기</h5>
	
	</div>
	<hr>
	<table>
		<thead>
			<tr>
				<td>상품번호</td>
				<td>제목</td>
				<td>코드</td>
				<td>가격</td>
				<td>날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="goods">
				<tr>
					<td><c:out value="${goods.g_no }"></c:out></td>
					<td><a href="/goods/get?g_no=${goods.g_no }"><c:out value="${goods.g_title }"></c:out></a></td>
					<td><c:out value="${goods.gc_code }"></c:out></td>
					<td><c:out value="${goods.g_price }"></c:out></td>
					<td><c:out value="${goods.g_date }"></c:out></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button id="insertBtn">상품등록</button>
	<hr>
<%@include file="../includes/footer.jsp"%>