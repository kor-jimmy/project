<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>


<style>
	li{
		list-style: none !important;
	}
	a{
		text-decoration: none !important;
		color: dimgray;
	}
	
	#goodsDiv{
		display: flex;
		border-radius: 20px;
		background: rgba(255, 255, 255, 0.7);
	}
	#goodsList{
		width: 100%;
		padding-left: 5%;
	}
	.goodsBox{
		text-overflow: ellipsis;
		white-space: nowrap;
		word-wrap:normal;
		overflow: hidden;
		float: left;
		margin: 5px 20px 30px 20px;
		width: 200px;
		color: dimgray;
	}
	.goodsImg{
		width: 200px;
		height: 200px;
		border: 1px solid lightgray;
	}
	
	.typeBtn{ background: white; border: 1px solid gray; color: gray; border-radius: 10px; }
	.typeBtn:hover{ border: 1px solid #A3A1FC; background: white; color: gray; border-radius: 10px; }
	.typeBtnActive{ background: #A3A1FC; border: 1px solid #A3A1FC; color: white; }
	
	.dist{ background: white; border: 1px solid gray; color: gray; border-radius: 10px; }
	.dist:hover{ border: 1px solid #A3F0E4; background: white; color: gray; border-radius: 10px; }
	.distActive{ background: #A3F0E4; border: 1px solid #A3F0E4; color: white; }
		
	#insertBtn{ background: #A3A1FC; border: 1px solid #A3A1FC; color: white; border-radius: 10px; }
	#insertBtn:hover{ background: #CBCAFF; border: 1px solid #CBCAFF; }
	
	#searchBtn{ background: #A3A1FC; border: 1px solid #A3A1FC; color: white; border-radius: 10px; }
	#searchBtn:hover{ background: #CBCAFF; border: 1px solid #CBCAFF; }
	#allBoardBtn{ background: #A3F0E4; border: 1px solid #A3F0E4; color: white; border-radius: 10px; }
	#allBoardBtn:hover{ background: #5FEAC9; border: 1px solid #5FEAC9; }
	
	.paging-btn{ background: white; border: 2px solid #e9ecef; border-radius: 50%; padding: 2px 10px 2px 10px;}
	.paging-btn:hover{ background: white; border: 2px solid #A3A1FC;}
	.btn-outline-secondary:not(:disabled):not(.disabled).active{ background: #5FEAC9; color: white;border: 2px solid #5FEAC9;}
	.btn-outline-secondary:not(:disabled):not(.disabled).active a{ color: white; }
</style>
<script type="text/javascript">

var c_no;
var keyword;
var gc_code=0;
var searchKeyword;
var searchField;

var dto;

function listGoods(gc_code,keyword,pageNum,searchField,searchKeyword){
	//	c_no를 강제로 넣어주기 위해 카테고리 설정시에만 글쓰기 버튼 보이게 / 검색을 위해 searchKeyword 추가
	if(keyword == null){
		$("#insertBtn").css("visibility","hidden");
	}
	else{
		$("#insertBtn").css("visibility","visible");
	}
	
	
	$("#goodsList").empty();
	
	$.ajax("/goods/listGoods",{data:{gc_code:gc_code,keyword:keyword,pageNum:pageNum,searchField:searchField,searchKeyword:searchKeyword}, success:function(result){
	//리스트 가져오기
		var list = JSON.parse(result.list)
		$.each(list, function(idx,item){
			var g = item;
			
			var div = $("<div class='goodsBox mb-5'></div>");
			
			var con = g.g_content;
			var img;
			
			if(con.indexOf("<img src=") != -1){
				img = $(con.substring(con.indexOf("<img src="), con.indexOf("style"))+"></img>").addClass("rounded goodsImg mb-3");
			}else{
				img = $("<img src='/img/no_image.png' class='rounded goodsImg mb-3'></img>");
			}
		
			var gc_dist = $("<small class='text-muted'></small>");
			if(g.gc_code == 1)
				gc_dist.html("[팝니다] ");
			else
				gc_dist.html("[삽니다] ");
			
			var title = $("<b></b>").html(g.g_title);
			var writer = $("<p></p>").html(g.m_nick);
			var g_date = moment(item.g_date).format('YYYY-MM-DD');
			var date = $("<span></span>").html(g_date);
			//var replyCnt = $("<span class='badge badge-light'></span>").html(g.g_replycnt);
			
			var a = $("<a></a>").attr("href","/goods/get?g_no="+g.g_no).append(title);
			var li = $("<li></li>").append(img, "<br>", gc_dist, a, "&nbsp;", writer, date);
			div.append(li);
			$("#goodsList").append(div);
			
			
			/*
			//상품번호,제목,코드,가격,날짜
			var td1=$("<td align='center'></td>").html(item.g_no);
			var td2=$("<td align='center'></td>").html(gc_dist);
			//var a=$("<a>"+item.g_title+"["+item.g_replycnt+"]"+"</a>").attr("href","/goods/get?g_no="+item.g_no)
			var a=$("<a>"+item.g_title+"</a>").attr("href","/goods/get?g_no="+item.g_no)
			var replyCnt=$("<span class='badge badge-light'></span>").html(item.g_replycnt)
			a.append(replyCnt);
			var td3=$("<td></td>").html(a);
			//console.log("닉:"+item.m_nick)
			var td4=$("<td align='center'></td>").html(item.m_nick);
			var td5=$("<td align='center'></td>").html(item.g_price);
			
			
			
			var td6=$("<td align='center'></td>").html(g_date);
			var tr = $("<tr></tr>").append(img, td1,td2,td3,td4,td5,td6);
			$("#tb").append(tr);
			*/
		});
	
		//페이징
		dto=result.dto;
		$(".pagination").empty();
		if(dto.prev){
			var a=$("<a>이전</a>").attr("href","#");
			var li = $("<li class='paging-btn btn btn-outline-light previous'></li>").append(a);
			$(a).on("click",function(){
				listGoods(gc_code,keyword,(dto.startPage)-1, searchField, searchKeyword);
			})
			var nbsp=$("<li>&nbsp;/&nbsp;</li>");
			$(".pagination").append(li,nbsp);
		}
		for(i=dto.startPage; i<=dto.endPage; i++){
			var a=$("<a class='pageNum'>"+i+"</a>").attr("href","#");
			var li=$("<li class='paging-btn btn btn-outline-light'></li>").append(a);
			$(a).on("click",function(){
				listGoods(gc_code,keyword,$(this).html(), searchField, searchKeyword);
			})
			var nbsp=$("<li>&nbsp;</li>");
			$(".pagination").append(li,nbsp);
		}
		if(dto.next){
			var a=$("<a>다음</a>").attr("href","#");
			var li = $("<li class='paging-btn btn btn-outline-light next'></li>").append(a);
			$(a).on("click",function(){
				listGoods(gc_code,keyword,(dto.endPage)+1, searchField, searchKeyword);
			})
			$(".pagination").append(li);
		}
	}})
}

$(function(){

   var member = $("#member").val();

   $.ajax("/category/goodsCateList",{success:function(result){
//      console.log(result)
      var b=$("<button id='tot' class='btn btn-outline-light mr-2 dist distActive'></button>").html('전체보기');
      $(b).on("click",function(){
    	  $(".dist").removeClass("distActive");
    	  $(this).addClass("distActive");
    	  var nokey;	//keyword에 null을 넣어주기 위한 변수 (null로 대입하면 적용안됨)
    	  keyword=nokey;
    	  listGoods(gc_code,keyword,1,searchField,searchKeyword);
      })
      $("#goodsType").append(b);
      result=JSON.parse(result);
      $.each(result,function(idx,item){
         var c_dist= $("<button type='button' class='btn btn-outline-light dist'></button>").html(result[idx].c_dist);
         var nbsp="  ";
         $("#goodsType").append(c_dist,nbsp);
         $(c_dist).on("click",function(){
            $(".dist").removeClass("distActive");
            keyword=$(this).text();
            c_no=result[idx].c_no;
            $(this).addClass("distActive");
            listGoods(gc_code,keyword,1,searchField,searchKeyword);
         })
      })
      
   }})
   $("#insertBtn").on("click",function(){
//      console.log(c_no);
      self.location = "/goods/insert?c_no="+c_no+"&gc_code="+gc_code;
   })
   $(".typeBtn").on("click",function(){
	   $(".typeBtn").removeClass("typeBtnActive");
		var noCode;
	   $(this).addClass("typeBtnActive");
		if($(this).val()==0)
			gc_code= noCode;
		else
			gc_code = $(this).val();
		console.log(gc_code,keyword,searchKeyword,searchField);
		listGoods(gc_code,keyword,1,searchField,searchKeyword);
	})
	//검색처리
	$("#searchBtn").on("click", function(e){
		e.preventDefault();
		searchKeyword = $("#searchKeyword").val();
		searchField = $("#searchField").val();
		console.log(searchKeyword, searchField);
		
		listGoods(gc_code,keyword,1,searchField,searchKeyword);
	});

   $("#allBoardBtn").on("click", function(e){
		e.preventDefault();
		self.location = "/goods/list";
	});

   if(typeof member == "undefined" || member == 'null' || member == ""){
	   listGoods(0);
	}else{
		
		$("#goodsList").empty();
		$("#searchKeyword").val(member);
		$("#searchField").val("m_id");
		//listGoods(0,"",1,"m_id",member);
		$("#searchBtn").click();
		
	}

	
})
</script>
	<input type="hidden" id="member" value=<%= request.getParameter("member") %>>
	
	<h2>상품목록</h2><div id=state></div>
	<p>상품 등록을 원하시면 카테고리를 선택해주세요.</p>
	<hr>
	
	<button id="allBtn" type="button" class="btn btn-outline-light typeBtn typeBtnActive" value="0">전체보기</button>
	<button id="buyBtn" type="button" class="btn btn-outline-light typeBtn" value="2">삽니다</button>
	<button id="sellBtn" type="button" class="btn btn-outline-light typeBtn" value="1">팝니다</button>
	<br><br>
	
	<div>
		<div id="goodsType" style="display: inline-block;">
			<h4>상품 종류별 보기</h4>
		</div>
		<div style="display: inline-block; float: right;">
			<button id="insertBtn" type="button" class="btn btn-outline-light">상품등록</button>
		</div>
	</div>
	<hr>
	<div id="goodsDiv" align="center">
		<ul id="goodsList" class="mt-5">

		</ul>
	</div>
	<!--  
	<table class="table table-hover">
	   <thead>
	      <tr align="center">
	         <td width="10%">상품번호</td>
	         <td width="10%">구분</td>
	         <td width="50%">제목</td>
	         <td width="10%">작성자</td>
	         <td width="10%">가격</td>
	         <td width="10%">날짜</td>
	      </tr>
	   </thead>
	   <tbody id="tb">
	      
	   </tbody>
	</table>
	-->
	<hr>
	<!-- 게시물 검색 -->
	<form id="searchForm" method="get">
	    <div class="form-row align-items-center">
	    	    <input type="hidden" id="categoryNum" name="categoryNum" value="${ c_no }">
	    	    <input type="hidden" name="c_no" id="c_no" value="${c_no}">
		    	<input type="hidden" name="pageNum" id="pageNum" value="${pageMake.cri.pageNum}">
		    	<input type="hidden" name="amount" id="amount" value="${pageMake.cri.amount}">
	    	    <div class="col-sm-2 my-1">
	    	    	<select id="searchField" class="custom-select mr-sm-2" name="searchField">
			    		<!-- <option value="all" class="sf">전체보기</option>-->
						<option value="g_title" class="sf">제목</option>
						<option value="g_content" class="sf">내용</option>
						<option value="m_id" class="sf">작성자</option>
						<option value="doc" class="sf">제목+내용</option>
			    	</select>
	    	    </div>
				<div class="col-sm-6 my-1">
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${ pageMake.cri.keyword }">
				</div>
		    	
				<div class="col-sm-2 my-1">
					<button id="searchBtn" class="btn btn-outline-light">검색</button>
				</div>
		    	
		    	<div class="col-sm-2 my-1">
		    		<button id="allBoardBtn" class="btn btn-outline-light float-right">전체글</button>
		    	</div>
	    </div>
    </form>
    
    <!-- 
	<select id="searchField">
		<option value="all" class="sf">전체보기</option>
		<option value="g_title" class="sf">제목</option>
		<option value="g_content" class="sf">내용</option>
		<option value="m_id" class="sf">작성자</option>
		<option value="doc" class="sf">제목+내용</option>
	</select>
	<input type="text" id="searchKeyword" name="searchKeyword">
	<button id="searchBtn" class="btn btn_outline-dark">검색</button>
	-->
	<hr>
	 <!-- 페이징 -->
	<div class="float-right">
		<ul class="pagination">
			
		</ul>
	</div>
	<!-- paging end -->
	
<%@include file="../includes/footer.jsp"%>