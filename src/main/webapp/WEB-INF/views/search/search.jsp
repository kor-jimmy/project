<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/inko@1.1.1/inko.min.js"></script>
<style>
	li{
		list-style: none;
	}
	a{
		text-decoration: none !important;
	}
	#containerBox{
		padding: 20px 10px 20px 10px;
	}
	#modifiedKeyword{
		color: #8882F8;
	}

	#newsBox{
		border: 1px solid lightgray;
		border-radius: 20px;
		padding: 30px;
		width: 50%;
		height: 500px;
		box-shadow: 0px 0px 10px #F3F3F3;
	}
	#tab-contentBox{
		height: 350px;
		overflow: auto;
	}
	
	#tab-contentBox::-webkit-scrollbar{
		height: 320px;
	}
	#tab-contentBox::-webkit-scrollbar-thumb{
		background: #86F3D9;
		border-radius: 20px;
	}
	#tab-contentBox::-webkit-scrollbar-track{
		background: #F3F3F3;
	}
	#myTabContent{
		overflow: hidden;
		margin: 10px;
		color: gray;
	}
	.thumb_img{
		display: inline-block;
	}
	#nullnews{
		text-align: center;
		padding-top: 25%;
		color: lightgray;
	}
	
	.category{
		padding: 10px 20px 10px 20px;
		margin: 10px;
		border: 2px solid #5FEAC9;
		border-radius: 50px;
		background: white;
		text-align: center;
		background: white;
		color: gray;
		display: inline-block;
	}
	.category:hover{
		box-shadow: 0px 0px 10px #ECECEC;
		cursor: pointer;
		background: linear-gradient(15deg, #a3a1fc, #5FEAC9);
		color: white;
		font-weight: bold;
	}
	.badge-info{
		background: #86F3D9;
	}
	.boardTitle{
		color: #8882F8;
	}
	.boardTitle:hover{
		color: #8882F8;
		opacity: 0.8;
	}
	.goodsTitle{
		color: #8882F8;
	}
	.goodsTitle:hover{
		color: #8882F8;
		opacity: 0.8;
	}
	#goodsList{
		width: 100%;
	}
	#goodsList li{
		display: inline-block;
		width: 25%;
		margin-right: 20px;
	}
	.goodsImg{
		width: 200px;
		height: 200px;
		border: 1px solid lightgray;
	}
	
	#vLiveBox a{
		color: #8882F8;
	}
	
	#vLiveBox{
		border: 1px solid lightgray;
		border-radius: 20px;
		background: white;
		width: 40%;
		height: 500px;
		box-shadow: 0px 0px 10px #F3F3F3;
		float: right;
		padding: 30px;
		margin-right: 40px;
	}
	#vLiveList{
		height: 400px;
		overflow: auto;
	}
	.video_list{
		padding: 20px;
	}
	
	#vLiveList::-webkit-scrollbar{
		height: 400px;
	}
	#vLiveList::-webkit-scrollbar-thumb{
		background: #86F3D9;
		border-radius: 20px;
	}
	#vLiveList::-webkit-scrollbar-track{
		background: #F3F3F3;
	}
	.video_list_cont{
		width: 300px;
	}
	.video_list_cont img{
		width: 300px;
	}
	#vLives{
		overflow: hidden;
	}
</style>
<script type="text/javascript">
$(function(){

	var inko = new Inko();
	
	var keyword = $("#keyword").val();
	
	$("#mainSearch").val(keyword);
	$("#categoryBox").hide();
	$("#boardBox").hide();
	$("#goodsBox").hide();
	$("#modified").hide();

	if( keyword == "" || keyword == null ){
		var text = "검색어가 올바르지 않습니다.";
		$("#containerBox").html(text);
	}
	if(/^[a-zA-Z]+$/.test(keyword)){
		var transKeyword = inko.en2ko(keyword);
		if(/[가-힣]+$/.test(transKeyword)){
			$("#modified").show();
			$("#modifiedKeyword").html(transKeyword);
			$("#linkForKeyword").attr("href", "/search/search?keyword="+transKeyword);
		}
	}

	//네이버
	$("#news_naver").click(function(){
		$("#news_daum").css("color", "lightgray");
		$(this).css({"color": "#8882F8", "font-weight": "bold"});
		$.ajax("/search/newsNaver", {data: {keyword: keyword}, success: function(str){
			//console.log(str);
			var news = $(str);
			$(".tab-content").html(news);

			$(".thumb").next().append("<hr>");
			$(".relation_lst").remove();
			$(".newr_more").remove();
			$(".txt_inline a").remove();
			//$(".txt_inline").next().remove();
			$(".tab-content a").css("color", "#ABAAF6");
			if($(".tab-content").html()==""){
				$(".tab-content").html("<div id='nullnews'><span>해당 검색어의 뉴스결과가 없습니다.</span></div>");
			}
		}});
	});
	//다음
	$("#news_daum").click(function(){
		$("#news_naver").css("color", "lightgray");
		$(this).css({"color": "#8882F8", "font-weight": "bold"});
		$.ajax("/search/newsDaum", {data: {keyword: keyword}, success: function(str){
			//console.log(str);
			var news = $(str);
			$(".tab-content").html(news);

			var div = $("<div></div>").append($("#clusterResultUL").children());
			$(".tab-content").html(div);
			$(".wrap_cont").append("<hr>");
			
			//$(".desc").remove();
			$(".related_news").remove();
			$(".f_link_b").html("<b>"+$(".f_link_b").html()+"</b>");
			$(".tab-content a").css("color", "#ABAAF6");
			if($(".tab-content div").html()==""){
				$(".tab-content div").html("<div id='nullnews'><span>해당 검색어의 뉴스결과가 없습니다.</span></div>");
			}
				
		}});
	});

	$("#news_naver").click();

	//V Live
	$.ajax("/search/getVLive", {data: {keyword: keyword}, success: function(data){
		//console.log(data);
		if( data.trim() == ""){
			$("#vLiveBox").hide();
			return false;
		}
		$("#vLives").html(data);
		$(".icon_box").remove();
		$(".video_info").remove();
		$(".video_tit").css({"display": "block", "font-weight": "bold"});
		$(".video_date").attr("class", "mb-3");
		//$(".video_list_cont").attr("class", "mb-3");

		var list = $("#vLiveList li");
		$.each(list, function(idx, li){
			console.log(li);
			
			//a 태그 주소 수정
			var href = $(this).children("a").attr("href");
			$(this).children("a").attr("href", "https://www.vlive.tv"+href);
			var uploadName = $(this).children(".video_date").children("a").attr("href");
			$(this).children(".video_date").children("a").attr("href", "https://www.vlive.tv"+uploadName);
			console.log(li);
			
		});
		
		
	}});

	//카테고리
	$.ajax("/search/getCategory", {data: {keyword: keyword}, success: function(data){
		if( data.length > 0 ){ //이 키워드가 포함된 카테고리가 존재한다면
			$("#categoryBox").show();
			$.each(data, function(idx, c){
				var a = $("<a></a>").attr("href", "../board/list?categoryNum="+c.c_no);
				var category = $("<div class='category'></div>").html(c.c_dist);
				a.append(category);
				$("#categoryBox").append(a);
			});
		}else{
			$("#categoryBox").hide();
		}
	}});

	//게시물
	$.ajax("/search/getBoard", {data: {keyword: keyword}, success: function(data){
		if( data.length > 0 ){ 
			$("#boardBox").show();
			$.each(data, function(idx, b){
				if( idx > 4 ){
					return false;
				}
				var li = $("<li></li>");
				var category = $("<span class='badge badge-info'></span>").html(b.c_dist);
				var a = $("<a class='boardTitle'></a>").attr("href", "../board/get?b_no="+b.b_no);
				var title = $("<b></b>").html(b.b_title);
				console.log(b.b_updatedate);
				var boardDate = $("<p></p>").html(b.b_updatedate).css("color", "lightgray");
				a.append(title);
				li.append(category, "&nbsp;", a, boardDate);
				$("#boardList").append(li);
				
			});
		}else{
			$("#boardBox").hide();
		}
	}});

	//굿즈 (팝니다만 나옴)
	$.ajax("/search/getGoods", {data: {keyword: keyword}, success: function(data){
		if( data.length > 0 ){ 
			$("#goodsBox").show();
			$.each(data, function(idx, g){
				if( idx > 4 ){
					return false;
				}
				console.log(g);
				var db_con = g.g_content;
				var div_img = $("<div></div>");
				var img;
				if(db_con.indexOf("<img src=") != -1){
					img = $(db_con.substring(db_con.indexOf("<img src="), db_con.indexOf("style"))+"></img>").addClass("goodsImg");
				}else{
					img = $("<img src='/img/no_image.png' class='goodsImg'></img>");
				}
				console.log("img: " + img);
				div_img.append(img);
				var li = $("<li></li>").addClass("mb-3");
				var category = $("<span class='badge badge-info'></span>").html(g.c_dist);
				var a = $("<a class='goodsTitle'></a>").attr("href", "../goods/get?g_no="+g.g_no);
				var title = $("<b></b>").html(g.g_title);
				var goodsDate = $("<p></p>").html(g.g_updatedate).css("color", "lightgray");
				a.append(title);
				li.append(div_img, "<br>", category, "&nbsp;", a, goodsDate);
				$("#goodsList").append(li);
				
			});
		}else{
			$("#goodsBox").hide();
		}
	}});
	
});
</script>

<input type="hidden" id="keyword" value="${ keyword }">
<div id="containerBox">
	
	<p id="modified"><b>검색어 제안</b> <a id="linkForKeyword"><span id="modifiedKeyword"></span></a>(으)로 검색하시겠습니까?</p><br>
	
	<div id="peopleInfo">
	
	</div>
	
	
	<div id="categoryBox" class="mb-5">
		<h3>카테고리</h3>
		<br>
	</div>
	
	<div>
	<div id="vLiveBox">
		<h4 align="right">V Live</h4>
		<hr class="mb-0">
		<div id="vLiveList">
			<div id="vLives">
			
			</div>
		</div>
	</div>
	
	<div id="newsBox" class="mb-5">
		<h3>뉴스</h3>
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
			  <a class="nav-link active" id="news_naver" data-toggle="tab" href="#naver" role="tab" aria-controls="naver" aria-selected="true">NAVER</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link" id="news_daum" data-toggle="tab" href="#daum" role="tab" aria-controls="daum" aria-selected="false">DAUM</a>
			</li>
			
		</ul>
		<div id="tab-contentBox">
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="naver" role="tabpanel" aria-labelledby="naver-tab"></div>
			<div class="tab-pane fade" id="daum" role="tabpanel" aria-labelledby="daum-tab"></div>
		</div>
		</div>
	</div>
	</div>
	
	
	<div id="boardBox" class="mb-5">
		<h3>게시물 검색 결과</h3>
		<ul id="boardList" class="mt-5">
		
		</ul>
	</div>
	
	<div id="goodsBox" class="mb-5">
		<h3>굿즈 검색 결과</h3>
		<ul id="goodsList" class="mt-5">
			
		</ul>
	</div>
	
</div>

<%@include file="../includes/footer.jsp"%>  