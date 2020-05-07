<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
function listGoods(gc_code,keyword,pageNum){
//	c_no를 강제로 넣어주기 위해 카테고리 설정시에만 글쓰기 버튼 보이게
   if(keyword == null){
      $("#insertBtn").css("visibility","hidden");
   }
   else{
      $("#insertBtn").css("visibility","visible");
   }
   var dto;
   $("#tb").empty();
   $.ajax("/goods/listGoods",{data:{gc_code:gc_code,keyword:keyword,pageNum:pageNum}, success:function(result){
		//리스트 가져오기
		var list = JSON.parse(result.list)
	      $.each(list, function(idx,item){
          //상품번호,제목,코드,가격,날짜
         var td1=$("<td align='center'></td>").html(item.g_no);
         var a=$("<a>"+item.g_title+"["+item.g_replycnt+"]"+"</a>").attr("href","/goods/get?g_no="+item.g_no)
         var td2=$("<td></td>").html(a);
         var td3=$("<td align='center'></td>").html(item.gc_code);
         var td4=$("<td align='center'></td>").html(item.g_price);
         var td5=$("<td align='center'></td>").html(item.g_date);
         var tr = $("<tr></tr>").append(td1,td2,td3,td4,td5);
         $("#tb").append(tr);
      })

    //페이징
      dto=result.dto;
	  $(".pagination").empty();
	  if(dto.prev){
		  var a=$("<a>이전</a>").attr("href","#");
		  var li = $("<li></li>").append(a);
		  $(a).on("click",function(){
			  listGoods(gc_code,keyword,(dto.startPage)-1);
		  })
		  var nbsp=$("<li>&nbsp;/&nbsp;</li>");
		  $(".pagination").append(li,nbsp);
	  }
	  for(i=dto.startPage; i<=dto.endPage; i++){
		  var a=$("<a class='pageNum'>"+i+"</a>").attr("href","#");
		  var li=$("<li></li>").append(a);
		  $(a).on("click",function(){
				listGoods(gc_code,keyword,$(this).html());
			})
		  var nbsp=$("<li>&nbsp;/&nbsp;</li>");
		  $(".pagination").append(li,nbsp);
	  }
	  if(dto.next){
		  var a=$("<a>다음</a>").attr("href","#");
		  var li = $("<li></li>").append(a);
		  $(a).on("click",function(){
			  listGoods(gc_code,keyword,(dto.endPage)+1);
		  })
		  $(".pagination").append(li);
	  }
   }})
}
$(function(){
   var c_no;
   var keyword;
   listGoods(0)   
   var gc_code=0;
   $.ajax("/category/goodsCateList",{success:function(result){
//      console.log(result)
      var b=$("<button id='tot' class='btn btn-outline-dark dist'></button>").html('전체보기');
      $(b).on("click",function(){
    	  $(".dist").css("background","white");
    	  $(this).css("background","yellow");
         listGoods(gc_code);
      })
      $("#goodsType").append(b);
      result=JSON.parse(result);
      $.each(result,function(idx,item){
         var c_dist= $("<button id='listCate' type='button' class='btn btn-outline-dark dist'></button>").html(result[idx].c_dist);
         var nbsp="  ";
         $("#goodsType").append(c_dist,nbsp);
         $(c_dist).on("click",function(){
            $(".dist").css("background","white");
            keyword=$(this).text();
            c_no=result[idx].c_no;
            $(this).css("background","yellow");
            listGoods(gc_code,keyword);
         })
      })
      
   }})
   $("#insertBtn").on("click",function(){
//      console.log(c_no);
      self.location = "/goods/insert?c_no="+c_no;
   })
   $("#buyBtn").on("click",function(){
	   $(this).css("background","pink");
	   $("#sellBtn").css("background","white");
		gc_code=$(this).val();
//		console.log(gc_code);
		listGoods(gc_code);
	})
	$("#sellBtn").on("click",function(){
		$(this).css("background","pink");
		$("#buyBtn").css("background","white");
		gc_code=$(this).val();
//		console.log(gc_code);
		listGoods(gc_code);
	})
	$(".pageNum").on("click",function(){
		listGoods(gc_code,keyword,$(this).html());
	})

	//검색처리
	var searchForm = $("#searchForm");

	$("#searchBtn").on("click", function(e){
		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 입력해주세요.");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
		});

	$("allGoodsBtn").on("click", function(e){
		e.preventDefault();
		self.location = "/goods/list?categoryNum="+gc_code;
		});
})
</script>
	
   <h2>상품목록</h2><div id=state></div>
   <hr>
   <button id="buyBtn" type="button" class="btn btn-outline-dark" value="2">삽니다</button>
   <button id="sellBtn" type="button" class="btn btn-outline-dark" value="1">팝니다</button>
   <br><br>
   <div id="goodsType">
   <h4>상품 종류별 보기</h4>
   
   </div>
   <hr>
   <table class="table table-hover">
      <thead>
         <tr align="center">
            <td width="10%">상품번호</td>
            <td width="50%">제목</td>
            <td width="10%">코드</td>
            <td width="10%">가격</td>
            <td width="10%">날짜</td>
         </tr>
      </thead>
      <tbody id="tb">
         
      </tbody>
   </table>
   <hr>
   <!-- 게시물 검색 -->
   <form id="searchForm" action="/goods/list" method="get">
   <input type="hidden" id="categoryNum" name="categoryNum" value="${c_no }">
		<select name="searchField">
			<option value="all" <c:out value="${pageMake.cri.searchField eq 'all'?'selected':''}"/>>전체보기</option>
			<option value="g_title" <c:out value="${pageMake.cri.searchField eq 'g_title'?'selected':''}"/>>제목</option>
			<option value="g_content" <c:out value="${pageMake.cri.searchField eq 'g_content'?'selected':''}"/>>내용</option>
			<option value="doc" <c:out value="${pageMake.cri.searchField eq 'doc'?'selected':''}"/>>제목+내용</option>
			<option value="m_id" <c:out value="${pageMake.cri.searchField eq 'm_id'?'selected':''}"/>>작성자</option>
		</select>
		<input type="text" id="keyword" name="keyword" value="${pageMake.cri.keyword}">
		<input type="hidden" id="gc_code" name="gc_code" value="${pageMake.cri.gc_code}">
		<input type="hidden" id="c_no" name="c_no" value="${c_no}">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageMake.cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${pageMake.cri.amount}">
		<button id="searchBtn" class="btn btn_outline-dark">검색</button>
		<button id="allGoodsBtn" class="btn btn-outline-dark float-right">전체글</button>
   </form>
   
   <!-- 페이징 -->
   <div class="float-right">
   	<ul class="pagination">
   		
   	</ul>
   </div>
   <!-- paging end -->
   <hr>
   <button id="insertBtn" type="button" class="btn btn-outline-dark">상품등록</button>
   <hr>
<%@include file="../includes/footer.jsp"%>