<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	$(function(){

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var m_id = $("#m_id").val();
		var trList = [];

		//선택지를 바꿀 경우를 대비한 변수
		var usersChoice = 0;

		var isChecked = function(m_id, vt_no){
			$.ajax("/vote/isChecked", {data: {m_id: m_id, vt_no: vt_no}, success: function(v){
				console.log(v);
				if(v.v_result == 1){
					usersChoice = 1;
					$("#optionAImg").css("border", "8px solid #642EFE").next().next().css("color", "#642EFE");
					$("#optionBImg").css("border", "none").next().next().css("color", "gray");
				}else if(v.v_result == 2){
					usersChoice = 2;
					$("#optionBImg").css("border", "8px solid #642EFE").next().next().css("color", "#642EFE");
					$("#optionAImg").css("border", "none").next().next().css("color", "gray");
				}else{
					$("#optionAImg").css("border", "none").next().next().css("color", "gray");
					$("#optionBImg").css("border", "none").next().next().css("color", "gray");
				}
			}});
		}

		var isEnded = function(idx){
			$("#timeText"+idx).html("00 : 00 : 00");
			$(".divA img").css("filter", "grayscale(100%)");
			$(".divB img").css("filter", "grayscale(100%)");
			$(".progress-bar").css("filter", "grayscale(100%)");
			$("tr[data-index="+idx+"]").removeClass("modalTr");
			//self.location = "/vote/vote";
		}

		//진행중인 투표 목록
		var topicList = function(){
			$.ajax("/vote/list", {success: function(list){
				var list = JSON.parse(list);
				$.each(list, function(idx, v){
					trList.push(v);
					
					var radiusContainer = $('<div style="width: 100%; height: 150px; display: inline-block; position: relative; border-radius: 30px; overflow: hidden; margin: 5px 0px 5px 0px; background: white; cursor: pointer;"></div>').attr("idx", idx);
					var textBox = $('<div style="width: inherit; height: 150px; position: absolute; display: table; z-index: 10; color: white; text-shadow: 2px 2px 5px black;"></div>');
					var text = $('<div style="display:table-cell; text-align:center; vertical-align:middle;"><h2 id="timeText'+idx+'" style="display: inline-block; text-align: center;"></h2></div>');
					var imglocBox = $('<div style="width: 110%; height: 150px; margin-left: -5%; display: inline-block; text-align: center;"></div>');
					var divA = $('<div class="divA" style="position:relative; width: 50%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var divB = $('<div class="divB" style="position:relative; width: 50%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var imgA = $('<img src="/img/vote/'+v.vt_img_a+'" style="width: 100%; margin-right: 30%; margin-top: -30%; opacity: 0.6;">');
					var imgB = $('<img src="/img/vote/'+v.vt_img_b+'" style="width: 100%; margin-right: 30%; margin-top: -30%; opacity: 0.6;">');

					divA.append(imgA);
					divB.append(imgB);
					imglocBox.append(divA, divB);
					textBox.append(text);
					radiusContainer.append(textBox, imglocBox);

					var a_per = 0;
					var b_per = 0;
					var a_html = "0%";
					var b_html = "0%";
					if(v.vt_count_a != 0 || v.vt_count_b != 0){
						a_per = v.vt_count_a / (v.vt_count_a + v.vt_count_b) * 100;
						b_per = v.vt_count_b / (v.vt_count_a + v.vt_count_b) * 100;
						a_per = a_per.toFixed(2);
						b_per = b_per.toFixed(2);
						a_html = v.vt_content.split("/")[0] + " " + a_per + "%";
						b_html = v.vt_content.split("/")[1] + " " + b_per + "%";
					}
					console.log(a_per + b_per);

					var progress = $('<div class="progress mb-5"></div>');
					var pro_barA = $('<div class="progress-bar" role="progressbar" aria-valuenow="'+a_per+'" aria-valuemin="0" aria-valuemax="100" style="width: '+a_per+'%; background: #a3a1fc;"></div>').html(a_html);
					var pro_barB = $('<div class="progress-bar" role="progressbar" aria-valuenow="'+b_per+'" aria-valuemin="0" aria-valuemax="100" style="width: '+b_per+'%; background: #d4f2f2;"></div>').html(b_html);
					progress.append(pro_barA, pro_barB);

					var tr = $('<tr class="modalTr" data-toggle="modal" data-target="#voteModal"></tr>').attr("data-index", idx);
					var tdBox = $("<td></td>").append(radiusContainer, progress);

					tr.append(tdBox);
					$("#ingTable").append(tr);

					start_timer(v.vt_end, idx);

				});
				console.log(trList);
			}});
		}
		
		var remainInterval;

		var start_timer = function(endTime, idx){
			remainInterval = setInterval( function(){ remainTime(endTime, idx); }, 1000 );
		}

		var remainTime = function(endTime, idx){
			var start = new Date().getTime();
			var end = new Date(endTime).getTime();
			var remain = end - start;
			
			var hours = Math.floor(remain / (1000*60*60));
			var min = Math.floor((remain / (1000 * 60 )) % 60 );
			var sec = Math.floor((remain / 1000) % 60);

			if(hours < 10){ hours = "0" + hours }
			if(min < 10){ min = "0" + min }
			if(sec < 10){ sec = "0" + sec }

			var text_time = hours + " : " + min + " : " + sec;

			$("#timeText"+idx).html(text_time);
			
			if(remain < 0){
				clearInterval(remainInterval);
				$.ajax({
					type: "POST",
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false, 
		            url: "/vote/updateState",
					data: {vt_no: trList[idx].vt_no},
					success: function(re){
						if(re > 0){
							self.location = "/vote/vote";							
						}
					}
				});
			}else{
				remain = remain - 1000;
			}
		}

		


		//마감된 투표 목록
		var endedTopicList = function(){
			$.ajax("/vote/listEnded", {success: function(list){
				var list = JSON.parse(list);
				$.each(list, function(idx, v){
					
					var radiusContainer = $('<div style="width: 100%; height: 150px; display: inline-block; position: relative; border-radius: 30px; overflow: hidden; margin: 5px 0px 5px 0px; background: white;"></div>').attr("idx", idx);
					var textBox = $('<div style="width: inherit; height: 150px; position: absolute; display: table; z-index: 10; color: white; text-shadow: 2px 2px 5px black;"></div>');
					var text = $('<div style="display:table-cell; text-align:center; vertical-align:middle;"><h2 id="endedtimeText'+idx+'" style="display: inline-block; text-align: center;"></h2></div>');
					var imglocBox = $('<div style="width: 110%; height: 150px; margin-left: -5%; display: inline-block; text-align: center;"></div>');
					var divA = $('<div class="divA" style="position:relative; width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var divB = $('<div class="divB" style="position:relative; width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var imgA = $('<img src="/img/vote/'+v.vt_img_a+'" style="width: 100%; margin-right: 50%; margin-top: -20%; opacity: 0.6; filter: grayscale(100%);">');
					var imgB = $('<img src="/img/vote/'+v.vt_img_b+'" style="width: 100%; margin-right: 50%; margin-top: -20%; opacity: 0.6; filter: grayscale(100%);">');

					divA.append(imgA);
					divB.append(imgB);
					imglocBox.append(divA, divB);
					textBox.append(text);
					radiusContainer.append(textBox, imglocBox);

					var a_per = 0;
					var b_per = 0;
					var a_html = "0%";
					var b_html = "0%";
					
					if(v.vt_count_a != 0 || v.vt_count_b != 0){
						a_per = v.vt_count_a / (v.vt_count_a + v.vt_count_b) * 100;
						b_per = v.vt_count_b / (v.vt_count_a + v.vt_count_b) * 100;
						a_per = a_per.toFixed(2);
						b_per = b_per.toFixed(2);
						a_html = v.vt_content.split("/")[0] + " " + a_per + "%";
						b_html = v.vt_content.split("/")[1] + " " + b_per + "%";
					}

					var progress = $('<div class="progress mb-5"></div>');
					var pro_barA = $('<div class="progress-bar" role="progressbar" aria-valuenow="'+a_per+'" aria-valuemin="0" aria-valuemax="100" style="width: '+a_per+'%; background: #a3a1fc; filter: grayscale(100%);"></div>').html(a_html);
					var pro_barB = $('<div class="progress-bar" role="progressbar" aria-valuenow="'+b_per+'" aria-valuemin="0" aria-valuemax="100" style="width: '+b_per+'%; background: #d4f2f2; filter: grayscale(100%);"></div>').html(b_html);
					progress.append(pro_barA, pro_barB);

					

					var tr = $('<tr></tr>');
					var tdBox = $("<td></td>").append(radiusContainer, progress);

					tr.append(tdBox);
					$("#endedTable").append(tr);
					$("#endedtimeText"+idx).html("00 : 00 : 00");
				});
			}});
		}

		topicList();
		endedTopicList();

		var vt;

		$("#voteModal").on('hidden.bs.modal', function(e){
			self.location = "/vote/vote";
			//modal이 여러번 닫히는 동작을 실행할 때 위 함수를 한번만 호출하도록 하는 이벤트 핸들러
			e.stopImmediatePropagation(); 
		});
		
		$(".modalTr").on("click", function(){
			$("#voteModal").modal('show');
		});
		//modal 트리거: modal을 띄우는 함수
		$('#voteModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget)
			var idx = button.data('index');
			var modal = $(this);
			vt = trList[idx];
			console.log(vt);
			isChecked(m_id, vt.vt_no);
			modal.find('.modalheader #myModalLabel').html(vt.vt_content.split("/")[0] + " VS " + vt.vt_content.split("/")[1]);
			modal.find('.modal-body #option_A').html("<img id='optionAImg' class='mb-3' width='300px' height='300px' style='border-radius: 50%;' src='/img/vote/"+vt.vt_img_a+"'/><br><h4 style='color:gray'>♥ <b id='countA'>"+vt.vt_count_a+"</b></h4>").attr("idx", idx).attr("option", "a");
			modal.find('.modal-body #option_B').html("<img id='optionBImg' class='mb-3' width='300px' height='300px' style='border-radius: 50%;' src='/img/vote/"+vt.vt_img_b+"'/><br><h4 style='color:gray'>♥ <b id='countB'>"+vt.vt_count_b+"</b></h4>").attr("idx", idx).attr("option", "b");
		});
		
		var option = '';

		//modal의 선택지 중 하나를 선택
		$(".option").on("click", function(){
			if(m_id == "" || m_id == null){
				swal({
					  text: "로그인 후 이용 가능한 서비스입니다.\n로그인 화면으로 이동할까요?",
					  icon: "warning",
					  buttons: ["아니오", "예"]
				}).then((예) => {
				    if (예) {
						location.href="/loginCustom";
				    }else{
				    	return false;
				    }
				});
			}
			option= $(this).attr("option");
			$(".option").children("img").css("border", "none");
			$(".option").children("h4").css("color", "gray");
			$(this).children("img").css("border", "8px solid #642EFE");
			$(this).children("h4").css("color", "#642EFE");
		});

		//[투표] 버튼을 클릭
		$(".btn-primary").click(function(){
			if(m_id == "" || m_id == null){
				swal({
					text: "로그인 후 이용 가능한 서비스입니다.\n로그인 화면으로 이동할까요?",
					  icon: "warning",
					  buttons: ["아니오", "예"]
				}).then((예) => {
				    if (예) {
						location.href="/loginCustom";
				    }else{
				    	return false;
				    }
				});
			}else{
				isChecked(m_id, vt.vt_no);
				console.log(option);
				if( option == '' ){
					swal({
						  text: "선택해주세요!",
						  icon: "warning",
						  button: "확인"
						});
				}else{
					//한번도 이 주제에 투표한 적이 없다면
					if(usersChoice == 0){
						
						var data;
						if( option == 'a' ){
							data = {m_id: m_id, vt_no: vt.vt_no, v_result: 1};
						}else if( option == 'b' ){
							data = {m_id: m_id, vt_no: vt.vt_no, v_result: 2};
						}
						$.ajax({
							url: "/vote/insert",
							beforeSend: function(xhr){
								xhr.setRequestHeader(header,token)	
							},
							cache: false, 
							data: data, 
							success: function(map){
								console.log(map);
								swal({
									  text: map.msg,
									  icon: "success",
									  button: "확인"
								}).then((확인)=>{
								if(확인){
									$("#countA").html(map.result_a);
									$("#countB").html(map.result_b);
									isChecked(m_id, vt.vt_no);
									$("#voteModal").modal("hide");
								}
							});
						}});
						
					//새로 고른 선택지와 DB의 선택지가 동일하다면
					}else if((usersChoice == 1 && option == 'a')||(usersChoice == 2 && option == 'b')){
						swal({
							  text: "이미 투표된 선택지입니다.",
							  icon: "warning",
							  button: "확인"
							});
					}else{
						swal({
							  text: "선택지를 변경하시겠습니까?",
							  icon: "info",
							  buttons: ["아니오", "예"],
							}).then((예) => {
							if (예) {
								var data;
								if( option == 'a' ){
									data = {m_id: m_id, vt_no: vt.vt_no, v_result: 1};
								}else if( option == 'b' ){
									data = {m_id: m_id, vt_no: vt.vt_no, v_result: 2};
								}
								$.ajax({
									url: "/vote/update",
									beforeSend: function(xhr){
										xhr.setRequestHeader(header,token)	
									},
									cache: false, 
									data: data, 
									success: function(map){
										swal(map.msg, {
										      icon: "success",
										      button: "확인"
										}).then((확인)=>{
											if(확인){
												$("#countA").html(map.resultA);
												$("#countB").html(map.resultB);
												isChecked(m_id, vt.vt_no);
												$("#voteModal").modal("hide");
											}
										});
								}});
							  } else {
								  option = '';
							  }
						});
					}
				}
			}
		});
	
	});
</script>
<sec:authorize access="isAuthenticated()">
	<input type="hidden" id="m_id" value="<sec:authentication property="principal.username"/>">
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<input type="hidden" id="m_id" value="">
</sec:authorize>

<h2>투표</h2>
<h4 align="center">진행중 투표</h4>
<table>
	<div style="padding: 30px;" id="ingTable"></div>
</table>

<h4 align="center">마감</h4>
<table>
	<div style="padding: 30px;" id="endedTable"></div>
</table>

<!-- modal -->
<div class="modal fade" id="voteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modalheader" style="padding: 20px;">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel" align="center"></h4>
			</div>
			<div class="modal-body" style="padding: 20px 50px 20px 50px;">
				<div id="option_A" class="option" align="center" style="display:inline-block; float:left; margin:0 auto;"></div>
				<div id="option_B" class="option" align="center" style="display:inline-block; float:right; margin:0 auto;"></div>
			</div>
			<div class="modal-footer" style="background: #A3A1FC; border: 2px solid #A3A1FC;">
				<button type="button" class="btn btn-primary" style="width: 300px; background: #5FEAC9; border: 1px solid #5FEAC9; float:none; margin:0 auto;">투표</button>				
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>  