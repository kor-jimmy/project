<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<style>
	#reReContent{
		float:left;
		width:80%;
	}
	#labelForRe{
		float:left;
	}
	#title, #content{
		padding: 20px;
	}
	#goodsReport{
		cursor: pointer;
	}
	
	.btn{ background: white; }
	
	tbody{
		background: rgba(255, 255, 255, 0.7);
	}
	.grayscale{
		filter: grayscale(100%);
	}
</style>
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
		var select_mid="";
		//console.log("토큰 : "+token+" / 헤더:"+header);
		
		
		//게시물 수정
		$("#updateBtn").on("click",function(){
			self.location = "/goods/update?g_no="+g_no;
		});
		//게시물 삭제
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
						swal({
						    text: result,
						    icon: "success",
						    buttons: "확인"
						})
						location.href="/goods/list";
					}});
			}
		})
		
		//댓글 목록
		$.ajax("/goodsReply/list",{type:"GET",data:{g_no:g_no}, success: function(goodsReply){
			goodsReply = JSON.parse(goodsReply)		
			//console.log(goodsReply);
			$.each(goodsReply, function(idx,r){
				//console.log(r.gr_content);
				var li  =$("<li class='list-group-item rep' idx="+idx+" r_no="+r.gr_no+"></li>")
			 	var replyDiv = $("<div class='row'></div>");
				var idDiv = $("<div class=col-2></div>");
				var replyID=$("<p></p>").html(r.m_nick);
				idDiv.append(replyID);
				var contentDiv=$("<div class='col-6 reContent'></div>").attr("gr_no",r.gr_no).attr("gr_ref",r.gr_ref).attr("m_nick",r.m_nick);
				var replyContent = $("<span class='replyContent'></span>")
				if(r.gr_level != 0){
					contentDiv.append($("<img src='/img/re.png' width='45px' height='45px'>"));
					var tagID = (r.gr_content).split("/")[0];
					var indexID = (r.gr_content).indexOf("/");
					var realContent = (r.gr_content).substring(indexID+1);
					replyContent.html(realContent);
					//li.addClass("list-group-item-warning");
					li.css("background", "#F4F4F4");
					contentDiv.removeClass("reContent");
 	 			}
				else{
					console.log("답댓글아닐때"+r.gr_no);
					replyContent.html(r.gr_content);
				}
				contentDiv.append(replyContent);

				var dateDiv=$("<div class=col-2></div>");
				var replyDate = $("<p></p>").html(r.gr_date);
				var date = new Date("yy/mm/dd");
				dateDiv.append(replyDate);

				//신고
				/*
				var reportDiv=$("<div class=col-1></div>");
				var repStr = "<sec:authorize access='isAuthenticated()'>";
				repStr += "<img class='reportICON' width=20px height=20px src='/img/reportICON.svg'></img>"
				repStr +="</sec:authorize>";				
				reportDiv.append(repStr);
				*/

				//삭제
				var deleteDiv=$("<div class=col-1></div>");				
				var delStr = "";
				
				delStr += "<sec:authorize access='isAuthenticated()'>"
				if("<sec:authentication property='principal.username'/>"==r.m_id){
					delStr += "<img class='delICON' width=20px height=20px src='/img/deleteICON.svg' gr_no="+r.gr_no+"></img></button>"
				}
				delStr += "</sec:authorize>"						
				
				deleteDiv.append(delStr)

				replyDiv.append(idDiv,contentDiv/*,reportDiv*/,deleteDiv,dateDiv);
				
				if(r.gr_state == 1 && r.gr_reCnt != 0){
					var deletedReply = $("<div style='text-align: center; color: gray; background: #F4F4F4;'></div>").html("삭제된 댓글입니다.");
					li.append(deletedReply);
				}
				else if(r.gr_state == 1 && r.gr_reCnt == 0){
					return false;
				}
				else{
					li.append(replyDiv);
				}
				$("#goodsReplyList").append(li);
			})
		}})
		
		//대댓글
		$(document).on("click",".reContent",function(){
			$(".reInputDiv").remove();
			select_gref=$(this).attr("gr_ref");
			select_grno=$(this).attr("gr_no");
			select_mnick = $(this).attr("m_nick");
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
		
		//대댓글 등록
		$(document).on("click","#insertReReply",function(){
			if(logingID == null || logingID == ""){
				swal({
					  title: "로그인이 필요한 서비스 입니다!",
					  text: "댓글을 등록하기 위해서는 로그인이 필요 합니다.",
					  icon: "warning",
					  button: "확인"
					})
				return;
			}
			//var re =  confirm("Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?");
			var gr_ref=select_grno;
			//var gr_no=select_grno;
			var reReplyContent=$("#reReContent").val();
			console.log(reReplyContent);
			var reReplyData = {g_no:g_no , m_id:logingID, gr_content:reReplyContent,gr_ref:gr_ref};
			swal({
			    title: "대댓글 등록",
			    text: "Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
				$.ajax({
					url:"/goodsReply/insert",
					type:"POST",
					data:reReplyData,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false, 
					success:function(result){
					//alert(result);
					location.href="/goods/get?g_no="+g_no;
				}})
				}else{
		    	
			    }
			});				
			//$(this).parent().remove();
		})
		
		//댓글 등록
		$("#insertReply").on("click",function(){
			var data = $("#reply").serialize();
			//var re = confirm("댓글을 등록하시겠습니까? 한 번 입력한 댓글은 수정이 불가하므로 신중하게 입력해 주세요.");
			swal({
			    title: "댓글 등록",
			    text: "Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
					$.ajax({
						url:"/goodsReply/insert",
						type:"POST",
						data:data,
						beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
						},
						cache:false,
						success:function(result){
							location.href="/goods/get?g_no="+g_no;
						}})
				}else{	    	
			    }
			});
			parentNum=0;
		})
		
		//댓글 삭제
		$(document).on("click",".delICON",function(){
			var grno = $(this).attr("gr_no");
			//var re = confirm("진짜로 댓글을 삭제하겠습니까?");
			swal({
			    title: "댓글 삭제",
			    text: "해당 댓글을 삭제하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
					$.ajax({
						url:"/goodsReply/delete",
						type:"POST",
						data:{gr_no:grno, g_no:g_no}, 
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false,
						success:function(result){
							location.href="/goods/get?g_no="+g_no;
						}
					})
				}else{
			    }
			});
		});

		var checkReport = function(logingID, g_no){
			$.ajax("/report/checkGoods", {data: {m_id: logingID, g_no: g_no}, success: function(re){
				if(re == 1){	
					$("#goodsReport").removeClass("grayscale");
				}else{
					$("#goodsReport").addClass("grayscale");
				}
			}});
		}

		checkReport(logingID, g_no);

		//굿즈 게시물 신고
		$("#goodsReport").on("click", function(){
			if(logingID == null || logingID == ""){
				swal({
					  text: "로그인 후 이용 가능한 서비스입니다.",
					  icon: "warning",
					  button: "확인"
				});
				return false;
			}

			if(logingID == $("#writer").val()){
				swal({
					  text: "본인 게시물은 신고하실 수 없습니다.",
					  icon: "info",
					  button: "확인"
				});
				return false;
			}

			var data = {rc_code: 2, m_id: logingID, g_no: g_no};
			var isClicked = $(this).attr("class");

			if(isClicked.indexOf("grayscale") == -1){
				swal({
					  text: "이미 신고한 게시물입니다.",
					  icon: "warning",
					  button: "확인"
				});
			}else{
				swal({
				    title: "굿즈 신고",
				    text: "신고는 취소가 불가능합니다.\n해당 상품 게시물을 신고 하시겠습니까?",
				    icon: "info",
				    buttons: ["아니오", "예"]
				}).then((예) => {
					if(예){
						$.ajax("/report/insertGoodsReport", {data: data, success: function(msg){
							swal({
								  text: msg,
								  icon: "success",
								  button: "확인"
							});
							checkReport(logingID, g_no);
						}});
						
					}
				});
			}
		});
	});

</script>
	<input type="hidden" id="g_no" value="${ goods.g_no }">
	<input type="hidden" id="writer" value="${ goods.m_id }">
	<table class="table table-bordered">
		<tr>
			<td id="title" colspan="6"><h3><c:out value="${goods.g_title }"/></h3></td>
		</tr>
		<tr>
			<td width="15%" align="center"><b>작성자</b></td>
			<td width="20%"><c:out value="${ goods.m_nick }"/></td>
			<td width="15%" align="center"><b>작성시간</b></td>
			<td width="30%"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${goods.g_date }"/></td>
			<td width="10%" align="center">신고</td>
			<td width="10%" align="center"><img id='goodsReport' class="goodsReport" width=20px height=20px src='/img/reportICON.svg'>	</td>
		</tr>
		<tr>
			<td colspan="6" height="500px">
			<div id="content">${goods.g_content }</div></td>
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
	<br>
	<h4>Comments</h4>
	<ul id="goodsReplyList" class="list-group list-group-flush"></ul>
	<hr>
	
	<sec:authorize access="isAuthenticated()">
	<form id="reply">
		<div id="replyDiv" class="form-row align-items-center">
			<input type="hidden" name="g_no" value="<c:out value='${ goods.g_no }'/>">
			<input type="hidden" name="gr_ref" value="0">
			<input type="hidden" name="gr_level" value="0">
		<div class="col-sm-2 my-1">
			<input class="form-control" type="text" name="m_id" value="<sec:authentication property="principal.username"/>" readonly="readonly">
		</div>
		<div class="col-sm-8 my-1">
			<input class="form-control" type="text" name="gr_content" required="required" placeholder="댓글을 입력하세요.">
		</div>
		<div class="col-sm-2 my-1">
			<a href="#" id="insertReply" class="btn btn-outline-dark">댓글등록</a>
		</div>   
	</div>
	
	</form>
   
   </sec:authorize>
   
	
<%@include file="../includes/footer.jsp"%>