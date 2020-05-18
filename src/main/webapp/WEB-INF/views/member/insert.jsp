<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){

		//email과 phone 유효성 검사는 아직. 비워놓지만 않으면 다 들어가는 상태.

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$(".invalid-feedback").hide();
		var result_checkID = false;
		var result_checkNick = false;
		var idRegEx = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
		var passwordRegEx =  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;

		var validity_ID = false;
		var validity_Pwd = false;
		var validity_Nick = false;
		var validity_Email = false;
		var validity_Phone = false;
		var validity_CheckBox = false;

		$("#m_id").on("blur keyup", function() {
			  $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣| ]/g, "" ) );
		});

		var checkID = function(e){
			var data = {m_id: $("#m_id").val()}
			//0: 사용 가능하고 글자수 적합 / 1: 사용중인 아이디 / 2: 사용 가능하나 글자수 미달 / 3: 사용 가능하나 글자수 초과 
			$.ajax("/member/isExistMember", {data: data, success: function(re){
				if(re == 0){
					result_checkID = true;
					$("#m_id").css("border", "1px solid #ced4da");
					$("#feedbackForID").hide();
				}else if(re == 1){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").html("※이미 사용중인 ID입니다.").show(); 
					result_checkID = false;
				}else if(re == 2){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").html("※ID의 글자수가 너무 적습니다.").show(); 
					result_checkID = false;
				}else if(re == 3){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").html("※ID의 글자수가 너무 많습니다.").show(); 
					result_checkID = false;
				}else if(idRegEx.test(m_id)){
					alert("ID에 특수문자를 사용할 수 없습니다.");
					result_checkID = false;
				}
			}});
		}
		
		$("#isExistID").click(function(e){
			e.preventDefault();
			checkID();
		});

		var checkNick = function(){
			var m_nick = $("#m_nick").val();
			console.log(m_nick);
			var data = {m_nick: m_nick}
			$.ajax("/member/isExistNick", {data: data, success: function(re){
				if(re == 0){
					$("#m_nick").css("border", "1px solid #ced4da");
					$("#feedbackForNick").hide();
					result_checkNick = true;
				}else if(re == 1){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").html("※이미 사용중인 닉네임입니다.").show(); 
					result_checkNick = false;
				}else if(re == 2){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").html("※닉네임의 글자수가 너무 적습니다.").show(); 
					result_checkNick = false;
				}else if(re == 3){
					$("#m_nick").css("border", "1px solid #FF2121");
					$("#feedbackForNick").html("※닉네임의 글자수가 너무 많습니다.").show(); 
					result_checkNick = false;
				}
			}});
		}

		$("#isExistNick").click(function(e){
			e.preventDefault();
			checkNick();
		});

		var checkValidity = function(){
			//ID
			if($("#m_id").val() == null || $("#m_id").val().trim() == ""){
				$("#m_id").css("border", "1px solid #FF2121");
				$("#feedbackForID").html("※ID를 입력해주세요.").show(); 
				validity_ID = false;
			}else if(!result_checkID){
				$("#m_id").css("border", "1px solid #FF2121");
				$("#feedbackForID").html("※ID 중복확인을 해주세요.").show();
				validity_ID = false;
			}else if(idRegEx.test($("#m_id").val())){
				$("#m_id").css("border", "1px solid #FF2121");
				$("#feedbackForID").html("※ID에 특수문자를 사용할 수 없습니다.").show();
				validity_ID = false;
			}else{
				$("#m_id").css("border", "1px solid #ced4da");
				$("#feedbackForID").hide();
				validity_ID = true;
			}
			//닉네임
			if($("#m_nick").val() == null || $("#m_nick").val().trim() == ""){
				$("#m_nick").css("border", "1px solid #FF2121");
				$("#feedbackForNick").html("※닉네임을 입력해주세요.").show(); 
				validity_Nick = false;
			}else if(!result_checkNick){
				$("#m_nick").css("border", "1px solid #FF2121");
				$("#feedbackForNick").html("※닉네임 중복확인을 해주세요.").show();
				validity_Nick = false;
			}else{
				$("#m_nick").css("border", "1px solid #ced4da");
				$("#feedbackForNick").hide();
				validity_Nick = true;
				
			}
			//password
			if($("#m_pwd").val() == null || $("#m_pwd").val().trim() == ""){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").html("※비밀번호를 입력해주세요.").show();
				validity_Pwd = false;
			}else if($("#m_pwd").val().length < 5 || $("#m_pwd").val().length > 20){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").html("※비밀번호는 5자 이상 20자 이하로 제한되어있습니다. ").show();
				validity_Pwd = false;
			}else if(!passwordRegEx.test($("#m_pwd").val())){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").html("※비밀번호가 양식에 맞지 않습니다.<br>영문, 숫자, 특수문자가 포함되어야 합니다.").show();
				validity_Pwd = false;
			}else{
				$("#m_pwd").css("border", "1px solid #ced4da");
				$("#feedbackForPwd").hide();
				validity_Pwd = true;
			}
			//email
			if($("#m_email").val() == null || $("#m_email").val().trim() == ""){
				$("#m_email").css("border", "1px solid #FF2121");
				validity_Email = false;
			}else{
				$("#m_email").css("border", "1px solid #ced4da");
				validity_Email = true;
			}
			//phone
			if($("#m_phone").val() == null || $("#m_phone").val().trim() == ""){
				$("#m_phone").css("border", "1px solid #FF2121");
				validity_Phone = false;
			}else{
				$("#m_phone").css("border", "1px solid #ced4da");
				validity_Phone = true;
			}
			if($("#gridCheck").is(":checked")){
				$("#feedbackForCheck").hide();
				validity_CheckBox = true;
			}else{
				$("#feedbackForCheck").show();
				validity_CheckBox = false;
			}
		}

		$("#insertBtn").click(function(e){
			e.preventDefault();
			console.log("result_checkID: "+result_checkID);
			console.log("result_checkNick: "+result_checkNick);

			checkValidity();
			checkID();
			checkNick();

			if(validity_ID && validity_Pwd && validity_Nick && validity_Email && validity_Phone && validity_CheckBox){
				$.ajax({
					url: "/member/insert",
					type: "POST", 
					data: $("#signupForm").serialize(),
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false,
					success: function(result){
						alert(result);
						location.href="/loginCustom";
				}});
			}

			result_checkID = false;
			result_checkNick = false;

			/*
			validity_ID = false;
			validity_Pwd = false;
			validity_Nick = false;
			validity_Email = false;
			validity_Phone = false;
			validity_CheckBox = false;
			*/			
		});
	});
</script>
	<h2>회원등록</h2>
	<hr>
	<div style="width: 40%;">
		<form id="signupForm" class='needs-validation' novalidate>
			<div>
			  <div class="form-group">
			    <label for="m_id">ID</label>
			    <div class="input-group">
			    	<input type="text" class="form-control" id="m_id" name="m_id" placeholder="아이디" required>
				    <div class="input-group-append">
						<button id="isExistID" class="btn btn-outline-secondary" type="button">중복확인</button>
					</div>
			    </div> 
			    <small class="form-text text-muted">ID는 5자 이상 20자 이하로 제한되어 있습니다.</small>
			    <font id="feedbackForID" class="invalid-feedback" color="red">
			    	ID를 입력해주세요.
				</font>
			  </div>
			  <div class="form-group">
			    <label for="m_pwd">Password</label>
			    <input type="password" class="form-control" id="m_pwd" name="m_pwd" placeholder="비밀번호" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$" required>
			  	<small id="passHelp" class="form-text text-muted">영문, 숫자, 특수문자를 섞어 5자 이상 20자 이하로 입력 부탁드립니다.</small>
			  	<font id="feedbackForPwd" class="invalid-feedback" color="red">
			    	비밀번호를 입력해주세요.
				</font>
			  </div>
			</div>
			<div class="form-group">
				<label for="m_nick">Nickname</label>
				<div class="input-group">
					<input type="text" class="form-control" id="m_nick" name="m_nick" placeholder="닉네임" required>
					<div class="input-group-append">
						<button id="isExistNick" class="btn btn-outline-secondary" type="button">중복확인</button>
					</div>
				</div>
				<font id="feedbackForNick" class="invalid-feedback" color="red">
			    	닉네임을 입력해주세요.
				</font>
			</div>
			<div class="form-group">
				<label for="m_email">Email</label>
				<input type="email" class="form-control" id="m_email" name="m_email" placeholder="이메일" required>
				<font id="feedbackForEmail" class="invalid-feedback" color="red">
			    	이메일 주소를 입력해주세요.
				</font>
			</div>
			<div class="form-group">
				<label for="m_phone">Phone</label>
				<div class="input-group">
					<input type="tel" class="form-control" id="m_phone" name="m_phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
					<div class="input-group-append">
						<button id="sendAuthPhone" class="btn btn-outline-secondary" type="button">인증번호 보내기</button>
					</div>
				</div>
				<font id="feedbackForPhone" class="invalid-feedback" color="red">
			    	휴대폰 번호를 입력해주세요.
				</font>
			</div>
			<div class="form-group">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="gridCheck">
					<label class="form-check-label" for="gridCheck">
						이용약관에 동의합니다.
					</label>
				</div>
				<font id="feedbackForCheck" class="invalid-feedback" color="red">
					※이용약관에 동의해주세요.
				</font>
			</div>
			<button type="submit" class="btn btn-primary" id="insertBtn">회원가입</button>
		</form>
	</div>
	<!-- 
	<form id="signupForm" method="post">
	<table>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" id="m_id" name="m_id" required="required">
				<button id="isExistID">중복 확인</button>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" id="m_pwd" name="m_pwd" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$"></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>
				<input type="text" id="m_nick" name="m_nick" required="required">
				<button id="isExistNick">중복 확인</button>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="email" id="m_email" name="m_email" required="required">
				<button id="sendAuthEmail">인증번호 보내기</button>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" id="m_phone" name="m_phone" required="required">
				<button id="sendAuthPhone">인증번호 보내기</button>
			</td>
		</tr>
	</table>
	<button id="insertBtn" disabled="true">회원등록</button>
	</form>
	-->
<%@include file="../includes/footer.jsp"%>