<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Let's Chat</title>
<style>
	*{
		margin: 0px;
		padding: 0px;
	}
	
	.container{
		width: 500px;
		margin: 0 auto;
		padding: 25px;
	}
	
	.container h1{
		text-align: left;
		padding: 5px 5px 5px 15px;
		color: pink;
		border-left: 3px solid blue;
		margin-bottom: 20px;
	}
	
	.roomContainer{
		background-color: yellow;
		width: 500px;
		height: 500px;
		overflow: auto;
	}
	
	.chatList{
		border: none;
	}
	
	.chatList th{
		border: 1px solid gray;
		background-color: #fff;
		color: black;
	}
	
	.chatList td{
		border: 1px solid gray;
		background-color: pink;
		text-align: left;
		color: black;
	}
	
	.chatList .num{
		width: 75px;
		text-align: center;
	}
	
	.chatList .room{
		width:350px;
	}
	
	.chatList .go{
		width: 71px;
		text-align: center;
	}
	
	button {
		background-color: orange;
		font-size: 14px;
		color: white;
		border: 1px solid white;
		border-radius: 5px;
		padding: 3px;
		margin: 3px;
	}
	
	.inputTable th{
		padding: 5px;
	}
	
	.inputTable input{
		width: 330px;
		height: 25px;
	}
</style>
</head>

<script type="text/javascript">
	var ws;
	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		commonAjax('/chat/getRoom', "", 'post', function(result){
			createChatingRoom(result);
		});
	}

	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {cr_name : $('#cr_name').val()};
			commonAjax('/chat/createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#cr_num").val("");
		})
	}

	function goRoom(number,name){
		location.href="/chat/moveChat?cr_num="+number+"&"+"cr_name="+name;
	}

	function createChatingRoom(res){
		if(res!=null){
			var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'></th></tr>";
			res.forEach(function(d,idx){
				var rn = d.cr_name.trim();
				var cr_num = d.cr_num;
				tag += "<tr>"+
							"<td class='num'>"+(idx+1)+"</td>" +
							"<td class='room'>"+rn+"</td>" +
							"<td class='go'><button type='button' onclick='goRoom(\""+cr_num+"\",\""+rn+"\")'>참여</button></td>" +
						"</th>";
			});
				$("#chatList").empty().append(tag);
		}
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType: contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function(res){
				calbak(res);
			}, 
			error: function(err){
				console.log('error');
				calbak(err);
			}
		})
	}
</script>
<body>
	<div class="container">
		<h1>채팅방</h1>
		<div id="roomContainer" class="roomContainer">
			<table id="chatList" class="chatList"></table>
		</div>
		<div>
			<table class="inputTable">
				<tr>
					<th>방 이름</th>
					<th><input type="text" name="cr_name" id="cr_name"></th>
					<th><button id="createRoom">방 만들기</button>></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
<%@include file="includes/footer.jsp"%>  
