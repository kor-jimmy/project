<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../header.jsp"%>

<style>
	.card-body{
		padding: 50px 70px 50px 70px;
	}
	.modalTr{
		margin-left: 20px;
		cursor: pointer;
	}
	input[type=text]{
		width: 80%;
	}
	#modalPrimaryBtn{ width: 300px; float:none; margin:0 auto;}
	
</style>

<style>
	.photo_gallery { position: relative; width: 100%; margin:0 auto; }
	.photo_gallery p.photo_img { width:100%; -webkit-box-shadow: 0px 0px 15px 0 #aaa; -moz-box-shadow: 0px 0px 15px 0 #aaa; box-shadow: 0px 0px 15px 0 #aaa; float:left; margin-right:20px; transition: all ease 0.2s 0s;}
	.photo_gallery p.photo_img img { width: 100%; }
	
	.photo_gallery p.photo_img:hover { filter: brightness(0.60); cursor: pointer; }
	.darkness_img{filter: brightness(0.60); cursor: pointer;}
	.bigImageBox { position: relative; }
	#buttons { text-align: center; position: absolute; margin-top: 15%; left: 50%; transform: translate( -50%, -50% ); z-index: 100; transition: all ease 0.2s 0s; }
	
	.photo_gallery .photo_list { width: 100%; height: 100px; position: relative; overflow: hidden; float: left; }
	.photo_gallery .photo_list .list_wrap ul { width: 100%; position: relative; list-style: none; padding: 0px; margin: 0px; text-align: center;}
	.photo_gallery .photo_list .list_wrap ul li { width: 25%; float: left; display: inline-block; overflow: hidden;}
	.photo_gallery .photo_list .list_wrap ul li a img { max-width: 150%; vertical-align: middle; margin: -2.5% 0% 0% -25%;}
	
	.grayscale{ filter: grayscale(90%); }

	
	//.photo_gallery button { position:absolute; bottom:59px; cursor:pointer }
	/*.photo_gallery button.btn_prev { top:10px; right:0px; text-indent:-9999px; overflow:hidden; display:block; width:260px; height:20px; margin:0px; border:0px; padding:0px; background:url('/open-iconic/svg/chevron-left.svg') no-repeat left top; }
	.photo_gallery button.btn_next { top:740px; right:0px; text-indent:-9999px; overflow:hidden; display:block; width:260px; height:20px; margin:0px; border:0px; padding:0px; background:url('/open-iconic/svg/chevron-right.svg') no-repeat left top; }
*/
</style>

<script type="text/javascript">
	$(function(){

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$("#addPhoto").click(function(){
			$("#file_img").click();
			return false;
		});
		
		var preview = function(e){
			if(window.FileReader){
				var file = e.target.files[0];
				var reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = function(e){
					$("#slideImg").attr("src", reader.result);
				}
			}
		}

		document.getElementById("file_img").addEventListener("change", preview, false);
		
		$("#buttons").hide();
		var isUpdate = false;

		//Slide Gallery 이미지 셀렉터
		$(".imgthumbs").click(function() {
			$(".imgthumbs").addClass("grayscale").removeClass("active");
			$(this).addClass("active").removeClass("grayscale");
			$(".imgthumbs").children("a").children("img").css("filter", "blur(2px)");
			$(this).children("a").children("img").css("filter", "none");
			$(".photo_img img").attr("src", $(this).children("a").attr("href")).attr("idx", $(this).attr("id"));
			return false;
		});

		//섬네일 hover
		$(".imgthumbs").hover(function(){
			$(".imgthumbs").children("a").children("img").css("filter", "blur(2px)");
			$(".active").children("a").children("img").css("filter", "none");
			$(this).children("a").children("img").css("filter", "none");
		});
		
		$(".imgthumbs").first().click();
		
		$(".bigImageBox").hover(function(){
			$("#buttons").show();
		}, function(){
			$("#buttons").hide();
		});

		$("#buttons").hover(function(){
			$(".photo_img").addClass("darkness_img");
		}, function(){
			$(".photo_img").removeClass("darkness_img");
		});
		
		/*Slide Gallery 슬라이딩 초기화
		$(".list_wrap").width("260"*parseInt($(".list_wrap ul").size())+"px");
		$(".list_wrap ul:last").prependTo(".list_wrap");
		
		//Silde Gallery의 prev버튼
		$(".btn_prev").click(function() {
			$(".list_wrap").animate({
				marginLeft:"+=700px"
				},"swing",function() {
				$(".list_wrap ul li:last").prependTo(".list_wrap ul");
				//$(".list_wrap").css("margin-left","-700px");
				//$(".list_wrap ul li").removeClass();
			});
		});
		
		//Silde Gallery의 next버튼
		$(".btn_next").click(function() {
			$(".list_wrap").animate({
				marginLeft:"-=700px"
				},"swing",function() {
				$(".list_wrap ul li:first").appendTo(".list_wrap ul");
				//$(".list_wrap").css("margin-left","-700px");
				//$(".list_wrap ul li").removeClass();
			});
		});
		*/

		

		$("#sliderImageModal").on('hidden.bs.modal', function(e){
			self.location = "/admin/main/slider";
			e.stopImmediatePropagation(); 
		});

		//삭제
		$("#deleteBtn").on("click", function(){
			var idx = $(".photo_img img").attr("idx");
			var re = confirm("슬라이드 이미지를 삭제하시겠습니까?");
			if(re){
				$.ajax("/admin/main/deleteSlide", {data: {s_no: idx}, success: function(msg){
					alert(msg);
					self.location = "/admin/main/slider";
				}});
			}
		});

		$("#updateBtn").on("click", function(){
			isUpdate = true;
			$("#sliderImageModal").modal('show');
		});
		$("#addicon").on("click", function(){
			isUpdate = false;
			$("#sliderImageModal").modal('show');
		});

		var slide;

		$('#sliderImageModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget);
			var idx = $(".photo_img img").attr("idx");
			console.log(idx);
			var modal = $(this);

			if(isUpdate){
				
				$.ajax("/admin/main/getImageInfo", {data: {s_no: idx}, success: function(s){
					console.log(s);
					var s = JSON.parse(s);
					slide = s;
					$("#slideImg").attr("src", "/img/"+s.s_img);
					$("#s_title").val(s.s_title);
					$("#s_text").val(s.s_text);
				}});

				$("#myModalLabel").html("슬라이드 이미지 수정");
				$("#addPhoto").html("사진 수정");
				$("#modalPrimaryBtn").html("수정");
				
			}

		});

		//modal 내에서 [등록] 버튼을 클릭
		$("#modalPrimaryBtn").click(function(e){
			e.preventDefault();
			
			var s_img = $("#slideImg").attr("src");
			var s_title = $("#s_title").val();
			var s_text = $("#s_text").val();

			//console.log(optionAfile);
			//console.log(typeof($("input[name='file_img']")[0].files[0]));

			var form = new FormData();
			
			if(slide != null){
				form.append("s_no", slide.s_no);
			}else{	
				form.append("s_no", -1);
			}
			
			form.append("s_text", s_text);
			form.append("s_title", s_title);

			if($("input[name='file_img']")[0].files[0]){
				form.append("file_img", $("input[name='file_img']")[0].files[0]);
			}
			
			console.log(form);

			if(s_img != null && s_img != '' ){
				
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
			            url: "/admin/main/insertSlide",
						data: form, 
						success: function(msg){
							alert(msg);
							$("#sliderImageModal").modal("hide");
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
			            url: "/admin/main/updateSlide",
						data: form, 
						success: function(msg){
							alert(msg);
							$("#sliderImageModal").modal("hide");
						}
					});
				}
			}else{
				alert("입력이 바르지 않습니다.");
			}
		});

	});
</script>

<div class="col mt-4">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-dark">메인 이미지 관리</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			
			<div class="photo_gallery">
				<div class="bigImageBox">
					<p class="photo_img">
						<img src="">
					</p>
					<div id="buttons">
						<button id="updateBtn" class="btn btn-secondary" data-toggle="modal" data-target="#sliderImageModal">수정</button>
						<button id="deleteBtn" class="btn btn-secondary">삭제</button>
					</div>
				</div>
				
				<div class="photo_list">
					<div class="list_wrap">
						<ul>
							<% int a = 0; %>
							<c:forEach var="s" items="${ imgList }">
								<li class="imgthumbs" id="${ s.s_no }"><a href="/img/${ s.s_img }"><img src="/img/${ s.s_img }"></a></li>
								<% a += 1; %>
							</c:forEach>
							<c:if test="<%= a < 4 %>">
								<li id="addicon"><a href="javascript:void(0);"><img src="/img/add.png"></a></li>
							</c:if>
						</ul>
						<!-- 
						<a class="carousel-control-prev btn_prev" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next btn_next" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
						-->
					</div>
				</div>
			</div>

			<!-- modal -->
			<div class="modal fade" id="sliderImageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<!-- <form id="form" name="form" method="POST" enctype="multipart/form-data">-->
					<div class="modal-content">
						<div class="modalheader" style="padding: 20px;">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h5 class="modal-title" id="myModalLabel" align="center">슬라이드 이미지 등록</h5>
						</div>
						
						<div class="modal-body" style="padding: 20px 50px 0px 50px;">
							<div id="slideImgBox" align="center" style="margin:0 auto;">
								<div style="height: 200px; border: 8px solid #F0F0F0; border-radius: 20px; overflow: hidden;">
									<img id='slideImg' class="mb-3" style='width: 100%;'/>
								</div>
								<br>
								<div>
									<input type="text" id="s_title" name="s_title" class="form-control mb-3">
									<input type="text" id="s_text" name="s_text" class="form-control mb-3">
								</div>
								<div class="addPhotoBtn">
									<button type="button" id="addPhoto" class="addPhoto btn btn-outline-dark">사진 등록</button><br>
									<input type="file" name="file_img" id="file_img" style="visibility: hidden;">
								</div>
							</div>
						</div>
						<div class="modal-footer" style="background: #5a5c69; border: 2px solid #5a5c69;">
							<button type="button" id="modalPrimaryBtn" class="btn btn-light">등록</button>				
						</div>
					</div>
				</div>
			</div><!-- end of modal -->
			
		</div><!-- end of card-body -->
		
	</div>
</div>

<%@include file="../footer.jsp"%>