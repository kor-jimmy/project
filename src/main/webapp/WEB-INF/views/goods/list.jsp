<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
function listGoods(keyword){
	$("#tb").empty();
	$.ajax("/goods/listGoods",{data:{keyword:keyword}, success:function(result){
//		console.log(result);
		$.each(result, function(idx,item){
			//상품번호,제목,코드,가격,날짜
			var td1=$("<td></td>").html(item.g_no);
			var a=$("<a></a>").attr("httr","goods/get?g_no="+item.g_no)
			var td2=$("<td></td>").html(item.g_title);
			$(td2).on("click",function(){
				self.location = "/goods/get?g_no="+item.g_no;
			})
			var td3=$("<td></td>").html(item.gc_code);
			var td4=$("<td></td>").html(item.g_price);
			var td5=$("<td></td>").html(item.g_date);
			var tr = $("<tr></tr>").append(td1,td2,td3,td4,td5);
			$("#tb").append(tr);
		})
	}})
}
$(function(){
	listGoods()	
	$("#insertBtn").on("click",function(){
		self.location = "/goods/insert";
	})
	$.ajax("/category/goodsCateList",{success:function(result){
//		console.log(result)
		$.each(result,function(idx,item){
			var c_dist= $("<span></span>").html(result[idx].c_dist);
			var nbsp="  ";
			$("#goodsType").append(c_dist,nbsp);
			$(c_dist).on("click",function(){
//				console.log($(c_dist).html())
				listGoods($(this).html())
			})
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
		<tbody id="tb">
			
		</tbody>
	</table>
	<button id="insertBtn">상품등록</button>
	<hr>
<%@include file="../includes/footer.jsp"%>