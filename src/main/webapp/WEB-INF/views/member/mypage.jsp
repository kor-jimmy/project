<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>

<style>
	.userInfo{
		text-align: center;
	}
</style>
<script type="text/javascript">

	$(function(){

		//진탁 06/02
		//시큐리티 태그립. 현재 로그인한 유저의 아이디를 user_id 전역 변수에 담음 여러 함수에 쓰일 예정
		var user_id = "<sec:authentication property='principal.username'/>";
		var data = {m_id:user_id}
		console.log(user_id);
		//유저의 정보를 요청하는 ajax
		$.ajax({
			url:"/member/getMemberInfo",
			type:"GET",
			data:data,
			success:function(result){
				var member = JSON.parse(result);
				$("#userID").html(member.m_id);
				$("#userNICK").html(member.m_nick);
				$("#userEMAIL").html(member.m_email);
				$("#userLOVE").html(member.m_lovecnt);
				$("#userHATE").html(member.m_hatecnt);
			}
		})	

		$("#updateMember").on("click", function(){
			$("#confirmModal").modal('show');
		});

		$("#confirmBtn").on("click", function(e){
			e.preventDefault();
			$.ajax("/member/isCorrectPwd", {data: {m_id:user_id, m_pwd: $("#m_pwd").val()}, success: function(re){
				if( re == 0 ){
					swal({
						  text: "비밀번호가 일치하지 않습니다!",
						  icon: "warning",
						  button: "확인"
						});
				}else{
					location.href="/member/get";
				}
			}});
			
		});


		//진탁 06/02
		//해당 유저의 최신 게시물 8개를 가져오는 함수.
		var getMyBoard = function(){			
			$.ajax({
				url:"/member/getMypageBoard",
				data:data,
				type:"GET",
				success:function(result){
					var boardList = JSON.parse(result);
					$.each(boardList,function(idx,board){
						var date = moment(board.b_date).format("YYYY-MM-DD");
						var tr = $("<tr align='center'></tr>");
						var category = $("<td></td>").html(board.c_dist);
						var link = $("<a target='_blank'></a>").attr("href","/board/get?b_no="+board.b_no).html(board.b_title);
						var title = $("<td></td>").append(link);
						var boardDate = $("<td></td>").html(date);
						tr.append(category,title,boardDate);
						$("#userContent").append(tr);
					})
					var totalLink = $("<a target='_blank' class='badge badge-info float-right'></a>").html("전체 게시글 보기").attr("href","/board/listAll?categoryNum=9999&c_no=9999&pageNum=1&amount=30&searchField=m_id&keyword="+user_id);
					$("#linkDiv").append(totalLink);	
				}
			})
		}

		//진탁 06/02
		//해당 유저의 최신 굿즈 8개를 가져오는 함수.
		var getMyGoods = function(){			
			$.ajax({
				url:"/member/getMypageGoods",
				data:data,
				type:"GET",
				success:function(result){
					var goodsList = JSON.parse(result);
					$.each(goodsList,function(idx,goods){
						var date = moment(goods.g_date).format("YYYY-MM-DD");
						var tr = $("<tr align='center'></tr>");
						var category = $("<td></td>").html(goods.c_dist);
						var link = $("<a target='_blank'></a>").attr("href","/goods/get?g_no="+goods.g_no).html(goods.g_title);
						var title = $("<td></td>").append(link);
						var boardDate = $("<td></td>").html(date);
						tr.append(category,title,boardDate);
						$("#userContent").append(tr);
					})
					var totalLink = $("<a class='badge badge-info float-right'></a>").html("전체 굿즈글 보기").attr("href","/member/goods?m_id=?"+user_id);
					$("#linkDiv").append(totalLink);		
				}
			})
		}
		getMyBoard();

		$(document).on("click","#myBoard",function(){
			$("#userContent").empty();
			$("#linkDiv").empty();
			getMyBoard();
		})
		$(document).on("click","#myGoods",function(){
			$("#userContent").empty();
			$("#linkDiv").empty();
			getMyGoods();
		})
		
	})
</script>
 	<div class="row">
	    <div class="col-lg-4">
	      <div class="card shadow mb-4">
	        <!-- Card Body -->
	        <div class="card-body">
	        	<div id="userBox">
	        		<div>
	        			<div align="center">
	        				<img src="/img/userICON.png" width="80" height="80" class="rounded-circle">
<%-- 	        			<c:if test="${member.m_img == null }">
	        					
	        				</c:if>
	        				<c:if test="${member.m_img !=null }">
	        					<img src="/upload/profile/${member.m_img }">
	        				</c:if> --%>
	        			</div>
	        			<div>
		        			<ul class="list-group list-group-flush">
		        				<li class="list-group-item" >
		        					<h6><span class="badge badge-secondary">회원ID</span></h6>
		        					<div class="userInfo" id="userID"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-secondary">닉네임</span></h6>
		        					<div class="userInfo" id="userNICK"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-secondary">메일주소</span></h6>
		        					<div class="userInfo" id="userEMAIL"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-danger">누적 좋아요</span></h6>
		        					<div class="userInfo" id="userLOVE"></div>
		        				</li>
		        				<li class="list-group-item">
		        					<h6><span class="badge badge-danger">누적 싫어요</span></h6>
		        					<div class="userInfo" id="userHATE"></div>
		        				</li>
		        			</ul>
	        			</div>
	        		</div>
	        		<button id="updateMember" type="button" class="btn btn-light float-right">회원 정보 수정</button>
	        	</div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="col-lg-8">
	      <div class="card shadow mb-4">
	        <!-- Card Body -->
	        <div class="card-body" id="serachPickDiv">
	        	<div>
	        		<button type="button" class="btn btn-light float-right" id="myGoods">내가 올린 애호품</button>
	        		<button type="button" class="btn btn-light float-right" id="myBoard">내가 올린 애호글</button>
	        	</div>
	        	<div>
	        		<table class="table table-hover">
	        			<thead>
	        				<tr align="center">
	        					<th width="20%">카테고리</th>
	        					<th width="40%">제목</th>
	        					<th width="20%">날짜</th>	        					
	        				</tr>
	        			</thead>
	        			<tbody id="userContent">
	        			
	        			</tbody>
	        		</table>   	
	        	</div>
	        	<div id="linkDiv">
	        	
	        	</div>
	        </div>
	      </div>
	    </div>
	 </div>
	

	<!-- Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modalheader" style="padding: 20px;">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h5 class="modal-title" id="myModalLabel" align="center">비밀번호 확인</h5>
				</div>
				<form id="form" name="form">
					<div class="modal-body mb-3" style="padding: 20px 50px 0px 50px;">
						<div id="password" class="form-group">
						    <label for="m_pwd">비밀번호를 확인해주십시오.</label>
						    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						    <input type="password" class="form-control" id="m_pwd" name="m_pwd" required>
						</div>
					</div>
					<div class="modal-footer" style="background: #F4F4F4; border: 2px solid #F4F4F4;">
						<button id="confirmBtn" type="button" class="btn btn-dark" style="width: 300px; float:none; margin:0 auto;">확인</button>				
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	
<%@include file="../includes/footer.jsp"%>