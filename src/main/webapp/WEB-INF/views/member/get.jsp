<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<style>
	#myPageContent{
		display: flex;
	    justify-content: center;
	    margin-top: 20px;
	}
	
	#modifyPwd{ background: white; }
	.wannaModify{ background: white; }
	
	#updateBtn{ background: #A3A1FC; border-color: #A3A1FC; }
	#updateBtn:hover{ background: #CBCAFF; border-color: #CBCAFF; }
	
	#resetBtn{ background: #BDBDBD; border-color: #BDBDBD; }
	#resetBtn:hover{ background: lightgray; border-color: lightgray; }
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){

		var user_id = "<sec:authentication property='principal.username'/>";
		$("#m_id").val(user_id);
		var user;
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var passwordRegEx =  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
		var validity_Pwd = true;
		var validity_Nick = true;
		
		$(".invalid-feedback").hide();
		$("#modifyPwdBox").hide();
		$("#modifyPwd").val("비밀번호 변경");

		$.ajax("/member/getMemberInfo", {data: {m_id: user_id}, success: function(m){
			console.log(m);
			var m = JSON.parse(m);
			user = m;
			$("#m_nick").val(m.m_nick);
		}});

		var checkNick = function(){
			var m_nick = $("#m_nick").val();
			console.log(m_nick);

			if( m_nick == user.m_nick){
				validity_Nick = true;
				$("#feedbackForNick").hide();
				$("#m_nick").css("border", "1px solid #ced4da");
				return false;
			}
			var data = {m_nick: m_nick}
			$.ajax("/member/isExistNick", {data: data, success: function(re){
				if(re == 0){
					$("#m_nick").css("border", "1px solid #23D795");
					$("#feedbackForNick").css("color", "#23D795").html("※사용 가능한 닉네임입니다.").show();
					validity_Nick = true;
				}else if(re == 1){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").css("color", "#FF2121").html("※이미 사용중인 닉네임입니다.").show(); 
					validity_Nick = false;
				}else if(re == 2){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").css("color", "#FF2121").html("※닉네임은 최소 한 글자 이상이어야 합니다.").show(); 
					validity_Nick = false;
				}else if(re == 3){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").css("color", "#FF2121").html("※닉네임은 20자를 초과할 수 없습니다.").show(); 
					validity_Nick = false;
				}
			}});
		}

		$("#m_nick").on("blur keyup", function() {
			checkNick();
		});
		

		$("#modifyPwd").click(function(){
			$.ajax("/member/isCorrectPwd", {data: {m_id: user_id, m_pwd: $("#m_pwd").val()}, success: function(re){
				if( re == 1 ){
					$("#modifyPwdBox").show();
					$("#m_pwd").attr("disabled", "disabled");
					validity_Pwd = false;
				}else{
					swal({
						  text: "비밀번호가 일치하지 않습니다!",
						  icon: "warning",
						  button: "확인"
						});
				}
			}});
		});

		var newPwd;

		var checkValidityOfPWD = function(){
			//password
			if($("#new_pwd").val() == null || $("#new_pwd").val().trim() == ""){
				$("#new_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForNewPwd").css("color", "#FF2121").html("※새 비밀번호를 입력해주세요.").show();
			}else if($("#new_pwd").val().length < 5 || $("#new_pwd").val().length > 20){
				$("#new_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForNewPwd").css("color", "#FF2121").html("※비밀번호는 5자 이상 20자 이하로 제한되어있습니다. ").show();
			}else if(!passwordRegEx.test($("#new_pwd").val())){
				$("#new_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForNewPwd").css("color", "#FF2121").html("※비밀번호가 양식에 맞지 않습니다.<br>영문, 숫자, 특수문자가 포함되어야 합니다.").show();
			}else{
				$("#new_pwd").css("border", "1px solid #23D795");
				$("#feedbackForNewPwd").css("color", "#23D795").html("※사용 가능한 비밀번호입니다.").show();
				newPwd = $("#new_pwd").val();
			}
		}

		$("#new_pwd").on("blur keyup", function() {
			checkValidityOfPWD();
		});

		var checkValidityOfPWDConfirm = function(){
			if($("#new_pwd_confirm").val() != newPwd ){
				$("#new_pwd_confirm").css("border", "1px solid #FF2121");
				$("#feedbackForNewPwdConfirm").css("color", "#FF2121").html("※비밀번호가 일치하지 않습니다.").show();
				validity_Pwd = false;
			}else{
				$("#new_pwd_confirm").css("border", "1px solid #ced4da");
				$("#feedbackForNewPwdConfirm").hide();
				validity_Pwd = true;
			}
		}
		
		$("#new_pwd_confirm").on("blur keyup", function() {
			checkValidityOfPWDConfirm();
		});

		$("#updateBtn").click(function(e){
			console.log(validity_Pwd, validity_Nick);
			e.preventDefault();
			checkValidityOfPWDConfirm();
			if( validity_Pwd && validity_Nick ){
				var data = {m_id: user_id, m_pwd: $("#new_pwd").val(), m_nick: $("#m_nick").val()};
				$.ajax("/member/update", {
					data: data, 
					type:"POST",
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false, 
					success: function(msg){
					swal({
						  text: msg,
						  icon: "success",
						  button: "확인"
					}).then((확인)=>{
						if(확인){
							location.href="/member/mypage";
						}
					});
				}});
			}
		});

		$("#resetBtn").click(function(e){
			e.preventDefault();
			location.href="/member/mypage";
		});
		
	})
</script>
	
	<h2 id="mpTitle" style="text-align: center;">개인정보 수정</h2>

 	<div id="myPageContent">
		<div style="width: 40%;">
			<form id="updateForm" class='needs-validation' novalidate>
				  <div class="form-group">
				    <label for="m_id">아이디</label>
				    <div class="input-group">
				    	<input type="text" class="form-control" id="m_id" name="m_id" disabled="disabled">
				    </div>
				  </div>
				  <div class="form-group">
				 	<label for="m_pwd">비밀번호</label>
				  	<div class="input-group">
				    	<input type="password" class="form-control" id="m_pwd" name="m_pwd" placeholder="비밀번호" required>
					    <div class="input-group-append">
							<input id="modifyPwd" class="btn btn-outline-secondary" type="button">
						</div>
				    </div>
				    <small id="passinfo" class="form-text text-muted">비밀번호를 변경하시려면 현재 비밀번호를 입력해주십시오.</small>
				  </div>
				  <div id="modifyPwdBox">
					  <div class="form-group">
					    <label for="new_pwd">새 비밀번호</label>
					    <input type="password" class="form-control" id="new_pwd" name="new_pwd" placeholder="새 비밀번호" required>
					    
					  	<small id="newpassHelp" class="form-text text-muted">영문, 숫자, 특수문자를 섞어 5자 이상 20자 이하로 입력 부탁드립니다.</small>
					  	<font id="feedbackForNewPwd" class="invalid-feedback" color="red">
					    	비밀번호를 입력해주세요.
						</font>
					  </div>
					  <div class="form-group">
					    <label for="new_pwd_confirm">새 비밀번호 확인</label>
					    <input type="password" class="form-control" id="new_pwd_confirm" name="new_pwd_confirm" placeholder="새 비밀번호" required>
					  	<small id="newpassConfirmHelp" class="form-text text-muted"></small>
					  	<font id="feedbackForNewPwdConfirm" class="invalid-feedback" color="red">
					    	비밀번호를 입력해주세요.
						</font>
					  </div>
				  </div>
				<div class="form-group">
					<label for="m_nick">닉네임</label>
					<input type="text" class="form-control" id="m_nick" name="m_nick" placeholder="닉네임" required>
					<font id="feedbackForNick" class="invalid-feedback" color="red">
				    	닉네임을 입력해주세요.
					</font>
				</div>
				<br>
				<button type="submit" class="btn btn-primary" id="updateBtn">수정하기</button>
				<button type="button" class="btn btn-primary" id="resetBtn">취소</button>
			</form>
		</div>
	</div>
<%@include file="../includes/footer.jsp"%>