<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp"%>

	<style>
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
	
	function wsOpen(){
		ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomNumber").val());
		wsEvt();
	}

	function disconnect(data){
		ws.close();
		$("#closeBtn").append();
		self.location="/room";
	}
		
	function wsEvt() {
		ws.onopen = function(data){//소켓이 열리면 동작
	}

	ws.onmessage = function(data) {//메세지 받으면 동작
		var msg = data.data;
		if(msg != null && msg.trim() != ''){
			var d = JSON.parse(msg);
			var userID = $(this).attr("m_id");
			var userData = {m_id:userID};
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
<body>
	<div id="container" class="container">
		<h1>${roomName }의 채팅방</h1>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber }">
		
		<div id="chating" class="chating">
		</div>
		
		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="text" name="userName" id="userName" value="<sec:authentication property='principal.username'/>" readonly="readonly"></th>
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
					<th><button onclick="disconnect()" value="disconnect" id="closeBtn">나가기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>

<%@include file="includes/footer.jsp"%> 