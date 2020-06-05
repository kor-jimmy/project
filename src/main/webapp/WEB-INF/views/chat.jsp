<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp"%>

	<style>
/* 		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		} */
		.chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating p{
			color: #fff;
			text-align: left;
		}
		input{
			width: 330px;
			height: 25px;
		}
		#yourMsg{
			display: none;
		}
	</style>

<script type="text/javascript">
	var ws;
	var user_id = "<sec:authentication property='principal.username'/>";
	//1. 유저 아이디를 가지고 닉네임을 호출하는 ajax
	//2. 메세지를 보낼때마다 해당 정보(메세지번호(시퀀스), 아이디, 채팅방번호, 메세지내용, 날짜)를 가지고 
	//		ajax 통신을 해서 디비에 넣어주는 기능 추가.
	//3. 채팅방정보 디비에 들어가게 만듬.
	
	
	function wsOpen(){
		ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomNumber").val());
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){//소켓이 열리면 동작
		}
			
	ws.onmessage = function(data) {//메세지 받으면 동작
		var msg = data.data;
		if(msg != null && msg.trim() != ''){
			var d = JSON.parse(msg);
			if(d.type == "getId"){
				var si = d.sessionId != null ? d.sessionId : "";
				if(si != ''){
					$("#sessionId").val(si); 
				}
			}else if(d.type == "message"){
				if(d.sessionId == $("#sessionId").val()){
					$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
				}else{
					$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
				}
					
			}else{
				console.warn("unknown type!")
			}
		}
	}

	document.addEventListener("keypress", function(e){
		if(e.keyCode == 13){ //enter press
			send();
		}
	});
}

	function chatName(){
		var userName = $("#userName").val();
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {
		var option ={
			type: "message",
			roomNumber : $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");
	}
</script>

	<div>
		<h1>${roomName }의 채팅방</h1>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber }">
		
		<div id="chating" class="chating">
		</div>
		
		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="text" name="userName" id="userName" value="<sec:authentication property='principal.username'/>" required="required"></th>
					<th><button onclick="chatName()" id="startBtn">채팅방 입장</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>

<%@include file="includes/footer.jsp"%> 