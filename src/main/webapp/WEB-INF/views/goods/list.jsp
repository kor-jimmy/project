<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
function listGoods(keyword){
	if(keyword == null){
		$("#insertBtn").css("visibility","hidden");
	}
	else{
		$("#insertBtn").css("visibility","visible");
	}
	
	$("#tb").empty();
	$.ajax("/goods/listGoods",{data:{keyword:keyword}, success:function(result){
//		console.log(result);
		$.each(result, function(idx,item){
			//상품번호,제목,코드,가격,날짜
			var td1=$("<td align='center'></td>").html(item.g_no);
			var a=$("<a>"+item.g_title+"["+item.g_replycnt+"]"+"</a>").attr("href","/goods/get?g_no="+item.g_no)
			var td2=$("<td></td>").html(a);
			var td3=$("<td align='center'></td>").html(item.gc_code);
			var td4=$("<td align='center'></td>").html(item.g_price);
			var td5=$("<td align='center'></td>").html(item.g_date);
			var tr = $("<tr></tr>").append(td1,td2,td3,td4,td5);
		//	$(tr).on("click",function(){
		//		self.location = "/goods/get?g_no="+item.g_no;
		//	})
			$("#tb").append(tr);
		})
	}})
}
$(function(){
	var c_no;
	listGoods()	
	$.ajax("/category/goodsCateList",{success:function(result){
//		console.log(result)
		var b=$("<button id='tot' class='btn btn-outline-dark'></button>").html('전체보기');
		$(b).on("click",function(){
			listGoods();
		})
		$("#goodsType").append(b);
		$.each(result,function(idx,item){
			var c_dist= $("<button id='listCate' type='button' class='btn btn-outline-dark'></button>").html(result[idx].c_dist);
			var nbsp="  ";
			$("#goodsType").append(c_dist,nbsp);
			$(c_dist).on("click",function(){
				c_no=result[idx].c_no;
//				console.log(c_no)
//				console.log($(c_dist).html())
				listGoods($(this).html())
			})
		})
		
	}})
	$("#insertBtn").on("click",function(){
//		console.log(c_no);
		self.location = "/goods/insert?c_no="+c_no;
	})
})
</script>

	<h2>상품목록</h2>
	<hr>
	<div id="goodsType">
	<h4>상품 종류별 보기</h4>
	
	</div>
	<hr>
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<td width="10%">상품번호</td>
				<td width="50%">제목</td>
				<td width="10%">코드</td>
				<td width="10%">가격</td>
				<td width="10%">날짜</td>
			</tr>
		</thead>
		<tbody id="tb">
			
		</tbody>
	</table>
	<hr>
	<button id="insertBtn" type="button" class="btn btn-outline-dark">상품등록</button>
	<hr>
<%@include file="../includes/footer.jsp"%>