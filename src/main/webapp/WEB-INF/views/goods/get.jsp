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
		var logingID="<sec:authorize access='isAuthenticated()'><sec:authentication property='principal.username'/></sec:authorize>";
		//시큐리티
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var select_gref;
		var select_grno;
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
				var li  =$("<li class='list-group-item rep' idx="+idx+" r_no="+r.gr_no+"></li>")
			 	var replyDiv = $("<div class='row'></div>");
			 	
				var idDiv = $("<div class=col-2></div>");
				var replyID=$("<p></p>").html(r.m_id);
				idDiv.append(replyID);
				var contentDiv=$("<div class='col-6 reContent'></div>").attr("gr_no",r.gr_no).attr("gr_ref",r.gr_ref);
				var contentP = $("<p></p>");
				var replyString="";
				if(r.gr_level != 0){
					contentDiv.append($("<p><img src='/img/reply.png' width='45px' height='45px' align='left'></p>"));
					replyString ="@"+r.gr_refid+"&nbsp;&nbsp;";
 	 			}
				contentP.html(replyString+r.gr_content);
				contentDiv.append(contentP);

				var dateDiv=$("<div class=col-2></div>");
				var replyDate = $("<p></p>").html(r.gr_date);
				dateDiv.append(replyDate);

				//신고
				var reportDiv=$("<div class=col-1></div>");
				var repStr = "<sec:authorize access='isAuthenticated()'>";
				repStr += "<img class='reportICON' width=20px height=20px src='/img/reportICON.svg'></img>"
				repStr +="</sec:authorize>";				
				reportDiv.append(repStr);

				//삭제
				var deleteDiv=$("<div class=col-1></div>");				
				var delStr = "";
				
				delStr += "<sec:authorize access='isAuthenticated()'>"
				if("<sec:authentication property='principal.username'/>"==r.m_id){
					delStr += "<img class='delICON' width=20px height=20px src='/img/deleteICON.svg' r_no="+r.r_no+"></img></button>"
				}
				delStr += "</sec:authorize>"						
				
				deleteDiv.append(delStr)

				replyDiv.append(idDiv,contentDiv,dateDiv,reportDiv,deleteDiv);
				
				if(r.gr_state == 1 && r.gr_reCnt != 0){
					var deletedReply = $("<div></div>").html("삭제된 댓글입니다.");
					li.append(deletedReply)
				}
				else{
					li.append(replyDiv);
				}
				$("#goodsReplyList").append(li);
			})
		}})
				
		$(document).on("click",".reContent",function(){
			$(".reInputDiv").remove();
			select_gref=$(this).attr("gr_ref");
			select_grno=$(this).attr("gr_no");
			var reInputDiv = $("<div class='reInputDiv row'></div>");
			
			var div = $("<div class='col-1'></div>");
			var idDiv = $("<div class='col-2'></div>");
			var loginId = $("<p></p>").html(logingID);
			idDiv.append(loginId);

			var contentDiv = $("<div class='col-7'></div>");
			var reReContent = $("<input type='text' class='form-control' id='reReContent'>");
			contentDiv.append(reReContent);
			var buttenDiv = $("<div class='col-2'></div>");
			var reButton = $("<button type='submit' id='insertReReply' class='btn btn-outline-dark'>등록</button>");
			buttenDiv.append(reButton);

			reInputDiv.append(div,idDiv,contentDiv,buttenDiv); 
			$(this).parent().parent().append(reInputDiv);	
		})
				
		$(document).on("click","#insertReReply",function(){
			if(logingID == null || logingID == ""){
				alert("로그인해야 댓글 작성이 가능합니다.")
				return;
			}	
			var re =  confirm("Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?");
			var gr_ref=select_grno;
//			var gr_no=select_grno;
			var reReplyContent=$("#reReContent").val();
			var reReplyData = {g_no:g_no , m_id:logingID, gr_content:reReplyContent,gr_ref:gr_ref};
			if(re){
				$.ajax({
					url:"/goodsReply/insert",
					type:"POST",
					data:reReplyData,
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
						alert(result.str);
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
	<h4>Comments</h4>
	<br>
	<ul id="goodsReplyList" class="list-group list-group-flush">
	</ul>
    <hr>
   <sec:authorize access="isAuthenticated()">
   <form id="reply">
      <input type="hidden" name="g_no" value="<c:out value='${goods.g_no }'/>">
      <input type="hidden" name="gr_ref" value="0">
      <input type="hidden" name="gr_level" value="0">
      id:<input type="text" name="m_id" value="<sec:authentication property="principal.username"/>" readonly="readonly">
      content:<input type="text" name="gr_content" required="required">      
   </form>
   <button type="submit" id="insertReply" class="btn btn-outline-dark">댓글 등록</button>
   </sec:authorize>
   
	
<%@include file="../includes/footer.jsp"%>