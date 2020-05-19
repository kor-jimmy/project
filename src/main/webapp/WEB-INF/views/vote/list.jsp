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

		$("#addPhotoA").click(function(){
			$("#fileA").click();
			return false;
		});
		$("#addPhotoB").click(function(){
			$("#fileB").click();
			return false;
		});

		var previewA = function(e){
			if(window.FileReader){
				var file = e.target.files[0];
				var reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = function(e){
					$("#optionAImg").attr("src", reader.result);
				}
			}
		}
		
		var previewB = function(e){
			if(window.FileReader){
				var file = e.target.files[0];
				var reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = function(e){
					$("#optionBImg").attr("src", reader.result);
				}
			}
		}

		document.getElementById("fileA").addEventListener("change", previewA, false);
		document.getElementById("fileB").addEventListener("change", previewB, false);

		//진행중인 투표 목록
		var topicList = function(){
			$.ajax("/vote/list", {success: function(list){
				var list = JSON.parse(list);
				$.each(list, function(idx, v){
					trList.push(v);
					var delBtn = $('<button type="button" class="deleteBtn btn btn-outline-dark float-right">삭제</button>').attr("index", idx);
					var tr = $('<tr></tr>');
					var content = $('<td class="modalTr" data-toggle="modal" data-target="#voteModal"></td>').html(v.vt_content).attr("data-index", idx).attr("root", "getValue");
					var btnTd = $('<td></td>').append(delBtn);
					tr.append(content, btnTd);
					$("#ingTable").append(tr);
				});
				$("#insertDiv").append('<button id="insertBtn" type="button" class="mb-2 btn btn-outline-dark float-right" data-toggle="modal" data-target="#voteModal">투표 등록</button>').attr("root", "insertValue");
				console.log(trList);
			}});
		}

		topicList();
		var vt;

		$("#voteModal").on('hidden.bs.modal', function(e){
			self.location = "/vote/manage";
			e.stopImmediatePropagation(); 
		});

		
		$(".modalTr").on("click", function(){
			$("#voteModal").modal('show');
		});
		$("#insertBtn").on("click", function(){
			$("#voteModal").modal('show');
		});

		var isUpdate = false;
		
		//modal 트리거: modal을 띄우는 함수
		$('#voteModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget)
			var idx = button.data('index');
			var modal = $(this);
			vt = trList[idx];
			var root = button.attr("root");
			
			if(root == "getValue"){
				//modal.find('.modalheader #myModalLabel').html("<h4>"+vt.vt_content+"</h4>");
				$("#myModalLabel").html("투표 정보 수정");
				$(".btn-primary").html("수정");
				$(".addPhoto").html("사진 수정");
				modal.find('.modal-body #option_A img').attr("src", "/img/vote/"+vt.vt_img_a);
				modal.find('.modal-body #option_B img').attr("src", "/img/vote/"+vt.vt_img_b);
				var optionA = vt.vt_content.split("/")[0];
				var optionB = vt.vt_content.split("/")[1];
				$("#optionAname").val(optionA);
				$("#optionBname").val(optionB);
				isUpdate = true;
				$("#vt_no").val(vt.vt_no);
			}

		});
		


		//modal 내에서 [등록] 버튼을 클릭
		$(".btn-primary").click(function(e){
			e.preventDefault();
			
			var optionAname = $("#optionAname").val();
			var optionBname = $("#optionBname").val();
			//var optionAfile = $("#fileA").val();
			//var optionBfile = $("#fileB").val();
			var optionAfile = $("#optionAImg").attr("src");
			var optionBfile = $("#optionBImg").attr("src");

			//console.log(optionAfile);
			console.log(typeof($("input[name='fileA']")[0].files[0]));

			var form = new FormData();
			if(vt != null){
				form.append("vt_no", vt.vt_no);
			}else{	
				form.append("vt_no", -1);
			}
			form.append("optionAname", optionAname);
			form.append("optionBname", optionBname);

			if($("input[name='fileA']")[0].files[0]){
				form.append("fileA", $("input[name='fileA']")[0].files[0]);
			}
			if($("input[name='fileB']")[0].files[0]){
				form.append("fileB", $("input[name='fileB']")[0].files[0]);
			}
			console.log(form);

			if(optionAname != null && optionAname != '' && optionBname != null && optionBname != ''
				&& optionAfile != null && optionAfile != '' && optionBfile != null && optionBfile != ''){
				//var vt_content = optionAname + "/" + optionBname;
				//var data = {optionAname: optionAname, optionBname: optionBname, fileA: $("input[name='fileA']")[0].files[0], fileB: $("input[name='fileB']")[0].files[0]};
				if(!isUpdate){
					$.ajax({
						type: "POST",
						contentType: false,
						processData: false,
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache: false, 
			            enctype: 'multipart/form-data',
			            url: "/vote/insertVoteTopic",
						data: form, 
						success: function(msg){
							alert(msg);
							$("#voteModal").modal("hide");
						}
					});
				}else{
					$.ajax({
						type: "POST",
						contentType: false,
						processData: false,
						beforeSend: function(xhr){
							xhr.setRequestHeader(header,token)	
						},
						cache: false, 
			            enctype: 'multipart/form-data',
			            url: "/vote/updateVoteTopic",
						data: form, 
						success: function(msg){
							alert(msg);
							$("#voteModal").modal("hide");
						}
					});
				}
			}else{
				alert("입력이 바르지 않습니다.");
			}
		});

		//삭제
		$(document).on("click", ".deleteBtn", function(){
			var idx = $(this).attr("index");
			var vt = trList[idx];
			console.log("vt: "+vt);
			console.log("vt_no: "+vt.vt_no);
			
			var re = confirm("해당 투표를 삭제하시겠습니까?");
			if(re){
				$.ajax( {
					type: "POST",
					url: "/vote/deleteVoteTopic",
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache: false, 
					data: vt, 
					success: function(msg){
						alert(msg);
						self.location = "/vote/manage";
				}});
			}
		});

		//※ modal 창에서 투표하고, 다시 열었을 때 숫자 반영이 되지 않고 vote/vote 화면에서 새로고침을 해야 반영되는 부분 수정 要
		//0514 일단 location으로 처리
	});
</script>
<sec:authorize access="isAuthenticated()">
	<input type="hidden" id="m_id" value="<sec:authentication property="principal.username"/>">
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<input type="hidden" id="m_id" value="">
</sec:authorize>
<h2>투표</h2>
<div id="insertDiv">
</div>
<table class="table table-hover" id="ingTable">

</table>
<hr>

<!-- modal -->
<div class="modal fade" id="voteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<!-- <form id="form" name="form" method="POST" enctype="multipart/form-data">-->
		<div class="modal-content">
			<div class="modalheader" style="padding: 20px;">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h5 class="modal-title" id="myModalLabel" align="center">투표 등록</h5>
			</div>
			
			<div class="modal-body" style="padding: 20px 50px 0px 50px;">
				<div id="option_A" class="option" align="center" style="display:inline-block; float:left; margin:0 auto; overflow: hidden;">
					<img id='optionAImg' class="mb-3" style='width:300px; height: 300px;border: 8px solid #F0F0F0; border-radius: 50%;'/>
					<div>
						<input type="text" id="optionAname" name="optionAname" class="form-control mb-3">
					</div>
					<div class="addPhotoBtn">
						<button type="button" id="addPhotoA" class="addPhoto btn btn-outline-dark">사진 추가</button><br>
						<input type="file" name="fileA" id="fileA" style="visibility: hidden;">
					</div>
				</div>
				
				<div id="option_B" class="option mb-5" align="center" style="display:inline-block; float:right; margin:0 auto; overflow: hidden;">
					<img id='optionBImg' class="mb-3" style='width:300px; height: 300px; border: 8px solid #F0F0F0; border-radius: 50%;'/>
					<div>
						<input type="text" id="optionBname" name="optionBname" class="form-control mb-3">
					</div>
					<div class="addPhotoBtn">
						<button type="button" id="addPhotoB" class="addPhoto btn btn-outline-dark">사진 추가</button><br>
						<input type="file" name="fileB" id="fileB" style="visibility: hidden;">
					</div>
				</div>
			</div>
			<div class="modal-footer" style="background: #642EFE; border: 2px solid #642EFE;">
				<button type="button" class="btn btn-primary" style="width: 300px; background: #01DFA5; border: 1px solid #01DFA5; float:none; margin:0 auto;">등록</button>				
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>  