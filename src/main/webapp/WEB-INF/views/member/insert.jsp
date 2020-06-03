<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<style>
	#mainBox{
		width: 100%;
		height: auto;
	}
	#contentBox{
		width: 100%;
	}
	#insertMemberBox{
		width: 40%;
		display: inline-block;
		height: auto;
	}
	.btn-outline-secondary{
		background: white;
	}
	#insertBtn{
		color: white;
	}
	
	.btnActive{
		background: #A3A1FC;
	}
	.btnActive:hover{
		background: #CBCAFF;
	}
	#termsOfServiceBox{
		border: 1px solid lightgray;
		border-radius: 20px;
		width: 50%;
		float: right;
		padding: 30px;
		background: rgba(255, 255, 255, 0.7);
	}
	#terms_content{
		height: 410px;
		overflow: auto;
		border-left: 1px solid #F4F4F4;
		color: gray;
	}
	
	#tabContent{
		background: white;
	}
	
	.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active{
		color: #8882F8 !important;
		font-weight: bold;
	}
	
	.nav-item .nav-link{
		color: gray;
	}
	
</style>
<script type="text/javascript">
	$(function(){
		
		$("#insertBtn").attr("disabled", "disabled");
		//$("#insertBtn").css("background", "lightgray");

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$(".invalid-feedback").hide();
		$("#afterSendEmail").hide();
		var result_checkID = false;
		var result_checkNick = false;
		
		var idRegEx = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
		var passwordRegEx =  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
		var phoneRegEx = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
		var emailRegEx = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		var validity_ID = false;
		var validity_Pwd = false;
		var validity_Nick = false;
		var validity_Email = false;
		var validity_Phone = false;
		var validity_CheckBox = false;

		$("#m_id").on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣| ]/g, "" ) );  
		});
		
		$("#m_id").on("keydown", function() {
			$("#m_id").css("border", "1px solid #FF2121");
			$("#feedbackForID").css("color", "#FF2121").html("※ID 중복 확인을 해주십시오.").show(); 
			validity_ID = false;
		});
		
		$("#m_nick").on("keydown", function() {
			$("#m_nick").css("border", "1px solid #FF2121");
			$("#feedbackForNick").css("color", "#FF2121").html("※닉네임 중복 확인을 해주십시오.").show(); 
			validity_Nick = false;  
		});

		

		var checkID = function(e){
			var data = {m_id: $("#m_id").val()}
			//0: 사용 가능하고 글자수 적합 / 1: 사용중인 아이디 / 2: 사용 가능하나 글자수 미달 / 3: 사용 가능하나 글자수 초과 
			$.ajax("/member/isExistMember", {data: data, success: function(re){
				if(re == 0){
					validity_ID = true;
					$("#m_id").css("border", "1px solid #23D795");
					$("#feedbackForID").css("color", "#23D795").html("※사용 가능한 ID입니다.").show();
				}else if(re == 1){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").css("color", "#FF2121").html("※이미 사용중인 ID입니다.").show(); 
					validity_ID = false;
				}else if(re == 2){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").css("color", "#FF2121").html("※ID는 5자 이상이어야 합니다.").show(); 
					validity_ID = false;
				}else if(re == 3){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").css("color", "#FF2121").html("※ID는 20자를 초과할 수 없습니다.").show(); 
					validity_ID = false;
				}else if(idRegEx.test(m_id)){
					$("#m_id").css("border", "1px solid #FF2121");
					$("#feedbackForID").css("color", "#FF2121").html("※ID에 특수문자를 사용할 수 없습니다.").show(); 
					validity_ID = false;
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

		$("#isExistNick").click(function(e){
			e.preventDefault();
			checkNick();
		});

		var authNumber = 0;
		var authentic_Email;

		var sendEmail = function(m_email){
			validity_Email = false;

			$("#authNum").attr("readonly", false);

			$("#m_email").css("border", "1px solid #ced4da");
			$("#feedbackForEmail").hide();
			authentic_Email = m_email;

			swal({
				  text: "인증번호를 보냈습니다.",
				  icon: "info",
				  button: "확인"
				});

			$("#afterSendEmail").show();
			
			$.ajax("/member/sendMail", {data: {email: m_email}, success: function(authNum){
				console.log(authNum);
				authNumber = authNum;
			}});
		}

		var checkAuthNum = function(){
			var inputNum = $("#authNum").val();
			console.log(inputNum);
			console.log(authNumber);
			if(inputNum == authNumber){
				$("#feedbackForAuthNum").hide();
				swal({
					  text: "인증번호가 확인되었습니다.\n감사합니다!",
					  icon: "success",
					  button: "확인"
					});
				$("#authNum").attr("readonly", "readonly");
				validity_Email = true;
			}else{
				$("#feedbackForAuthNum").show();
			}
		}

		var checkEmail = function(){
			//email
			if($("#m_email").val() == null || $("#m_email").val().trim() == ""){
				$("#m_email").css("border", "1px solid #FF2121");
				$("#feedbackForEmail").css("color", "#FF2121").html("※이메일을 입력해주세요.").show();
				validity_Email = false;
				return false;
			}else if(!emailRegEx.test($("#m_email").val())){
				$("#m_email").css("border", "1px solid #FF2121");
				$("#feedbackForEmail").css("color", "#FF2121").html("※이메일을 양식에 맞게 입력해주세요.").show();
				validity_Email = false;
				return false;
			}else{
				return true;
			}
		}
		
		$("#sendAuthMail").click(function(e){
			e.preventDefault();
			if(checkEmail()){
				sendEmail($("#m_email").val());
			}
		});

		$("#checkAuthNum").click(function(e){
			e.preventDefault();
			checkAuthNum();
		});

		var checkValidityOfPWD = function(){
			//password
			if($("#m_pwd").val() == null || $("#m_pwd").val().trim() == ""){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").css("color", "#FF2121").html("※비밀번호를 입력해주세요.").show();
				validity_Pwd = false;
			}else if($("#m_pwd").val().length < 5 || $("#m_pwd").val().length > 20){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").css("color", "#FF2121").html("※비밀번호는 5자 이상 20자 이하로 제한되어있습니다. ").show();
				validity_Pwd = false;
			}else if(!passwordRegEx.test($("#m_pwd").val())){
				$("#m_pwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").css("color", "#FF2121").html("※비밀번호가 양식에 맞지 않습니다.<br>영문, 숫자, 특수문자가 포함되어야 합니다.").show();
				validity_Pwd = false;
			}else{
				$("#m_pwd").css("border", "1px solid #23D795");
				$("#feedbackForPwd").css("color", "#23D795").html("※사용 가능한 비밀번호입니다.").show();
				validity_Pwd = true;
			}
		}

		$("#m_pwd").on("blur keyup", function() {
			checkValidityOfPWD();
		});

		var check_all = function(){
			if($("#gridCheck").is(":checked")){
				$("#feedbackForCheck").hide();
				validity_CheckBox = true;
			}else{
				validity_CheckBox = false;
			}
			//console.log(validity_ID + validity_Pwd + validity_Nick + validity_Email + validity_CheckBox);
			if(validity_ID && validity_Pwd && validity_Nick && validity_Email && validity_CheckBox){
				$("#insertBtn").removeAttr("disabled");
				$("#insertBtn").addClass("btnActive");
			}
		}

		setInterval(function(){check_all();}, 500);

		$("#insertBtn").click(function(e){
			e.preventDefault();

			if(authentic_Email != $("#m_email").val()){
				$("#m_email").css("border", "1px solid #FF2121");
				$("#feedbackForEmail").css("color", "#FF2121").html("※인증된 이메일이 아닙니다.").show();
				validity_Email = false;
				return false;
			}
			
			$.ajax({
				url: "/member/insert",
				type: "POST", 
				data: $("#signupForm").serialize(),
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache: false,
				success: function(result){
					swal({
						  text: result,
						  icon: "success",
						  button: "확인"
					}).then((확인)=>{
						if(확인){
							location.href="/loginCustom";
						}
					});
			}});
		});
	});
</script>
<div id="mainBox">
	<h2 class="mt-2">회원 가입</h2>
	<hr class="mb-5">
	<div id="contentBox">
	<div id="insertMemberBox" class="mr-0">
		<form id="signupForm" class='needs-validation' novalidate>
			<input type="hidden" id="m_state" name="m_state" value="ACTIVATE">
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
				<div class="input-group">
					<input type="email" class="form-control" id="m_email" name="m_email" placeholder="aeho@example.com" required>
					<div class="input-group-append">
						<button id="sendAuthMail" class="btn btn-outline-secondary" type="button">인증번호 보내기</button>
					</div>
				</div>
				<font id="feedbackForEmail" class="invalid-feedback" color="red">
			    	이메일 주소를 입력해주세요.
				</font>
			</div>
			<div class="form-group" id="afterSendEmail">
				<div class="input-group">
					<input type="number" class="form-control" id="authNum" name="authNum" placeholder="인증번호 입력" required>
					<div class="input-group-append">
						<button id="checkAuthNum" class="btn btn-outline-secondary" type="button">확인</button>
					</div>
				</div>
				<font id="feedbackForAuthNum" class="invalid-feedback" color="red">
			    	인증 번호가 일치하지 않습니다.
				</font>
			</div>
			<!-- 
			<div class="form-group">
				<label for="m_phone">Phone</label>
				<div class="input-group">
					<input type="tel" class="form-control" id="m_phone" name="m_phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000" required>
					<div class="input-group-append">
						<button id="sendAuthPhone" class="btn btn-outline-secondary" type="button">인증번호 보내기</button>
					</div>
				</div>
				<font id="feedbackForPhone" class="invalid-feedback" color="red">
			    	휴대폰 번호를 입력해주세요.
				</font>
			</div>
			-->
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
			<button type="submit" class="btn mb-5" id="insertBtn" disabled="">회원가입</button>
		</form>
	</div>
	<div id="termsOfServiceBox">
		<div id="termsOfService">
			<h5 class="mb-2">이용약관</h5>
			<ul class="nav nav-tabs" id="terms_tab" role="tablist">
				<li class="nav-item">
				  <a class="nav-link active" id="privacy_tab" data-toggle="tab" href="#privacy" role="tab" aria-controls="privacy" aria-selected="true">개인정보 처리방침</a>
				</li>
				<li class="nav-item">
				  <a class="nav-link" id="policy_tab" data-toggle="tab" href="#policy" role="tab" aria-controls="policy" aria-selected="false">운영방침</a>
				</li>
				
			</ul>
			<div id="terms_content">
				<div class="tab-content" id="tabContent">
					<div class="tab-pane fade show active" id="privacy" role="tabpanel" aria-labelledby="privacy-tab">
						<div class="p-4">
							<p><b>1. 수집하는 개인정보의 항목 및 수집방법</b></p>
							<p>가. 수집하는 개인정보의 항목</p>
							첫 째, Ae-Ho는 회원 구분과 원활한 질문/답변 상담, 서비스의 제공을 위해 회원가입시 아래의 개인정보를 수집합니다.<br>
							<small>- 아이디, 비밀번호, 닉네임, 이메일</small><br>
							<br>
							둘 째, 서비스 이용 과정에서 다음 정보들이 자동으로 수집/저장됩니다.<br>
							<small>- 로그인/로그아웃 시각 및 그 순간의 브라우저/OS 정보(Useragent)</small><br>
							<br>
							<p>나. 개인정보 수집방법</p>
							Ae-Ho는 다음과 같은 경로를 통해 개인정보를 수집합니다.<br>
							<small>- 회원 가입, 이메일 인증 (이메일 주소는 수집 후 해시화 처리되어 원형태를 알 수 없는 상태로 저장됩니다), 정보수정, 장터 SMS 인증</small><br>
							<br>
							<p><b>2. 개인정보의 수집 및 이용목적</b></p>
							가. 서비스 제공에 관한 계약 이행<br>
							특정 맞춤 서비스 제공, 개인 식별이 필요한 기능등<br>
							<br>
							나. 회원관리<br>
							회원제 서비스 이용 및 개인식별, 불량회원의 부정 이용방지, 가입 의사 확인을 통한 사이트 내의 고유 컨텐츠 유출 방지,1인 2개 이상의 ID 소유 제한, 분쟁 조정을 위한 기록보존, 불만처리, 공지사항 전달등을 위함.<br>
							<br>
							다. 신규 서비스 개발 및 광고에의 활용<br>
							신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재,	서비스의 유효성 확인, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속빈도 파악, 회원의 서비스이용에 대한 통계<br>
							<br>
							<p><b>3. 개인정보의 공유 및 제공</b></p>
							Ae-Ho는 이용자들의 개인정보를 "2. 개인정보의 수집목적 및 이용목적"에서 고지한 범위내에서 사용하며, 이용자의 사전 동의 없이는 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다.<br>
							다만, 아래의 경우에는 예외로 합니다.<br>
							<br>
							<small>- 이용자들이 사전에 공개에 동의한 경우<br>
							- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</small><br>
							<br>
							<p><b>4. 개인정보의 취급위탁</b></p>
							Ae-Ho는 외부 업체로의 개인정보 취급위탁을 하고 있지 않으며 추가 발생시 회원에게 동의를 구합니다.<br>
							<br>
							<p><b>5. 개인정보의 보유 및 이용기간</b></p>
							이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다.<br>
							단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간동안 보존합니다.<br>
							<br>
							가. Ae-Ho 내부 방침에 의한 정보 보유 사유<br>
							<small>- 부정 이용 기록<br>
							　보존 이유 : 부정 이용 방지<br>
							　보존 기간 : 최장 1년<br>
							- 로그인/로그아웃에 관한 기록<br>
							　보존 이유 : 피해자가 회원 고소를 위한 증거 보전 요청시 (법원의 명령)<br>
							　보존 기간 : 최장 1년 (연장 불가)</small><br>
							<br>
							나. 관련법령에 의한 정보 보유 사유<br>
							관계법령의 규정에 의하여 보존할 필요가 있는 경우 Ae-Ho는 관계법령에서 정한 일정한 기간동안 회원정보를 보관합니다 이 경우 Ae-Ho는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.<br>
							
							<small>- 소비자의 불만 또는 분쟁처리에 관한 기록<br>
							　보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
							　보존 기간 : 5년<br>
							- 본인 확인에 관한 기록 (이메일 주소의 해시값)<br>
							　보존 이유 : 정보통신망 이용촉진 및 정보보호 등에 관한 법률<br>
							　보존 기간 : 탈퇴 시점으로부터 1개월<br>
							- 본인 확인에 관한 기록 (SMS 인증)<br>
							　보존 이유 : 정보통신망 이용촉진 및 정보보호 등에 관한 법률<br>
							　보존 기간 : 탈퇴 시점으로부터 1년<br>
							- 본인 확인에 관한 기록 (생년월일, 성별)<br>
							　보존 이유 : 없음<br>
							　보존 기간 : 보존 안 함 (탈퇴 즉시 파기)</small><br>
							<br>
							<p><b>6. 개인정보 파기절차 및 방법</b></p>
							이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다.<br>
							Ae-Ho의 개인정보 파기절차 및 방법은 다음과 같습니다.<br>
							<br>
							가. 파기절차<br>
							<small>- 이용자가 회원가입 등을 위해 입력한 정보는 목적이 달성된 후 별도의 테이블로 옮겨져 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 보관 한 후 파기합니다.
							- 개인정보는 법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.</small><br>
							<br>
							나. 파기방법<br>
							<small>- 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</small><br>
							<br>
							<p><b>7. 이용자 및 법정대리인의 권리와 그 행사방법</b></p>
							<small>- 이용자는 로그인 후 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 직접 탈퇴 하실 수 있습니다.<br>
							- 이용자는 개인정보 조회/수정을 위해서 '나의T홈-정보수정'을 눌러야하고, 그 곳의 '탈퇴' 버튼을 이용해 이용 해지할 수 있습니다.<br>
							- 이용자가 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 그 개인정보를 이용하지 않습니다.<br>
							- 삭제된 개인정보는 '5.개인정보의 보유 및 이용기간'에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없게 합니다.</small><br>
							<br>
						</div>
					</div>
					<div class="tab-pane fade" id="policy" role="tabpanel" aria-labelledby="policy-tab">
						<div class="p-4">
							<p><b>1. 개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항</b></p>
							Ae-Ho는 개인화되고 맞춤화된 서비스를 제공하기 위해서 이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹서비스를 운영하는데 이용되는 서버가 이용자의 브라우저에게 보내는 아주 작은 텍스트 파일로 이용자 컴퓨터의 하드디스크에 저장됩니다.<br>
							<br>
							가. 쿠키의 사용 목적<br>
							각 메뉴별 개인 설정 저장, 공지사항 팝업창 제거 여부, 웹폰트 사용 여부, 자동 로그인 기능등의 제공을 위해 로그인 없이도 개인당 식별이 필요한 모든 곳에 광범위하게 사용합니다.<br>
							<br>
							나. 쿠키의 설치/운영 및 거부<br>
							<small>- 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다 따라서 이용자는 웹브라우저에서 옵션을 설정함으로서
							모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.<br>
							- 다만, 쿠키의 저장을 거부할 경우에는 Ae-Ho 일부 서비스 이용이 불가능 할 수 있습니다.<br>
							- 쿠키 설치 허용 여부를 지정하는 방법 (Internet Explorer의 경우)<br>
							　① [도구] 메뉴에서 [인터넷 옵션]을 선택합니다.<br>
							　② [개인정보 탭]을 클릭합니다.<br>
							　③ [개인정보취급 수준]을 설정하시면 됩니다.</small><br>
							<br>
							<p><b>2. 개인정보의 기술적/관리적 보호 대책</b></p>
							Ae-Ho는 이용자들의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록
							안전성 확보를 위하여 다음과 같은 기술적/관리적 대책을 강구하고 있습니다.<br>
							<br>
							가. 비밀번호/이메일주소 해시화<br>
							Ae-Ho 회원 아이디(ID)의 비밀번호와 이메일주소는 복호화가 불가능한 암호화 체계로 저장해 관리하고 있어
							설사 데이터베이스(DB)가 해킹당했을 지라도 해커는 그 정보를 알 수 없습니다. 또한, 사이트 운영자와
							심지어 본인조차 원본 데이터를 확인할 수 없는 구조로 설계되어 있습니다.<br>
							<br>
							나. 해킹 등에 대비한 대책<br>
							Ae-Ho는 해킹이나 컴퓨터 바이러스 등에 의해 회원의 개인정보가 유출되거나 훼손되는 것을 막기 위해
							최선을 다하고 있습니다 개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고, 최신 백신프로그램을
							이용하여 이용자들의 개인정보나 자료가 누출되거나 손상되지 않도록 방지하고 있으며, 암호화통신 등을
							통하여 네트워크상에서 개인정보를 안전하게 전송할 수 있도록 하고 있습니다.<br>
							그리고 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있으며, 기타 시스템적으로 보안성을
							확보하기 위한 가능한 모든 기술적 장치를 갖추려 노력하고 있습니다.<br>
							<br>
							다. 취급 운영진의 최소화 및 교육<br>
							Ae-Ho의 개인정보관련 취급 운영진은 담당자에 한정시키고 있고 이를 관리하기 위한 별도의 비밀번호를 부여하며
							직접적인 암호화 데이터에는 담당자일지라도 접근이 불가하도록 하며 담당자에 대한 수시 교육을 통하여
							Ae-Ho 개인 정보 정책의 준수를 항상 강조하고 있습니다.<br>
							<br>
							<p><b>3. 개인정보보호 관련 민원 접수 방법 및 기타 신고/상담 방법</b></p>
							귀하께서는 Ae-Ho의 서비스를 이용하며 발생하는 모든 개인정보 관련 질문을 질문·제안·신고 메뉴로 접수 할 수 있습니다.<br>
							Ae-Ho는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.<br>
							<br>
							기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.<br>
							<small>- 개인분쟁조정위원회 (www.1336.or.kr, 1336)<br>
							- 대검찰청 첨단범죄수사과 (http://www.spo.go.kr, 02-3480-2000)<br>
							- 경찰청 사이버테러대응센터 (www.ctrc.go.kr, 02-392-0330)</small><br>
							<br>
							<p><b>4. 개인정보 관리책임 부서 및 연락처</b></p>
							부서 : Ae-Ho 개인정보관리팀<br>
							연락처 : team.demo2020@gmail.com<br>
							<br>
							<p><b>12. 기타</b></p>
							Ae-Ho에 링크되어 있는 타 서비스들이 개인정보를 수집하는 행위에 대해서는 이 '개인 정보 정책'이 적용되지 않으며
							타 서비스로의 이동시 별도 안내를 하지 않으므로 주소창을 필히 확인하시기 바랍니다. (www.aeho.net)<br>
							<br>
							<p><b>5. 고지의 의무</b></p>
							현 개인 정보 정책의 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 당일부터 홈페이지의 '공지사항'과
							'전체쪽지'등을 통해 고지할 것입니다. (회원들이 익히 알고 있는 사소한 건에 대해서는 모아서 한꺼번에 통지합니다)<br>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>