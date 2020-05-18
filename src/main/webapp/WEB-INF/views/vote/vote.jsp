<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>

<script type="text/javascript">
	$(function(){

		var m_id = "tiger";
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

		//진행중인 투표 목록
		var topicList = function(){
			$.ajax("/vote/list", {success: function(list){
				var list = JSON.parse(list);
				$.each(list, function(idx, v){
					trList.push(v);
					var radiusContainer = $('<div style="width: 100%; height: 150px; display: inline-block; border-radius: 30px; overflow: hidden;"></div>');
					var imglocBox = $('<div style="width: 110%; height: 150px; margin-left: -5%;display: inline-block; text-align: center;"></div>');
					var divA = $('<div class="divA" style="width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var divB = $('<div class="divB" style="width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var imgA = $('<img src="/img/vote/'+v.vt_img_a+'" style="width: 100%; margin-right: 50%; margin-top: -15%;">');
					var imgB = $('<img src="/img/vote/'+v.vt_img_b+'" style="width: 100%; margin-right: 50%; margin-top: -15%;">');
					divA.append(imgA);
					divB.append(imgB);
					imglocBox.append(divA, divB);
					radiusContainer.append(imglocBox);
					var tr = $('<tr class="modalTr" data-toggle="modal" data-target="#voteModal"></tr>').attr("data-index", idx);
					var tdBox = $("<td></td>").html(radiusContainer);
					tr.append(tdBox);
					$("#ingTable").append(tr);
					
				});
				console.log(trList);
			}});
		}

		topicList();

		var vt;
		
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
			modal.find('.modalheader #myModalLabel').html(vt.vt_content);
			modal.find('.modal-body #option_A').html("<img id='optionAImg' width='300px' height='300px' style='border-radius: 50%;' src='/img/vote/"+vt.vt_img_a+"'/><br><h4 style='color:gray'>♥ <b id='countA'>"+vt.vt_count_a+"</b></h4>").attr("idx", idx).attr("option", "a");
			modal.find('.modal-body #option_B').html("<img id='optionBImg' width='300px' height='300px' style='border-radius: 50%;' src='/img/vote/"+vt.vt_img_b+"'/><br><h4 style='color:gray'>♥ <b id='countB'>"+vt.vt_count_b+"</b></h4>").attr("idx", idx).attr("option", "b");
		});
		
		var option = '';

		//modal의 선택지 중 하나를 선택
		$(".option").on("click", function(){
			option= $(this).attr("option");
			$(".option").children("img").css("border", "none");
			$(".option").children("h4").css("color", "gray");
			$(this).children("img").css("border", "8px solid #642EFE");
			$(this).children("h4").css("color", "#642EFE");
		});

		//[투표] 버튼을 클릭
		$(".btn-primary").click(function(){
			isChecked(m_id, vt.vt_no);
			console.log(option);
			if( option == '' ){
				alert("선택해주세요!");
			}else{
				//한번도 이 주제에 투표한 적이 없다면
				if(usersChoice == 0){
					
					var data;
					if( option == 'a' ){
						data = {m_id: m_id, vt_no: vt.vt_no, v_result: 1};
					}else if( option == 'b' ){
						data = {m_id: m_id, vt_no: vt.vt_no, v_result: 2};
					}
					$.ajax("/vote/insert", {data: data, success: function(map){
						console.log(map);
						alert(map.msg);
						if( option == 'a' ){
							$("#countA").html(map.result);
						}else if( option == 'b' ){
							$("#countB").html(map.result);
						}
						isChecked(m_id, vt.vt_no);
					}});
					$("#voteModal").modal("hide");
				//새로 고른 선택지와 DB의 선택지가 동일하다면
				}else if((usersChoice == 1 && option == 'a')||(usersChoice == 2 && option == 'b')){
					alert("이미 투표된 선택지입니다.");
				}else{
					var re = confirm("선택지를 변경하시겠습니까?");
					if(re){
						var data;
						if( option == 'a' ){
							data = {m_id: m_id, vt_no: vt.vt_no, v_result: 1};
						}else if( option == 'b' ){
							data = {m_id: m_id, vt_no: vt.vt_no, v_result: 2};
						}
						$.ajax("/vote/update", {data: data, success: function(map){
							alert(map.msg);
							$("#countA").html(map.resultA);
							$("#countB").html(map.resultB);
							isChecked(m_id, vt.vt_no);
						}});
						$("#voteModal").modal("hide");
					}
					if(!re){
						option = '';				
					}
				}
			}
		});

		//※ modal 창에서 투표하고, 다시 열었을 때 숫자 반영이 되지 않고 vote/vote 화면에서 새로고침을 해야 반영되는 부분 수정 要
	
	});
</script>

<h2>투표</h2>
<table>
	<div style="padding: 20px;" id="ingTable"></div>
</table>
<!-- 
<div style="padding: 20px;">
	<div style="width: 100%; height: 150px; display: inline-block; border-radius: 30px; overflow: hidden;">
		<div style="width: 110%; height: 150px; margin-left: -5%;display: inline-block; text-align: center;">
			<div class="divA" style="width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;">
				<img src="/img/vote/jajangmyeon.jpg" style="width: 100%; margin-right: 50%; margin-top: -15%;">
			</div>
			<div class="divB" style="width: 49%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;">
				<img src="/img/vote/jajangmyeon.jpg" style="width: 100%; margin-right: 50%; margin-top: -15%;">
			</div>
		</div>
	</div>
</div>
-->

<!-- modal -->
<div class="modal fade" id="voteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modalheader">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h5 class="modal-title" id="myModalLabel"></h5>
			</div>
			<div class="modal-body" style="padding: 20px 50px 20px 50px;">
				<div id="option_A" class="option" align="center" style="display:inline-block; float:left; margin:0 auto;"></div>
				<div id="option_B" class="option" align="center" style="display:inline-block; float:right; margin:0 auto;"></div>
			</div>
			<div class="modal-footer" style="background: #642EFE; border: 2px solid #642EFE;">
				<button type="button" class="btn btn-primary" style="width: 300px; background: #01DFA5; border: 1px solid #01DFA5; float:none; margin:0 auto;">투표</button>				
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>  