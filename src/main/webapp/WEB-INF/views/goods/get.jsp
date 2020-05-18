<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		var parentNum;
		var g_no = $("#g_no").val();
		var gr_no = $("#gr_no").val();

		//시큐리티
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		console.log("토큰 : "+token+" / 헤더:"+header);

		
		$("#updateBtn").on("click",function(){
			self.location = "/goods/update?g_no="+g_no;
		})
		$("#deleteBtn").on("click",function(){
			console.log(g_no);
			var re = confirm("정말로 삭제하시겠습니까?");
			if(re){
				$.ajax({
					url:"/goods/delete",
					type: 'POST', 
					data: {g_no: g_no},
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false, 
					success: function(result){
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
 				////댓글번호 보내기 (답댓글 달때 부모댓글 넣어주기위함)
 				var hiddenNo = $("<input type='hidden' name='gr_no' value='"+r.gr_no+"'>");
 				var td = $("<td></td>").append(hiddenNo);
 				if(r.gr_level != 0){
 	 				for(i=0;i<r.gr_level;i++){
 	 	 				td.append($("<img src='/img/reply.png' width='45px' height='45px'>"));
 	 	 			}
 	 			}
 				var td1 = $("<td></td>").html(r.m_id);
 				
 	 			
				var td2 = $("<td></td>").html(r.gr_content);
				var td3 = $("<td></td>").html(r.gr_date);
	
//				var buttonRe = $("<button class='reReply btn btn-outline-dark'></button>").text("답글").attr("gr_no",r.gr_no);
//				var btnReport = $("<button class='reReport btn btn-outline-dark'></button>").text("신고").attr("gr_no",r.gr_no);			
				
				var td4 = $("<td></td>");
				var secStr = "";
				secStr += "<sec:authorize access='isAuthenticated()'>"
				if("<sec:authentication property='principal.username'/>"==r.m_id){
					secStr += "<button class='deleteReply btn btn-outline-dark' gr_no="+r.gr_no+">삭제</button>"
				}
				secStr += "</sec:authorize>";
				td4.append(secStr);

				
				var isMem = "";//로그인한 회원만 댓글에 대한 신고/답글 버튼 보이게 하기
				isMem += "<sec:authorize access='isAuthenticated()'>";
				isMem += "<button class='reReply btn btn-outline-dark' gr_no="+r.gr_no+">답글</button>";
				isMem += "<button class='reReport btn btn-outline-dark' gr_no="+r.gr_no+">신고</button>";
				isMem += "</sec:authorize>";
				var td5 = $("<td></td>").append(isMem);			
				tr.append(td,td1,td2,td3,td4,td5);

				
				//채은) 05/13 대댓글작업 시작~!
				$(document).on("click",".reReply",function(){			
					var id_find = "<sec:authorize access='isAuthenticated()'><sec:authentication property='principal.username'/></sec:authorize>";
					var login_id = $("<div></div>").append(id_find);
					$("#rereplyInput").remove();
					
					var par = $(this).parent().parent();
					//원댓글의 댓글번호
					var origin_gr_no = par.children(":eq(0)").children(":eq(0)").val();
					//원댓글의 댓글쓴 id
					var origin_id = par.children(":eq(1)").html();//댓글번호
//					console.log("gr_no:"+origin_gr_no+"m_id:"+origin_id+" /g_no:"+g_no);
					var id = "@"+origin_id+"&nbsp;&nbsp;"+login_id.html()+":";
					var tr = $("<tr id='rereplyInput'><td></td></tr>");
					var input = $("<input type='text'>");
					var btnReInsert = $("<button class='insertReReply  btn btn-outline-dark'>등록</button>");
					$(tr).append(id,input,btnReInsert);
					
					$(btnReInsert).on("click",function(){
						console.log(login_id.html);
						var re = confirm("댓글을 등록하시겠습니까? 한 번 입력한 댓글은 수정이 불가하므로 신중하게 입력해 주세요.");
						var data = {g_no:g_no , m_id:login_id.html(), gr_content:$(input).val(),gr_ref:origin_gr_no};
						if(re){
							$.ajax({
								url:"/goodsReply/insert",
								type:"POST",
								data:data,
								beforeSend: function(xhr){
									xhr.setRequestHeader(header,token)	
								},
								cache:false, 
								success:function(result){
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
				$.ajax({
					url:"/goodsReply/insert",
					type:"POST",
					data:data,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false,
					success:function(result){
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
				$.ajax({
					url:"/goodsReply/delete",
					type:"POST",
					data:{gr_no:grno, g_no:g_no}, 
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false,
					success:function(result){
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
	<div>
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq goods.m_id }">
				<button id="updateBtn" class="btn btn-outline-dark">수정</button>
				<button id="deleteBtn" class="btn btn-outline-dark">삭제</button>
			</c:if>
		</sec:authorize>
	</div>
	
	<hr>
	<h4>댓글</h4>
   <table id="goodsReplyTable">
   </table>
   <hr>
   <sec:authorize access="isAuthenticated()">
   <form id="reply">
      <input type="hidden" name="g_no" value="<c:out value='${goods.g_no }'/>">
      <input type="hidden" name="gr_ref" value="0">
      <input type="hidden" name="gr_level" value="0">
      id:<input type="text" name="m_id" value="<sec:authentication property="principal.username"/>" readonly="readonly">
      content:<input type="text" name="gr_content" required="required">      
   </form>
   <button type="submit" id="insertReply">댓글 등록</button>
   </sec:authorize>
   
	
<%@include file="../includes/footer.jsp"%>