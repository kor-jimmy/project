<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>

<script>
	$(function(){
		$("#loginButton").click(function(e){
			e.preventDefault();

			var m_id = $("#m_id").val();
			var m_pwd = $("#m_pwd").val();
			var member = {m_id:m_id,m_pwd:m_pwd}
			console.log(member);
			
/* 			$.ajax({
				url:"/checkMemberSatate",
				type:"GET",
				data:checkBoxList,
				cache:false,
				success:function(result){
					location.href="/admin/report/board";
				}
			})
			$(this).submit(); */
		})
	})
</script>

<div align="center">
	<h2 class="h2">
		AE?-Ho!에 접속하세요!
		<br><br>
	  	<small class="text-muted">
	  		아직 AE-HO에 아이디가 없다면? 
	  		<a href="/member/insert" class="btn btn-primary active" role="button" aria-pressed="true">
	  			회원가입
	  		</a>
	  	</small>
	</h2>
	<hr>
</div>
<div class="d-flex justify-content-center">
	<div class="">
		<form  action="/login" method="post" class="form-group">
			<div class="form-group">	
			    <input type="text" class="form-control form-control-lg" placeholder="아이디" id="m_id" name="username" required="required">
			</div>
			<div class="form-group">
			    <input type="password" class="form-control form-control-lg" placeholder="비밀번호" id="m_pwd" name="password" required="required">
			</div>
			<hr>
			<div class="form-group form-check">
			    <input type="checkbox" class="form-check-input" id="loginINFO">
			    <label class="form-check-label" for="loginINFO">로그인 정보 저장//아직구현안됨</label>
			</div>
			  <!-- 시큐리티 토큰 -->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<div align="center">
			<button id="loginButton" type="submit" class="btn btn-primary">로그인</button>
			</div>
			
		</form>
	</div>
</div>
<hr>
<div id="errorMsg" class="d-flex justify-content-center">
	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
	    <font color="red">
	        <p>로그인에 실패하였습니다. 다음과 같은 오류가 발생하였습니다. <br/>
	            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
	        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
	    </font>
	</c:if>
</div>



<%@include file="includes/footer.jsp"%>  
