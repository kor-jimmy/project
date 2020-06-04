<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp"%>
<style>
	#reReContent{
		float:left;
		width:80%;
	}
	#labelForRe{
		float:left;
	}
	.list-group-item-secondary{
		background: #F4F4F4;
	}
</style>
<script type="text/javascript">
	$(function(){
		//시큐리티 csrf
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var b_no = $("#b_no").val();
		var m_id = $("#m_id").val();
		var selected = $("#selected").val();

		var logingID = "<sec:authorize access='isAuthenticated()'><sec:authentication property='principal.username'/></sec:authorize>";
		var select_ref = "";
		var select_rno = "";
		var select_mid = "";
		
		$("#clickheart").hide();
		$("#clickedhate").hide();

		/*var getCDist = function(c_no){
			$.ajax("/category/get",{data: {c_no: c_no}, success: function(data){
				console.log(data);
			}});
		}*/


		//회원별 이 게시물에 love를 눌렀는지 확인 function
		var isLoved = function(m_id, b_no){
			$.ajax("/board/isLoved", {data: {m_id: m_id, b_no: b_no}, success: function(re){
				if(re == 1){
					$("#clickheart").show();
					$("#heart").hide();
				}
			}});
		}
		//회원별 이 게시물에 hate를 눌렀는지 확인 function
		var isHated = function(m_id, b_no){
			$.ajax("/board/isHated", {data: {m_id: m_id, b_no: b_no}, success: function(re){
				if(re == 1){
					$("#clickedhate").show();
					$("#hate").hide();
				}
			}});
		}

		isLoved(m_id, b_no);
		isHated(m_id, b_no);

		//게시물 수정
		$("#updateBtn").on("click",function(){
			self.location = "/board/update?b_no="+b_no;
		})
		
		
		//게시물 삭제
		$("#deleteBtn").on("click",function(){
			swal({
			    title: "게시물을 삭제 하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
			    	flag = "true";
					$.ajax("/board/delete", {
						type: 'POST', 
						data: {b_no: b_no},
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false, 
						success: function(result){
						if( result == "0"){
							swal({
								  title: "게시물 삭제에 실패 하였습니다.",
								  icon: "warning",
								  button: "확인"
								})
						}else{
							location.href="/board/list?categoryNum="+$("#c_no").val();
						}
					}});        
			    }else{
			    	
			    }
			});
			
		})
		
		//댓글 목록 ajax
		$.ajax("/reply/list",{type:"GET",data:{b_no:b_no}, success: function(reply){
			reply = JSON.parse(reply);
			console.log(reply);
			$.each(reply, function(idx,r){
				var m_id = r.m_id
				//console.log(m_id)
				// 댓글 ul로 수정.
				var li = $("<li class='list-group-item rep' idx="+idx+" r_no="+r.r_no+"></li>")
				var replyDiv = $("<div class='row'></div>");

				//댓글 쓴 유저 아이디
				var idDiv = $("<div class=col-2></div>");

				//댓글 본문
				var contentDiv=$("<div class='col-6 reContent'></div>").attr("r_ref",r.r_ref).attr("r_no",r.r_no).attr("m_id",r.m_id);
				var replyContent = $("<span class='replyContent'></span>")
				var replyString="";
				if(r.r_level != 0){
					var reReIcon = $("<img src='/img/re.png' width=45px height=45px></img>")
					//var tagID = (r.r_content).split("/")[0];
					//var indexID = (r.r_content).indexOf("/");
					//var realContent = (r.r_content).substring(indexID+1);
					//replyString = tagID+"&nbsp;&nbsp;";
					replyContent.html(r.r_content);
					contentDiv.append(reReIcon);
//					contentDiv.removeClass("reContent");
					li.addClass("list-group-item-secondary");
				}
				else{
					replyContent.html(r.r_content);
				}
				contentDiv.append(replyContent);
				
				var replyID = $("<span></span>").html(r.m_nick);
				idDiv.append(replyID);
				
				//댓글 날짜
				var dateDiv=$("<div class=col-2></div>");
				var r_date = moment(r.r_date).format('YYYY-MM-DD HH:mm:ss');
				var replyDate = $("<p></p>").html(r_date);
				
				dateDiv.append(replyDate)
				
				//신고
				var reportDiv=$("<div class=col-1></div>");
				//var reportICON = $("<img width=20px height=20px></img>").attr("src","/img/reportICON.svg");

				var repStr = "<sec:authorize access='isAuthenticated()'>";
				if("<sec:authentication property='principal.username'/>"!=r.m_id){
					repStr += "<img class='replyReport' width=20px height=20px src='/img/reportICON.svg' r_no="+r.r_no+"></img>"
				}
				repStr +="</sec:authorize>";
				
				reportDiv.append(repStr);
				

				//삭제
				var deleteDiv=$("<div class=col-1></div>");
				//var deleteICON=$("<img width=20px height=20px></img>").attr("src","/img/deleteICON.svg");
				
				var delStr = "";
				
				delStr += "<sec:authorize access='isAuthenticated()'>"
				if("<sec:authentication property='principal.username'/>"==r.m_id){
					delStr += "<img class='delICON' width=20px height=20px src='/img/deleteICON.svg' r_no="+r.r_no+"></img></button>"
				}
				delStr += "</sec:authorize>"						
				
				deleteDiv.append(delStr)

				replyDiv.append(idDiv,contentDiv,reportDiv,deleteDiv,dateDiv);

				if(r.r_state == 1 && r.r_reCnt != 0){
					var deletedReply = $("<div style='text-align: center; color: gray;'></div>").html("삭제된 댓글입니다.");
					li.append(deletedReply);
				}
				else if(r.r_state == 1 && r.r_reCnt == 0){
					return false;
				}
				else{
					li.append(replyDiv);
				}				
				$("#replyList").append(li);

				//관리자 페이지에서 신고된 댓글이 달린 게시물로 이동할 때 해당 댓글에 표시
				if(selected == r.r_no){
					li.css("background", "#FFFBDE");
					var offset = li.offset();
					console.log(offset);
					$("html").animate({scrollTop : offset.top}, 300);
				}

				
/*  				var tr = $("<tr class='rep' r_no="+r.r_no+"></tr>");
 				var reRe = $("<tr class='reReply' r_no="+r.r_no+" bgcolor=#BAE1FF></tr>").hide();	
				//var button= $("<button class='deleteReply'></button>").text("삭제").attr("r_no",r.r_no);
				var td1 = $("<td width=10%></td>").html(r.m_id);
				var td2 = $("<td width=50%></td>").html(r.r_content);
				//날짜 양식 맞춰야함.
				var td3 = $("<td width=20%></td>").html(r.r_date);
				var td4 = $("<td width=10%></td>").html("신고버튼");
				var td5 = $("<td width=10%></td>");

				var retd1=$("<td bgcolor=white></td>");
				var retd2=$("<td></td>");
				var reReContent = $("<input type=text id=r_contet>");
				var retd3=$("<td></td>");
				var retd4=$("<td></td>");
				var retd5=$("<td></td>");
				reRe.append(retd1,retd2,retd3,retd4,retd5)
				
				//댓글 번호 추가 05/19
				var secStr = "";
				secStr += "<sec:authorize access='isAuthenticated()'>"
				if("<sec:authentication property='principal.username'/>"==r.m_id){
					secStr += "<button class='deleteReply btn btn-outline-dark' r_no="+r.r_no+">삭제</button>"
				}
				secStr += "</sec:authorize>"			
				td5.append(secStr);
				tr.append(td1,td2,td3,td4,td5);

				
				$("#replyTable").append(tr,reRe); */
				
			})
		}})
		
		//대댓글작업
		$(document).on("click",".reContent",function(){
//			console.log(logingID);
			$(".reInputDiv").remove();
			select_ref = $(this).attr("r_ref");
			select_rno = $(this).attr("r_no");
			select_mid = $(this).attr("m_id");
			console.log(select_ref);

			var reID ="@" +select_mid+"/";

			var reInputDiv = $("<div class='reInputDiv row'></div>");

			//빈공간
			var div = $("<div class='col-1'></div>");
			
			var idDiv = $("<div class='col-2'></div>");
			var loginId = $("<p></p>").html(logingID);
			idDiv.append(loginId);
			
			var contentDiv = $("<div class='col-7'></div>");
			var reContentLabel = $("<label for='reReContent' id='labelForRe'></label>").text(reID);
			var reReContent = $("<input type='text' class='form-control' id='reReContent'>");
			contentDiv.append(reContentLabel,reReContent);

			var buttenDiv = $("<div class='col-2'></div>");
			var reButton = $("<button type='submit' id='insertReReply' class='btn btn-outline-dark'>등록</button>");
			buttenDiv.append(reButton);

			reInputDiv.append(div,idDiv,contentDiv,buttenDiv); 

			//var secStr = "<sec:authorize access='isAuthenticated()'>"+reInputDiv+"</sec:authorize>"
			
			$(this).parent().parent().append(reInputDiv);
		})
		
		//대댓글 등록
		$(document).on("click","#insertReReply",function(e){
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
			var r_ref = select_ref;
			var r_no = select_rno;
			console.log(r_ref)
			var reReplyContent = $("label[for='reReContent']").text()+$("#reReContent").val();
			var reReplyData = {b_no:b_no, m_id:logingID, r_content:reReplyContent, r_ref:r_ref, r_no:r_no}

			swal({
			    title: "대댓글 등록",
			    text: "Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
			    	$.ajax({
						url:"/reply/insert",
						type:"POST", 
						data:reReplyData,
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false,
						success:function(result){
							/*	swal({
							    title: "댓글 등록에 성공하였습니다!",
							    icon: "success",
							    buttons: "YES"
							}) */
							location.href="/board/get?b_no="+b_no;
					}})      
			    }else{
			    	
			    }
			});
			
		})

		//댓글 등록 ajax
		$("#insertReply").on("click",function(e){
			var r = $("#boardReply").serialize();
			console.log(r);
			swal({
			    title: "댓글 등록",
			    text: "Ae-Ho는 클린한 웹 서비스를 위하여 댓글 수정 기능을 지원하지 않습니다. 착한 댓글을 등록하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
			    	$.ajax({
						url:"/reply/insert",
						type:"POST", 
						data:r,
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false,
						success:function(result){
							/*	swal({
							    title: "댓글 등록에 성공하였습니다!",
							    icon: "success",
							    buttons: "YES"
							}) */
							location.href="/board/get?b_no="+b_no;
					}})      
			    }else{
			    	
			    }
			});
		})

		//댓글 삭제 ajax 기능구현부터!
		$(document).on("click",".delICON",function(){
			var rno = $(this).attr("r_no");
			
			swal({
			    title: "댓글 삭제",
			    text: "해당 댓글을 삭제하시겠습니까?",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
					$.ajax({
						url:"/reply/delete",
						type:"POST",
						data:{r_no:rno, b_no:b_no},
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache:false,
						success:function(result){
							location.href="/board/get?b_no="+b_no;
						}
					})    
			    }else{
			    	
			    }
			});
			
		})
		
		//좋아요 등록
		$(document).on("click","#heart",function(){
			if(m_id == "" || m_id == null){
				swal({
					  text: "로그인 후 이용 가능한 서비스입니다.",
					  icon: "warning",
					  button: "확인"
					});
			}else{
				$.ajax({
					url: "/board/insertLove",
					type: "POST", 
					data: {m_id: m_id, b_no: b_no},
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false, 
					success: function(result){
					//alert(result);
					if(result == 1){
						$("#clickheart").show();
						$("#heart").hide();
						$("#loveCnt").html(eval($("#loveCnt").html())+1);
					}
					
				}});
			}
		})
		
		//싫어요 등록
		$(document).on("click", "#hate", function(){
			if(m_id == "" || m_id == null){
				swal({
					  text: "로그인 후 이용 가능한 서비스입니다.",
					  icon: "warning",
					  button: "확인"
					});
			}else{
				$.ajax({
					url: "/board/insertHate",
					type: "POST", 
					data: {m_id: m_id, b_no: b_no},
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false, 
					success: function(result){
					if(result == 1){
						$("#clickedhate").show();
						$("#hate").hide();
						$("#hateCnt").html(eval($("#hateCnt").html())+1);
					}
				}});
			}
		});

		//좋아요 취소
		$(document).on("click","#clickheart",function(){
			$.ajax({
				url: "/board/deleteLove",
				type: "POST", 
				data: {m_id: m_id, b_no: b_no},
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache: false, 
				success: function(result){
				if(result == 1){
					$("#clickheart").hide();
					$("#heart").show();
					$("#loveCnt").html(eval($("#loveCnt").html())-1);
				}
			}});
		});

		//싫어요 취소
		$(document).on("click","#clickedhate",function(){
			$.ajax({
				url: "/board/deleteHate",
				type: "POST", 
				data: {m_id: m_id, b_no: b_no},
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache: false,
				success: function(result){
				if(result == 1){
					$("#clickedhate").hide();
					$("#hate").show();
					$("#hateCnt").html(eval($("#hateCnt").html())-1);
				}
			}});
		})

		//게시물 신고
		$("#boardReport").click(function(e){
			//rc_code 1번은 게시물.
			var report = {rc_code:1,m_id:logingID,b_no:b_no}
			console.log(report);

			swal({
			    title: "게시물 신고",
			    text: "해당 게시물을 신고 하시겠습니까? 신고는 취소가 불가능합니다.",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
					$.ajax({
						url: "/report/boardreport",
						type: "POST", 
						data: report,
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache: false,
						success: function(result){				
							location.href="/board/get?b_no="+b_no;
						}
					});    
			    }else{
			    	return;
			    }
			});
		});

		//게시물 신고 한번만 가능하도록
		var reportBoard = function(m_id, b_no){
			$.ajax("/report/checkBoard", {data: {m_id: m_id, b_no: b_no}, success: function(re){
				if(re == 1){	
					$("#boardReport").hide();
				}else{
					$("#boardReport").show();
				}
			}});
		}
		
		reportBoard(m_id,b_no);

		//댓글신고
		$(document).on("click",".replyReport",function(e){
			//rc_code 3번은 댓글.
			var r_no = $(this).attr("r_no");
			var report = {rc_code:3,m_id:logingID,r_no:r_no}
			console.log(report);

			swal({
			    title: "댓글 신고",
			    text: "해당 댓글을 신고 하시겠습니까? 신고는 취소가 불가능합니다.",
			    icon: "info",
			    buttons: ["NO", "YES"]
			}).then((YES) => {
			    if (YES) {
			    	$.ajax({
						url:"/report/checkReply",
						data:report,
						type:"GET",
						cache: false,
						success: function(result){				
							if(result==0){
								$.ajax({
									url: "/report/replyreport",
									type: "POST", 
									data: report,
									beforeSend: function(xhr){
										xhr.setRequestHeader(header,token)	
									},
									cache: false,
									success: function(result){				
										location.href="/board/get?b_no="+b_no;
									}
								});  
							}else{
								swal({
									  title: "이미 신고한 댓글입니다.",
									  icon: "warning",
									  button: "확인"
								})
							}
						}
					})
					  
			    }else{
			    	return;
			    }
			});
		})


	})
</script>
	<input type="hidden" id="selected" value=<%= request.getParameter("selected") %>>
	<input type="hidden" id="b_no" value="${ board.b_no }">
	<input type="hidden" id="c_no" value="${ board.c_no }">
	<sec:authorize access="isAuthenticated()">
		<input type="hidden" id="m_id" value="<sec:authentication property="principal.username"/>">
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<input type="hidden" id="m_id" value="">
	</sec:authorize>
	<table class="table">
		<tr>
			<td colspan="3"><h3><c:out value="${board.b_title }"/></h3></td>
			<td>
				<img id="heart" src="/img/heart.png" width="30" height="30">
				<img id="clickheart" src="/img/clickheart.png" width="30" height="30">
				<img id="hate" src="/img/hate.png" width="30" height="30">
				<img id="clickedhate" src="/img/clickedhate.png" width="30" height="30">
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username != board.m_id}">
						<img id='boardReport' width=20px height=20px src='/img/reportICON.svg'>	
					</c:if>
				</sec:authorize>		
			</td>
		</tr>
		<tr>
			<td width="45%"><c:out value="${board.m_nick }"/></td>
			<td width="15%">작성일 <fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
			<td width="15%">수정일 <fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_updatedate }"/></td>
			<td width="25%">조회 <c:out value="${board.b_hit }"/>  / Love <c:out value="<span id='loveCnt'>${ board.b_lovecnt }</span>" escapeXml="false"/> / hate <c:out value="<span id='hateCnt'>${ board.b_hatecnt }</span>" escapeXml="false"/></td>
		</tr>
		<tr>
			<td colspan="4" height="500px">
				<div>${board.b_content }</div>
			</td>
		</tr>
	</table>
	<hr>
	<div>			
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.m_id}">
					<button id="updateBtn" class="btn btn-outline-dark">수정</button>
					<button id="deleteBtn" class="btn btn-outline-dark">삭제</button>			
			</c:if>
		</sec:authorize>		
    </div>
    
	<hr>
	<!-- 댓글목록 -->
	<h4>Comments</h4>
	<br>
	<ul id="replyList" class="list-group list-group-flush">
	</ul>
	<!-- end 댓글목록 -->
	<hr>
	<sec:authorize access="isAuthenticated()">
			<form id="boardReply">
				<div id="replyDiv" class="form-row align-items-center">
					<input type="hidden" name="b_no" value="<c:out value='${board.b_no }'/>">
					<input type="hidden" name="r_ref" value="0"/>
					<input type="hidden" name="r_level" value="0"/>
					<div class="col-sm-2 my-1">
						<input class="form-control" type="text" name="m_id" value="<sec:authentication property="principal.username"/>" readonly="readonly">
					</div>
					<div class="col-sm-8 my-1"> 
						<input class="form-control" type="text" name="r_content" required="required" placeholder="댓글을 입력하세요!">
					</div>
					<div class="col-sm-2 my-1">
						<a href="#" id="insertReply" class="badge badge-light">댓글등록</a>
					</div>
				</div>
			</form>
			
	</sec:authorize>
<%@include file="../includes/footer.jsp"%>