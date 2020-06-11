<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../includes/header.jsp"%>
<style>
	#mainBox{ width: 100%; margin-top: 100px; }
	.contentsBox{ width: 45%; height: auto; display: inline-block; border: 1px solid lightgray; background: rgba(255, 255, 255, 0.7); border-radius: 30px; padding: 40px 40px 60px 40px; }
	.inputBox{ width: 95%; height: 270px; text-align: left; }
</style>
<script>
$(function(){
	/* 아이디 찾기 */
	var sendEmailForID = function(email){
		$.ajax("/member/sendMailForID", {data: {email: email}, success: function(){
			swal({
				text: "메일 주소로 아이디를 보냈습니다.",
				icon: "success",
				button: "확인"
			}).then((확인)=>{
				if(확인){
					location.href="/loginCustom";
				}
			});
		}});
	}

	$("#sendMailForID").click(function(e){
		e.preventDefault();

		var email = $("#m_email_id").val();

		if(email == ""){
			swal({
				  text: "입력이 바르지 않습니다.",
				  icon: "warning",
				  button: "확인"
				});
			return false;
		}

		$.ajax("/member/getMemberInfoByEmail", {data: {email: email}, success: function(isExist){
			console.log(isExist);

			if(isExist < 1){
				swal({
					  text: "해당 이메일로 가입된 정보가 없습니다.",
					  icon: "warning",
					  button: "확인"
					});
				return false;
			}

			sendEmailForID(email);
		}});

	});
	
	/* 비밀번호 찾기 */
	var sendEmailForPwd = function(m_id, email){
		$.ajax("/member/sendMailForPwd", {data: {m_id: m_id, email: email}, success: function(tempPwd){
			console.log(tempPwd);

			swal({
				text: "메일 주소로 새 비밀번호를 보냈습니다.",
				icon: "success",
				button: "확인"
			}).then((확인)=>{
				if(확인){
					location.href="/loginCustom";
				}
			});
			
			
		}});
	}
	

	$("#sendMailForPwd").click(function(e){
		e.preventDefault();

		var m_id = $("#m_id").val();
		var email = $("#m_email_pwd").val();

		if(m_id == "" || email == ""){
			swal({
				  text: "입력이 바르지 않습니다.",
				  icon: "warning",
				  button: "확인"
				});
			return false;
		}

		$.ajax("/member/getMemberInfo", {data: {m_id: m_id}, success: function(m){
			console.log(m);
			var m = JSON.parse(m);

			if(m == null || m == 'null'|| m.length < 1){
				swal({
					  text: "해당 ID의 회원이 존재하지 않습니다.",
					  icon: "warning",
					  button: "확인"
					});
				return false;
			}else if(m.m_email != email){
				swal({
					  text: "회원가입시에 입력한 이메일과 일치하지 않습니다.",
					  icon: "warning",
					  button: "확인"
					});
				return false;
			}

			sendEmailForPwd(m_id, email);
		}});
		
		
	});
});
</script>

<div id="mainBox" align="center">
	<div class="contentsBox">
		<h3>아이디 찾기</h3>
		<hr class="m-4">
		<br>
		<div class="inputBox">
			<div class="form-group">
				<label for="m_email">아이디를 받을 메일주소를 입력해주세요.</label>
				<div class="input-group">
					<input type="email" class="form-control" id="m_email_id" name="m_email_id" placeholder="email" required>
				</div> 
				<small class="form-text text-muted">회원가입시 등록하신 메일주소여야 합니다.</small>
				<br>
			</div>
		</div>
		<button id="sendMailForID" class="btn btn-outline-secondary" type="button">메일 보내기</button>
	</div>
	<div class="contentsBox">
		<h3>비밀번호 찾기</h3>
		<hr class="m-4">
		<br>
		<div class="inputBox">
			<div class="form-group">
				<label for="m_id">아이디를 입력해주세요.</label>
				<div class="input-group">
					<input type="email" class="form-control" id="m_id" name="m_id" placeholder="ID" required>
				</div> 
				<font id="feedbackForID" class="invalid-feedback" color="red">
				
				</font>
				<br>
				<label for="m_email">새로운 비밀번호를 받을 메일주소를 입력해주세요.</label>
				<div class="input-group">
					<input type="email" class="form-control" id="m_email_pwd" name="m_email_pwd" placeholder="email" required>
				</div> 
				<small class="form-text text-muted">회원가입시 등록하신 메일주소여야 합니다.</small>
				<font id="feedbackForID" class="invalid-feedback" color="red">
				
				</font>
				<br>
			</div>
		</div>
		<button id="sendMailForPwd" class="btn btn-outline-secondary" type="button">메일 보내기</button>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>  