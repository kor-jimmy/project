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
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
//마이페이지 -닉네임유효성/비밀번호 검사/새 비밀번호 유효성/새비밀번호 확인 비교/전화번호 유효성/이메일유효성
//마이페이지 시큐리티 추가하기
	$(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$(".invalid-feedback").hide();
		var result_checkNick = false;
		
		var passwordRegEx =  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
//		var newPasswordRegEx =  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$/;
		var phoneRegEx = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
		var emailRegEx = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var isEqNewPwd = false; //새로운 비밀번호, 비밀번호 확인 둘이 서로 일치하는지
//		var validity_Pwd = false; //비밀번호는 이미 등록되어있기때문에 유효성검사는 따로 필요없음
		var validity_NewPwd = false;
		var validity_Nick = false;
		var validity_Email = false;
		var validity_Phone = false;

		var originNick = $("#m_nick").val();
		//닉네임 중복체크 --> 회원가입시와 동일
		//originNick에 원래 닉네임(상태유지로 받아온것) 넣어두고 비교
		var checkNick = function(){
			var m_nick = $("#m_nick").val();
			console.log(originNick,m_nick);
			var data = {m_nick: m_nick}
			if(m_nick != originNick){
				$.ajax("/member/isExistNick", {data: data, success: function(re){
					if(re == 0){
						$("#m_nick").css("border", "1px solid #ced4da");
						$("#feedbackForNick").html("사용가능한 닉네임입니다.").show();
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
			else{
				//닉네임 변경 없을 시에도 넘어가도록 true를 넣어줌
				result_checkNick = true;
				$("#m_nick").css("border", "1px solid #ced4da");
				$("#feedbackForNick").hide(); 
			}
			
		}
		//닉네임 중복체크
		$("#isExistNick").click(function(e){
			e.preventDefault();
			checkNick();
		});
		
		var newPwd;
		$("#m_newPwd").on("blur keyup", function() {
			newPwd = $(this).val();
			//새비밀번호 입력하고 확인 입력하고 새 비밀번호 칸 다시 수정할 때를 대비하여 둘다 key up 이벤트에 비교 걸어두기
			if($("#m_newPwdChk").val() == newPwd){
				isEqNewPwd = true;
				$("#feedbackForNewPwdChk").hide();
//				console.log("일치");
			}else{
				$("#feedbackForNewPwdChk").show();
			}
		})	
		$("#m_newPwdChk").on("blur keyup", function() {
			if($(this).val() == newPwd){
				isEqNewPwd = true;
				$("#feedbackForNewPwdChk").hide();
//				console.log("일치");
			}else{
				$("#feedbackForNewPwdChk").show();
			}
		});
		
		var checkValidity = function(){
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
			
			//password ->유효성검사x 필수입력만 하면 됨
			if($("#m_newPwd").val() == null || $("#m_newPwd").val().trim() == ""){
				$("#m_newPwd").css("border", "1px solid #FF2121");
				$("#feedbackForPwd").html("※비밀번호를 입력해주세요.").show();
			}

			//newPwd는 수정을 할 수도(채워져있음), 수정이 없을 수도(비워져있음) 있다.
			//newPwd와 newPwdChk가 비어있지 않을 때에 유효성검사
			if($("#m_newPwd").val() != null && $("#m_newPwd").val() != ""){
				//password
				if($("#m_newPwd").val() == null || $("#m_newPwd").val().trim() == ""){
					$("#m_newPwd").css("border", "1px solid #FF2121");
					$("#feedbackForNewPwd").html("※비밀번호를 입력해주세요.").show();
					validity_NewPwd = false;
				}else if($("#m_newPwd").val().length < 5 || $("#m_newPwd").val().length > 20){
					$("#m_newPwd").css("border", "1px solid #FF2121");
					$("#feedbackForNewPwd").html("※비밀번호는 5자 이상 20자 이하로 제한되어있습니다. ").show();
					validity_NewPwd = false;
				}else if(!passwordRegEx.test($("#m_newPwd").val())){
					$("#m_newPwd").css("border", "1px solid #FF2121");
					$("#feedbackForNewPwd").html("※비밀번호가 양식에 맞지 않습니다.<br>영문, 숫자, 특수문자가 포함되어야 합니다.").show();
					validity_NewPwd = false;
				}else{
					$("#m_newPwd").css("border", "1px solid #ced4da");
					$("#feedbackForNewPwd").hide();
					validity_NewPwd = true;
				}
			}else if($("#m_newPwd").val() == null || $("#m_newPwd").val() == ""){
				//새 비밀번호, 새비밀번호 확인칸 모두 공백이면 그냥 넘어감(수정x)
				if($("#m_newPwdChk").val() == null && $("#m_newPwdChk").val() == ""){
					validity_NewPwd = true;
				}
			}
			
			//email
			if($("#m_email").val() == null || $("#m_email").val().trim() == ""){
				$("#m_email").css("border", "1px solid #FF2121");
				$("#feedbackForEmail").html("이메일을 입력해주세요.").show();
				validity_Email = false;
			}else if(!emailRegEx.test($("#m_email").val())){
				$("#m_email").css("border", "1px solid #FF2121");
				$("#feedbackForEmail").html("이메일을 양식에 맞게 입력해주세요.").show();
				validity_Email = false;
			}else{
				$("#m_email").css("border", "1px solid #ced4da");
				$("#feedbackForEmail").hide();
				validity_Email = true;
			}
			//phone
			if($("#m_phone").val() == null || $("#m_phone").val().trim() == ""){
				$("#m_phone").css("border", "1px solid #FF2121");
				$("#feedbackForPhone").html("휴대폰 번호를 입력해주세요.");
				validity_Phone = false;
			}else if(!phoneRegEx.test($("#m_phone").val())){
				$("#m_phone").css("border", "1px solid #FF2121");
				$("#feedbackForPhone").html("하이픈(-)을 포함해 양식을 지켜주세요.")
				validity_Phone = false;
			}else{
				$("#m_phone").css("border", "1px solid #ced4da");
				$("#feedbackForPhone").hide();
				validity_Phone = true;
			}
		}
		var m_id = $("#m_id").val();
		$("#updateBtn").on("click",function(e){
			e.preventDefault();
			checkValidity();
			checkNick();

			if(validity_NewPwd && validity_Nick && validity_Email && validity_Phone){
				$.ajax({
					url: "/member/update",
					type: "POST", 
					data: $("#updateForm").serialize(),
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false,
					success: function(result){
						alert(result);
						location.href="/member/get?m_id="+m_id;
				}});
			}

			result_checkID = false;
			result_checkNick = false;
			
		})

		$(document).on("click","#myInfo",function(){
			location.href="/member/get?m_id="+$("#m_id").val();
		})
		$(document).on("click","#myContents",function(){
			location.href="/member/getMyContents?m_id="+$("#m_id").val();
		})
		$(document).on("click","#myReply",function(){
			locaion.href="member/getMyReply?m_id="+$("#m_id").val();
		})
		
	})
</script>
	<h2 id="mpTitle" style="text-align: center;">개인정보 수정</h2>
	<div class="btn-group btn-group-justified" style="margin-top: 7px;">
		<a href="/member/get?m_id=${member.m_id }" class="btn btn-primary">회원정보</a>
   		<a href="/member/mypage?m_id=${member.m_id }" class="btn btn-primary">작성글</a>
   		<a href="/member/delete?m_id=${member.m_id }" class="btn btn-primary">회원탈퇴</a>
 	</div>
 	<div id="myPageContent">
		<div style="width: 40%;">
            <form id="updateForm" class='needs-validation' novalidate>
                <div>
                  <div class="form-group">
                    <label for="m_id">ID</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="m_id" name="m_id"  value=<c:out value="${member.m_id }"/> required readonly="readonly">
                    </div> 
                  </div>
                  <div class="form-group">
                    <label for="m_pwd">Password</label>
                    <input type="password" class="form-control" id="m_pwd" name="m_pwd" placeholder="비밀번호" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$" required>
                    <font id="feedbackForPwd" class="invalid-feedback" color="red">
                        	비밀번호를 입력해주세요.
                    </font>
                  </div>
                  <div class="form-group">
                    <label for="m_newPwd">New Password</label>
                    <input type="password" class="form-control" id="m_newPwd" name="m_newPwd" placeholder="비밀번호" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$">
                     <small id="passHelp" class="form-text text-muted">암호는 영문, 숫자, 특수문자를 섞어 5자 이상 20자 이하여야 합니다.</small>
                     <font id="feedbackForNewPwd" class="invalid-feedback" color="red">
                        	비밀번호가 맞지 않습니다. 다시 입력해주세요.
                    </font>
                 </div>
                 <div class="form-group">
                    <label for="m_newPwdChk">New Password Check</label>
                    <input type="password" class="form-control" id="m_newPwdChk" name="m_newPwdChk" placeholder="비밀번호 확인" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$">
                    <font id="feedbackForNewPwdChk" class="invalid-feedback" color="red">
                        	비밀번호가 맞지 않습니다. 다시 입력해주세요.
                    </font>
                 </div>
                </div>
                
                <div class="form-group">
                    <label for="m_nick">Nickname</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="m_nick" name="m_nick" value=<c:out value="${member.m_nick }"/> required>
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
                    <input type="email" class="form-control" id="m_email" name="m_email" placeholder="aeho@example.com"  value=<c:out value="${member.m_email }"/> required>
                    <font id="feedbackForEmail" class="invalid-feedback" color="red">
                        	이메일 주소를 입력해주세요.
                    </font>
                </div>
                <div class="form-group">
                    <label for="m_phone">Phone</label>
                    <div class="input-group">
                        <input type="tel" class="form-control" id="m_phone" name="m_phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"  value=<c:out value="${member.m_phone }"/> placeholder="000-0000-0000" required>
                        <div class="input-group-append">
                            <button id="sendAuthPhone" class="btn btn-outline-secondary" type="button">변경하기</button>
                        </div>
                    </div>
                    <font id="feedbackForPhone" class="invalid-feedback" color="red">
			                        휴대폰 번호를 입력해주세요.
                    </font>
                </div>
                <button type="submit" class="btn btn-primary" id="updateBtn">수정하기</button>
            </form>
        </div>
	</div>
<%@include file="../includes/footer.jsp"%>