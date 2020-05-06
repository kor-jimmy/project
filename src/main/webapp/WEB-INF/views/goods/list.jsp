<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
function listGoods(gc_code,keyword){
//	c_no를 강제로 넣어주기 위해 카테고리 설정시에만 글쓰기 버튼 보이게
   if(keyword == null){
      $("#insertBtn").css("visibility","hidden");
   }
   else{
      $("#insertBtn").css("visibility","visible");
   }
   
   $("#tb").empty();
   $.ajax("/goods/listGoods",{data:{gc_code:gc_code,keyword:keyword}, success:function(result){
//      console.log(result);
      $.each(result, function(idx,item){
         //상품번호,제목,코드,가격,날짜
         var td1=$("<td align='center'></td>").html(item.g_no);
         var a=$("<a>"+item.g_title+"</a>").attr("href","/goods/get?g_no="+item.g_no)
         var td2=$("<td></td>").html(a);
         var td3=$("<td align='center'></td>").html(item.gc_code);
         var td4=$("<td align='center'></td>").html(item.g_price);
         var td5=$("<td align='center'></td>").html(item.g_date);
         var tr = $("<tr></tr>").append(td1,td2,td3,td4,td5);
      //   $(tr).on("click",function(){
      //      self.location = "/goods/get?g_no="+item.g_no;
      //   })
         $("#tb").append(tr);
      })
   }})
}
$(function(){
   var c_no;
   listGoods(0)   
   var gc_code=0;
   $.ajax("/category/goodsCateList",{success:function(result){
//      console.log(result)
      var b=$("<button id='tot' class='btn btn-outline-dark'></button>").html('전체보기');
      $(b).on("click",function(){
         listGoods(gc_code);
      })
      $("#goodsType").append(b);
      $.each(result,function(idx,item){
         var c_dist= $("<button id='listCate' type='button' class='btn btn-outline-dark'></button>").html(result[idx].c_dist);
         var nbsp="  ";
         $("#goodsType").append(c_dist,nbsp);
         $(c_dist).on("click",function(){
             console.log(gc_code);
            c_no=result[idx].c_no;
//            console.log(c_no)
//            console.log($(c_dist).html())
//			console.log(gc_code);
            listGoods(gc_code,$(this).html())
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
		console.log(gc_code);
		listGoods(gc_code);
	})
	$("#sellBtn").on("click",function(){
		$(this).css("background","pink");
		$("#buyBtn").css("background","white");
		gc_code=$(this).val();
		console.log(gc_code);
		listGoods(gc_code);
	})
})
</script>
	
   <h2>상품목록</h2><div id=state></div>
   <button id="buyBtn" type="button" class="btn btn-outline-dark" value="2">삽니다</button>
   <button id="sellBtn" type="button" class="btn btn-outline-dark" value="1">팝니다</button>
   <hr>
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
   <button id="insertBtn" type="button" class="btn btn-outline-dark">상품등록</button>
   <hr>
<%@include file="../includes/footer.jsp"%>