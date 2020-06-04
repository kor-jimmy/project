<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
	$(function(){
		var c_no = $("#c_no").val();
		//페이징 관련 내용
		var actionForm = $("#actionForm");

		$(".paginate_button a").on("click", function(e){
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

		$(".noticeBtn").on("click", function(e){
			var cno = $(this).attr("c_no")
			e.preventDefault();
			self.location = "/main/notice?categoryNum="+cno;
		});
	})
	
</script>
	<div class="row">
		<div class="col">
			 <h2>공지사항</h2>
		</div>
	</div>
	<hr>
	<div >
		<button class="noticeBtn btn btn-outline-dark" c_no='10000'>전체</button>
		<button class="noticeBtn btn btn-outline-dark" c_no='10001'>일반</button>
		<button class="noticeBtn btn btn-outline-dark" c_no='10002'>징계/정책</button>
		<button class="noticeBtn btn btn-outline-dark" c_no='10003'>업데이트</button>
		<button class="noticeBtn btn btn-outline-dark" c_no='10004'>이벤트</button>
	</div>
	<hr>

    <table class="table table-hover">
        <thead>
            <tr align="center">
	            <th width="10%">번호</th>
				<th width="10%">분류</th>
				<th width="40%">제목</th>
				<th width="10%">작성자</th>
				<th width="10%">날짜</th>
				<th width="10%">조회수</th>
			</tr>
        </thead>
        <tbody>
            <c:forEach items="${list }" var="board" >
               		<tr>
	                    <td align="center"><c:out value="${board.b_no }"/></td>
	                    <td align="center">
							<c:if test="${board.c_no == 10001}">일반</c:if>
							<c:if test="${board.c_no == 10002}">징계/정책</c:if>
							<c:if test="${board.c_no == 10003}">업데이트</c:if>
							<c:if test="${board.c_no == 10004}">이벤트</c:if>
						</td>
	                    <td><a class="" href="/board/get?b_no=${board.b_no }"><c:out value="${board.b_title }"/><span class="badge badge-light">${board.b_replycnt }</span></a></td>
	                    <td align="center"><c:out value="${board.m_nick }"/></td>
	                    <td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
	                    <td align="center"><c:out value="${board.b_hit }"/></td>
                	</tr>
            </c:forEach>
        </tbody>
    </table>
    
    <hr>
    <!-- 게시물 검색 -->
    <form id="searchForm" action="/main/notice" method="get">
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
			    	</select>
	    	    </div>
				<div class="col-sm-6 my-1">
					<input type="text" class="form-control" id="keyword" name="keyword" value="${ pageMake.cri.keyword }">
				</div>
		    	
				<div class="col-sm-2 my-1">
					<button id="searchBtn" class="btn btn-outline-dark">검색</button>
				</div>
		    	

	    </div>
    </form>

    <hr>
    <!-- 페이징 -->
    <div class="float-right">
    	<ul class="pagination">
    		<c:if test="${pageMake.prev }">
				<li class="paginate_button previous">
					<a href="${pageMake.startPage -1 }">이전</a>
				</li>
				<li>&nbsp;/&nbsp;</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMake.startPage }" end="${pageMake.endPage }">
				<li class="paginate_button ${pageMake.cri.pageNum==num ? "active": ""}">
					<a href="${num }">${num }</a>
				</li>
				<li>&nbsp;/&nbsp;</li>
			</c:forEach>    		
			
			<c:if test="${pageMake.next }">
				<li class="paginate_button next">
					<a href="${pageMake.endPage+1 }">다음</a>
				</li>
			</c:if>
    	</ul>
    	<!-- 페이징 관련 a태그 속성 관리 -->
    	<form id="actionForm" action="/main/notice" method="get">
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
