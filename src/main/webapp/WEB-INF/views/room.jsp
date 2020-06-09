<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp"%>
<link href="/resources/css/button.css" rel="stylesheet">
<link href="/resources/css/font.css" rel="stylesheet">

	<style>
		.roomList{
			text-align: center;
			overflow: auto;
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
			var tag = "<tr><th class='num' width=20%>순서</th><th class='room' width=50%>방 제목</th><th class='go' width=15%></th class='delete' width=15%><th></th></tr>";
			res.forEach(function(d, idx){
				var rn = d.roomName.trim();
				var roomNumber = d.roomNumber;
			tag += "<tr>"+
						"<td class='num'>"+(idx+1)+"</td>"+
						"<td class='room'>"+ rn +"</td>"+
						"<td class='go'><button type='button' class='btn-outline-light list-mintBtnActive' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>" +
						"<sec:authorize access='isAuthenticated()'>" +
						"<c:if test='${pinfo.username eq qnaboard.m_id}'>" +
						"<td class='delete'><button type='button' class='btn-outline-light typeBtnActive' onclick='deleteRoom("+idx+")'>삭제</button></td>" +
						"</c:if>" +
						"</sec:authorize>" +
				"</tr>";	
			});	
			
			$("#roomList").empty().append(tag);
		}
	}
	function deleteRoom(rn){
		var msg = {	roomNumber : rn	};
		console.log(msg);
		commonAjax('/delete', msg, 'POST', function(result){
			confirm("진짜 삭제하시겠습니까?");
		});
		$("#roomNumber").remove();
		self.location="/room";
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
			<h1 class="font-family">AeHo방</h1>
			<div id="roomContainer" class="roomContainer">
				<table id="roomList" class="roomList table"></table>
			</div>
			<div>
				<input type="text" name="roomName" id="roomName" class="btn btn-outline-light typeBtn subBtn">
				<button id="createRoom" class="btn btn-outline-light list-mintBtnActive">방 만들기</button>
			</div>
		</div>
	</div>

<%@include file="includes/footer.jsp"%>  