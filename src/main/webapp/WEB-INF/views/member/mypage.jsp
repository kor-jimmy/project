<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>

<style>
	.userInfo{
		text-align: center;
	}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
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
	        		<button type="button" class="btn btn-light float-right">회원 정보 수정</button>
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
	

	
<%@include file="../includes/footer.jsp"%>