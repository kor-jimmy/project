<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$("#loginButton").click(function(e){
			e.preventDefault();

			var m_id = $("#m_id").val();
			var loginMember = {m_id:m_id}
			
 			$.ajax({
				url:"/checkMemberSatate",
				type:"GET",
				data:loginMember,
				cache:false,
				success:function(result){
					if(result=="null"){
						$("#loginForm").submit();
						return false;
					} 
					
					var member = JSON.parse(result);

					if(member.m_state=="ACTIVATE"){
						$("#loginForm").submit();
					}

					if(member.m_state=="DEACTIVATE"){
						var banDate = moment(member.m_bandate).format('YYYY-MM-DD');
						var today = new Date();
						var checkDate = moment(today).format('YYYY-MM-DD');
						if(checkDate>=banDate){
							$.ajax({
								url:"/updateRelease",
								type:"POST",
								beforeSend: function(xhr){
									xhr.setRequestHeader(header,token)	
								},	
								data:loginMember,
								cache:false,
								success:function(result){
									$("#loginForm").submit();
									return false;
								}
							})
						}
						swal({
							  title: "일시 정지된 계정입니다.",
							  text: member.m_id+" 회원님은 약관 위반으로 "+banDate+" 까지 일시 정지 되었습니다. ",
							  icon: "warning",
							  button: "확인"
							})
						
						return false;
					}

					
					if(member.m_state=="BAN"){
						swal({
							  title: "영구 정지된 계정입니다.",
							  text: member.m_id+" 회원님은 약관 위반으로 영구 정지 되었습니다.",
							  icon: "warning",
							  button: "확인"
							})
						return false;
					}
				}
			})

		})

		//자동 로그인 메세지
		$(document).on("click","#autoLogin",function(e){
			swal({
				  title: "자동 로그인",
				  text: "공용 PC에서 자동 로그인은 해킹 위험에 노출 될 수 있습니다.",
				  icon: "info",
				  button: "네, 알겠습니다!"
				})
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
		<form id="loginForm" action="/login" method="post" class="form-group">
			<div class="form-group">	
			    <input type="text" class="form-control form-control-lg" placeholder="아이디" id="m_id" name="username" required="required">
			</div>
			<div class="form-group">
			    <input type="password" class="form-control form-control-lg" placeholder="비밀번호" id="m_pwd" name="password" required="required">
			</div>
			<hr>
			<div class="form-group form-check" align="center">
			    <input type="checkbox" class="form-check-input" name="remember-me" id="autoLogin">
			    <label class="form-check-label" for="loginINFO">자동 로그인</label>
			    <div class="text-secondary" onclick="location.href='/member/findInfo'"><small>비밀번호 찾기</small></div>
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
