<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>

<style>
	.userInfo{
		text-align: center;
	}
</style>
<script type="text/javascript">

	$(function(){

/* 		$.ajax("/member/getBoard",function(result){
			$.each(result,function(idx,item){
				var li1 = $("<li></li>").html(item.b_no);
				var li2 = $("<li></li>").html(item.b_title);
				var li3 = $("<li></li>").html(item.b_title);		
			})
		}) */
		var user_id = "<sec:authentication property='principal.username'/>";
		var data = {m_id:user_id}
		console.log(user_id);
		$.ajax({
			url:"/member/getMemberInfo",
			type:"GET",
			data:data,
			success:function(result){
				var member = JSON.parse(result);
				$("#userID").html(member.m_id);
				$("#userNICK").html(member.m_nick);
				$("#userEMAIL").html(member.m_email);
				$("#userLOVE").html(member.m_lovecnt);
				$("#userHATE").html(member.m_hatecnt);
			}
		})	

		$("#updateMember").on("click", function(){
			$("#confirmModal").modal('show');
		});

		$("#confirmBtn").on("click", function(e){
			e.preventDefault();
			$.ajax("/member/isCorrectPwd", {data: {m_id:user_id, m_pwd: $("#m_pwd").val()}, success: function(){
				location.href="/aeho";
			}});
			
		});
	})
</script>
 	<div class="row">
	    <div class="col-lg-4">
	      <div class="card shadow mb-4">
	        <!-- Card Body -->
	        <div class="card-body">
	        	<div id="userBox">
	        		<div>
	        			<div align="center">
	        				<img src="/img/userICON.png" width="80" height="80" class="rounded-circle">
<%-- 	        				<c:if test="${member.m_img == null }">
	        					
	        				</c:if>
	        				<c:if test="${member.m_img !=null }">
	        					<img src="/upload/profile/${member.m_img }">
	        				</c:if> --%>
	        			</div>
	        			<div>
		        			<ul class="list-group list-group-flush">
		        				<li class="list-group-item" >
		        					<h6><span class="badge badge-secondary">회원ID</span></h6>
		        					<div class="userInfo" id="userID"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-secondary">닉네임</span></h6>
		        					<div class="userInfo" id="userNICK"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-secondary">메일주소</span></h6>
		        					<div class="userInfo" id="userEMAIL"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-danger">누적 좋아요</span></h6>
		        					<div class="userInfo" id="userLOVE"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-danger">누적 싫어요</span></h6>
		        					<div class="userInfo" id="userHATE"></div>
		        				</li>
		        			</ul>
	        			</div>
	        		</div>
	        		<button id="updateMember" type="button" class="btn btn-light float-right">회원 정보 수정</button>
	        	</div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="col-lg-4">
	      <div class="card shadow mb-4">
	        <!-- Card Body -->
	        <div class="card-body" id="serachPickDiv">

	        </div>
	      </div>
	    </div>
	    <div class="col-lg-4">
	      <div class="card shadow mb-4">
	        <!-- Card Body -->
	        <div class="card-body">

	        </div>
	      </div>
	    </div>
	 </div>
	

	<!-- Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modalheader" style="padding: 20px;">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h5 class="modal-title" id="myModalLabel" align="center">비밀번호 확인</h5>
				</div>
				<form id="form" name="form">
					<div class="modal-body mb-3" style="padding: 20px 50px 0px 50px;">
						<div id="password" class="form-group">
						    <label for="m_pwd">비밀번호를 확인해주십시오.</label>
						    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						    <input type="password" class="form-control" id="m_pwd" name="m_pwd" required>
						</div>
					</div>
					<div class="modal-footer" style="background: #F4F4F4; border: 2px solid #F4F4F4;">
						<button id="confirmBtn" type="button" class="btn btn-dark" style="width: 300px; float:none; margin:0 auto;">확인</button>				
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	
<%@include file="../includes/footer.jsp"%>