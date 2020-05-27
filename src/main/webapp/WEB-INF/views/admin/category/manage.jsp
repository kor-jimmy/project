<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../header.jsp"%>
<style>
	li{
		list-style: none;
	}
	#categoryListBox{
		width: 50%;
		display: inline-block;
		float: left;
	}
	.categoryList-area{
		padding: 20px;
	}
	.categorysBySection{
		margin-left: -30px;
	}
	.cat{
		padding: 15px;
		margin: 10px;
		border: 1px solid slategray;
		border-radius: 30px;
		text-align: center;
		display: inline-block;
		cursor: pointer;
	}
	.cat:hover{
		box-shadow: 0px 0px 10px #E7EBEE;
	}
	.clickedCategory{
		background: slategray;
		color: white;
		font-weight: bold;
	}
	#categoryManageBox{
		width: 40%;
		display: inline-block;
		float: left;
		position: fixed;
	}
	.categoryManage-area{
		margin: 20px;
	}
	#buttons{
		float: right;
	}
</style>
<script type="text/javascript">
$(function(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$("#insertBtn").on("click", function(){

		if($("#c_dist").val() == null || $("#c_dist").val() == ""){
			alert("입력이 바르지 않습니다.");
			return false;
		}
		var section = $("#section").val();
		console.log(section);

		var cats = $("#"+section+" .cat");
		//console.log(cats.attr("id"));
		//console.log(cats.length);
		
		var c_no = eval(cats.attr("id"))+eval(cats.length);
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist};
		$.ajax("/category/insert", {
			type: 'POST', 
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token)	
			},
			cache: false, 
			data: data, 
			success: function(re){
				alert(re);
				location.href ="/admin/category/manage";
		}});
	});

	$(".cat").on("click", function(){

		var id = $(this).attr("id");
		var isclicked = $(this).attr("class");
		console.log(isclicked);

		if(isclicked.indexOf("clickedCategory") == -1){
			$("#section").hide();
			$("#insertBtn").hide();
			$(".cat").removeClass("clickedCategory");
			$(this).addClass("clickedCategory");
			

			$.ajax("/category/get", {data: {c_no: id}, success: function(cat){
				var cat = JSON.parse(cat);
				$("#c_no").val(cat.c_no);
				$("#c_dist").val(cat.c_dist);
			}});
		}else{
			$(this).removeClass("clickedCategory");
			$("#section").show();
			$("#insertBtn").show();
			$("#c_no").val("0");
			$("#c_dist").val("");
		}

		
	});

	$("#updateBtn").on("click", function(){
		var c_no = $("#c_no").val();
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist}
		$.ajax("/category/update", {
			type: 'POST', 
			data: data, 
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token)	
			},
			cache: false, 
			success: function(re){
				alert(re);
				location.href ="/admin/category/manage";
		}});
	});
	
	$("#deleteBtn").on("click", function(){
		var c_no = $("#c_no").val();
		var c_dist = $("#c_dist").val();
		var data = {c_no: c_no, c_dist: c_dist}
		var re = confirm("카테고리를 영구적으로 삭제하시겠습니까?");
		if (re) {
			$.ajax("/category/delete", {
				type: 'POST', 
				data: data, 
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache: false, 
				success: function(re){
					alert(re);
					location.href ="/admin/category/manage";
			}});
		}
	});
});
</script>

<div class="col mt-4">
<div class="col-m-8 col-lg-7" id="categoryListBox">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">카테고리 목록</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<div class="categoryList-area">
				<h4>방송</h4>
				<div class="categorysBySection" id="broadcast">
					<ul>
						<c:forEach var="cat" items="${ list }">
							<c:if test="${ cat.c_no > 0 && cat.c_no <= 100 }">
								<div class="cat" id="${ cat.c_no }">
									<li><div class="categories" id="${ cat.c_no }">
									<c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h4>연예</h4>
				<div class="categorysBySection" id="entertain">
					<ul>
						<c:forEach var="cat" items="${ list }">
							<c:if test="${ cat.c_no > 100 && cat.c_no <= 200 }">
								<div class="cat" id="${ cat.c_no }">
									<li><div class="categories" id="${ cat.c_no }"><c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</c:if>
						</c:forEach>ㄴ
					</ul>
				</div>
				<br>
				<h4>영화</h4>
				<div class="categorysBySection" id="movie">
					<ul>
						<c:forEach var="cat" items="${ list }">
							<c:if test="${ cat.c_no > 200 && cat.c_no <= 300 }">
								<div class="cat" id="${ cat.c_no }">
									<li><div class="categories"><c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h4>게임 / 취미</h4>
				<div class="categorysBySection" id="hobby">
					<ul>
						<c:forEach var="cat" items="${ list }">
							<c:if test="${ cat.c_no > 300 && cat.c_no <= 400 }">
								<div class="cat" id="${ cat.c_no }">
									<li><div class="categories" id="${ cat.c_no }"><c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h4>스포츠 / 기타</h4>
				<div class="categorysBySection" id="sports">
					<ul>
						<c:forEach var="cat" items="${ list }">
							<c:if test="${ cat.c_no > 400 && cat.c_no <= 500 }">
								<div class="cat" id="${ cat.c_no }">
									<li><div class="categories" ><c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-xl-8 col-lg-7" id="categoryManageBox">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">카테고리 정보</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<div class="categoryManage-area">
				<form>
					<div class="form-group">
						<select class="form-control" id="section">
							<option value="broadcast">방송</option>
							<option value="entertain">연예</option>
							<option value="movie">영화</option>	
							<option value="hobby">게임/취미</option>	
							<option value="sports">스포츠/기타</option>	
						</select>
					</div>
					<div class="form-group">
						<input type="hidden" id="c_no" name="c_no" class="form-control" value="0">
					</div>
					<div class="form-group">
						<label for="c_dist">카테고리명</label>
						<input type="text" id="c_dist" name="c_dist" class="form-control">
					</div>
				</form>
				<div id="buttons">
					<button class="btn btn-outline-secondary" id="insertBtn">등록</button>
					<button class="btn btn-outline-secondary" id="updateBtn">수정</button>
					<button class="btn btn-outline-secondary" id="deleteBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<%@include file="../footer.jsp"%>