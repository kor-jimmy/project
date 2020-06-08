<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="includes/header.jsp"%>

	<style>
		.roomList{
			text-align: center;
		}
		.mainContent{
			background: rgba(255, 255, 255, 0.7);
			border-radius: 20px;
		}
	</style>
	

<script type="text/javascript">
	//시큐리티 csrf        
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var ws;

	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		commonAjax('/getRoom', '', 'POST', function(result){
			createChatingRoom(result);
		});
	}
	
	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {	roomName : $('#roomName').val()	};

			commonAjax('/createRoom', msg, 'POST', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}


	function goRoom(number, name){
		location.href="/moveChating?roomName="+name+"&roomNumber="+number;
	}

	function createChatingRoom(res){
		if(res != null){
			var tag = "<tr><th class='num' width=20%>순서</th><th class='room' width=60%>방 제목</th><th class='go' width=20%></th></tr>";
			res.forEach(function(d, idx){
				var rn = d.roomName.trim();
				var roomNumber = d.roomNumber;
				tag += "<tr>"+
							"<td class='num'>"+(idx+1)+"</td>"+
							"<td class='room'>"+ rn +"</td>"+
							"<td class='go'><button type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>" +
							"<td class='delete'><button type='button' onclick='deleteRoom(\""+roomNumber+"\", \""+rn+"\")'>방 삭제</button></td>" +
						"</tr>";	
			});
			
			$("#roomList").empty().append(tag);
		}
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
				},
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
	
	
</script>

	<div class="row">
		<div class="col pl-5 pr-5 mainContent">
			<h1>AeHo방</h1>
			<div id="roomContainer" class="roomContainer">
				<table id="roomList" class="roomList table"></table>
			</div>
			<div>
				<input type="text" name="roomName" id="roomName">
				<button id="createRoom">방 만들기</button>
			</div>
		</div>
	</div>

<%@include file="includes/footer.jsp"%>  