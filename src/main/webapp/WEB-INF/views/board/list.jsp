<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
	#boardArticles { background: rgba( 255, 255, 255, 0.5 ); }
	a{ text-decoration: none !important; color: dimgray; }
	
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
	$(function(){
		var c_no = $("#c_no").val();
		$("#insertBtn").on("click",function(){
			self.location = "/board/insert?c_no="+c_no;
		})
		
		if(!$("tbody tr").length){
			var div = $("<div style='color: gray; font-weight: bold;'></div>").html("작성된 글이 없습니다. 첫 글을 남겨보세요!");
			var td = $("<td style='height: 300px; vertical-align: middle;' colspan='6' align='center'></td>").append(div);
			$("tbody").append(td);
		}

		//페이징 관련 내용
		var actionForm = $("#actionForm");

		$(".paging-btn a").on("click", function(e){
			//a태그 기본 속성 제거
			e.preventDefault();
			console.log("click");
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})

		//검색 관련 form
		var searchForm = $("#searchForm");

		$("#searchBtn").on("click", function(e){
			//if(!searchForm.find("option:selected").val()){
			//	alert("검색하고자 하는 분류를 선택해주십시오.");
			//	return false;
			//}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력해주십시오.");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();

			searchForm.submit();
		});

		$("#allBoardBtn").on("click", function(e){
			e.preventDefault();
			self.location = "/board/list?categoryNum="+c_no;
		});
	})
	
</script>
	<div class="row">
		<div class="col">
			 <h2><c:out value="${catkeyword}"/></h2>
		</div>
	    <!-- 게시물 인서트 -->
	    <div class="col">
	    	<c:choose>
	    		<c:when test="${catkeyword == '공지사항'}">
	    		</c:when>
	    		<c:when test="${catkeyword != '공지사항'}">
	    		<sec:authorize access="isAuthenticated()">
						<button id="insertBtn" type="button" class="btn btn-outline-dark float-right">게시물 등록</button>
					</sec:authorize>
	    		</c:when>
	    	</c:choose>
	    </div>
	    <!-- end 게시물 인서트 -->
	</div>

	<div id="boardArticles">
    <table class="table table-hover">
        <thead>
            <tr align="center">
                <th width="10%">번호</th>
                <th width="45%">제목</th>
                <th width="15%">작성자</th>
                <th width="10%">날짜</th>
                <th width="10%">조회수</th>
                <th width="10%">Love</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list }" var="board" >
               		<tr>
	                    <td align="center"><c:out value="${board.b_no }"/></td>
	                    <td><a class="" href="/board/get?b_no=${board.b_no }"><c:out value="${board.b_title }"/><span class="badge badge-light">${board.b_replycnt }</span></a></td>
	                    <td align="center"><c:out value="${board.m_nick }"/></td>
	                    <td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
	                    <td align="center"><c:out value="${board.b_hit }"/></td>
	                    <td align="center"><c:out value="${board.b_lovecnt }"/></td>
                	</tr>
            </c:forEach>
        </tbody>
    </table>
    
    <hr>
    <!-- 게시물 검색 -->
    <form id="searchForm" action="/board/list" method="get">
	    <div class="form-row align-items-center">
	    	    <input type="hidden" id="categoryNum" name="categoryNum" value="${ c_no }">
	    	    <input type="hidden" name="c_no" id="c_no" value="${c_no}">
		    	<input type="hidden" name="pageNum" id="pageNum" value="${pageMake.cri.pageNum}">
		    	<input type="hidden" name="amount" id="amount" value="${pageMake.cri.amount}">
	    	    <div class="col-sm-2 my-1">
	    	    	<select class="custom-select mr-sm-2" name="searchField">
			    		<option value="all" <c:out value="${ pageMake.cri.searchField eq 'all'?'selected':'' }"/>>전체</option>
			    		<option value="b_title" <c:out value="${ pageMake.cri.searchField eq 'b_title'?'selected':'' }"/>>제목
			    		<option value="b_content" <c:out value="${ pageMake.cri.searchField eq 'b_content'?'selected':'' }"/>>내용</option>
			    		<option value="doc" <c:out value="${ pageMake.cri.searchField eq 'doc'?'selected':'' }"/>>제목+내용</option>
			    		<option value="m_id" <c:out value="${ pageMake.cri.searchField eq 'm_id'?'selected':'' }"/>>작성자</option>
			    	</select>
	    	    </div>
				<div class="col-sm-6 my-1">
					<input type="text" class="form-control" id="keyword" name="keyword" value="${ pageMake.cri.keyword }">
				</div>
		    	
				<div class="col-sm-2 my-1">
					<button id="searchBtn" class="btn btn-outline-dark">검색</button>
				</div>
		    	
		    	<div class="col-sm-2 my-1">
		    		<button id="allBoardBtn" class="btn btn-outline-dark float-right">전체글</button>
		    	</div>
	    </div>
    </form>
	
    <hr>
    </div>
    <!-- 페이징 -->
    <div class="float-right">
    	<ul class="pagination">
    		<c:if test="${pageMake.prev }">
				<li class="paging-btn btn btn-outline-secondary previous">
					<a href="${pageMake.startPage -1 }">이전</a>
				</li>
				<li>&nbsp;/&nbsp;</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMake.startPage }" end="${pageMake.endPage }">
				<li class="paging-btn btn btn-outline-secondary ${pageMake.cri.pageNum==num ? "active": ""}">
					<a href="${num }">${num }</a>
				</li>
				<li>&nbsp;</li>
			</c:forEach>    		
			
			<c:if test="${pageMake.next }">
				<li class="paging-btn btn btn-outline-secondary next">
					<a href="${pageMake.endPage+1 }">다음</a>
				</li>
			</c:if>
    	</ul>
    	<!-- 페이징 관련 a태그 속성 관리 -->
    	<form id="actionForm" action="/board/list" method="get">
    		<input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
    		<input type="hidden" name="amount" value="${pageMake.cri.amount }">
    		<input type="hidden" name="categoryNum" value="${pageMake.cri.categoryNum }"> 
    		<input type="hidden" name="searchField" value="${ pageMake.cri.searchField }">   		
    		<input type="hidden" name="keyword" value="${ pageMake.cri.keyword }">    		
    	</form>
    </div>
    <!-- end 페이징 -->
	<br>

<%@include file="../includes/footer.jsp"%>  
