<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		var parentNum;
		var g_no = $("#g_no").val();
		var gr_no = $("#gr_no").val();
		$("#updateBtn").on("click",function(){
			self.location = "/goods/update?g_no="+g_no;
		})
		
		$("#deleteBtn").on("click",function(){
			console.log(g_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax("/goods/delete", {type: 'GET', data: {g_no: g_no},success: function(result){
					alert(result);
					location.href="/goods/list";
				}});
			}
		})
		
		$.ajax("/goodsReply/list",{type:"GET",data:{g_no:g_no}, success: function(goodsReply){
			goodsReply = JSON.parse(goodsReply)		
//			console.log(goodsReply);
			$.each(goodsReply, function(idx,r){
 				var tr = $("<tr></tr>");
 				var button = $("<button class='deleteReply'></button>").text("삭제").attr("gr_no",r.gr_no);
 				var buttonRe = $("<button class='reReply'></button>").text("대댓글").attr("gr_no",r.gr_no);
				var td1 = $("<td></td>").html(r.gr_no);
				var td2 = $("<td></td>").html(r.g_no);
				var td3 = $("<td></td>").html(r.m_id);
				var td4 = $("<td></td>").html(r.gr_content) 
				var td5 = $("<td></td>").html(r.gr_date);
				var td6 = $("<td></td>");
				var hide = $("")
				td6.append(button,buttonRe);
				tr.append(td1,td2,td3,td4,td5,td6);
				//채은) 05/13 대댓글작업 시작~!
				$(buttonRe).on("click",function(){
					$("#rereplyInput").remove();
					
					var par = $(this).parent().parent();
					var gr_no = par.children(":eq(0)").html();//댓글번호
					var g_no = par.children(":eq(1)").html();//상품 글 번호
					var tr = $("<tr id='rereplyInput'><td>tiger:</td></tr>");
					var input = $("<input type='text'>");
					var btnReInsert = $("<button class='insertReReply'>등록</button>");
					$(tr).append(input,btnReInsert);
					$(btnReInsert).on("click",function(){
//						console.log(gr_no);
						var re = confirm("댓글을 등록하시겠습니까? 한 번 입력한 댓글은 수정이 불가하므로 신중하게 입력해 주세요.");
						var data = {g_no:g_no , m_id:'tiger', gr_content:$(input).val(),gr_ref:gr_no};
						if(re){
							$.ajax("/goodsReply/insert",{type:"POST",data:data, success:function(result){
								alert(result);
								location.href="/goods/get?g_no="+g_no;
							}})
						}				
						$(this).parent().remove();
					})
					var table=$(par).parent();
					$(table).append(tr);
				})
				
				$("#goodsReplyTable").append(tr);
			})
		}})
		
		$("#insertReply").on("click",function(){
			var data = $("#reply").serialize();
			var re = confirm("댓글을 등록하시겠습니까? 한 번 입력한 댓글은 수정이 불가하므로 신중하게 입력해 주세요.");
			if(re){
				$.ajax("/goodsReply/insert", {type:"POST", data:data, success:function(result){
					alert(result);
					location.href="/goods/get?g_no="+g_no;
				}})
			}
			parentNum=0;
			console.log("인서트끝:"+parentNum);
		})
		
		$(document).on("click",".deleteReply",function(){
			var grno = $(this).attr("gr_no");
			var re = confirm("진짜로 댓글을 삭제하겠습니까?");
			if(re){
				$.ajax("/goodsReply/delete", {type:"GET", data:{gr_no:grno}, success:function(result){
						alert(result);
						location.href="/goods/get?g_no="+g_no;
				}})
			}
		})
	})
</script>
	<h2>상품 상세</h2>
	<input type="hidden" id="g_no" value="${ goods.g_no }">
	<table class="table table-bordered">
		<tr>
			<td colspan="4"><h3><c:out value="${goods.g_title }"/></h3></td>
		</tr>
		<tr>
			<td width="25%">작성자</td>
			<td width="25%"><c:out value="${goods.m_id }"/></td>
			<td width="25%">작성시간</td>
			<td width="25%"><c:out value="${goods.g_date }"/></td>
		</tr>
		<tr>
			<td colspan="4">
			<div>${goods.g_content }</div></td>
		</tr>
	</table>
	<button id="deleteBtn">삭제</button>
	<button id="updateBtn">수정</button>
	<hr>
	<h4>댓글</h4>
   <table id="goodsReplyTable">
   </table>
   <hr>
   <form id="reply">
      <input type="hidden" name="g_no" value="<c:out value='${goods.g_no }'/>">
      <input type="hidden" name="gr_ref" value="0">
      <input type="hidden" name="gr_level" value="0">
      id:<input type="text" name="m_id" required="required">
      content:<input type="text" name="gr_content" required="required">      
   </form>
   <button type="submit" id="insertReply">댓글 등록</button>
	
<%@include file="../includes/footer.jsp"%>