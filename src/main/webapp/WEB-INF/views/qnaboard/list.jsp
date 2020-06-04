<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
$(function(){
	var c_no = $("#c_no").val();
	var qb_no = $("#qb_no").val();
	$("#insertBtn").on("click",function(){
		self.location = "/qnaboard/insert?c_no="+c_no+"&qb_no=0";
	})

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
		if(!searchForm.find("input[name='searchKeyword']").val()){
			alert("검색어를 입력해주십시오.");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();

		searchForm.submit();
	});

	$("#allBoardBtn").on("click", function(e){
		e.preventDefault();
		self.location = "/qnaboard/list?categoryNum="+c_no;
	});
});
</script>
    <h2><c:out value="${catKeyword}"/></h2>
    <input type="hidden" name="c_no" id="c_no" value="${c_no}">
    <input type="hidden" name="qb_no" id="qb_no" value="${qb_no}">
    <hr>
    <table class="table table-hover">
        <thead>
            <tr align="center">
                <th width="10%">번호</th>
                <th width="50%">제목</th>
                <th width="10%">작성자</th>
                <th width="10%">날짜</th>
            </tr>
        </thead>
         <tbody>
	 	 <c:forEach var="qnaboard" items="${list }">
	 	 <tr onclick="location.href='/qnaboard/get?qb_no=${qnaboard.qb_no}'">
		<td><c:out value="${qnaboard.qb_no }"/></td>
		<td>
			<c:choose> 
				<c:when test = "${qnaboard.qb_level > 0}">
					<c:forEach begin="0" end="${qnaboard.qb_level}">
					<c:out value="&nbsp;&nbsp;&nbsp;&nbsp;" escapeXml="false"/> 
					</c:forEach>	
						<img src="/img/re.png" width="20" height="20">
						<c:out value="${qnaboard.qb_title }"/>
				</c:when> 
				<c:otherwise>
					<c:out value="${qnaboard.qb_title}"/>		
				</c:otherwise> 
			</c:choose>
		</td>
				<td><c:out value="${qnaboard.m_id }"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${qnaboard.qb_date }"/></td>
		</tr>
				</c:forEach>
      </tbody>
    </table>
    <hr>
    <!-- 게시물 검색 -->
    <form id="searchForm" action="/qnaboard/list" method="get">
    <input type="hidden" id="categoryNum" name="categoryNum" value="${ c_no }">
    	<select name="searchField">
    		<option value="all" <c:out value="${ pageMake.cri.searchField eq 'all'?'selected':'' }"/>>전체</option>
    		<option value="qb_title" <c:out value="${ pageMake.cri.searchField eq 'qb_title'?'selected':'' }"/>>제목
    		<option value="qb_content" <c:out value="${ pageMake.cri.searchField eq 'qb_content'?'selected':'' }"/>>내용</option>
    		<option value="doc" <c:out value="${ pageMake.cri.searchField eq 'doc'?'selected':'' }"/>>제목+내용</option>
    		<option value="m_id" <c:out value="${ pageMake.cri.searchField eq 'm_id'?'selected':'' }"/>>작성자</option>
    	</select>
    	<input type="text" id="searchKeyword" name="searchKeyword" value="${ pageMake.cri.searchKeyword }">
    	<input type="hidden" name="c_no" id="c_no" value="${c_no}">
    	<input type="hidden" name="pageNum" id="pageNum" value="${pageMake.cri.pageNum}">
    	<input type="hidden" name="amount" id="amount" value="${pageMake.cri.amount}">
    	<button id="searchBtn" class="btn btn-outline-dark">검색</button>
    	<button id="allBoardBtn" class="btn btn-outline-dark float-right">전체글</button>
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
    	<form id="actionForm" action="/qnaboard/list" method="get">
    		<input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
    		<input type="hidden" name="amount" value="${pageMake.cri.amount }">
    		<input type="hidden" name="categoryNum" value="${pageMake.cri.categoryNum }"> 
    		<input type="hidden" name="searchField" value="${ pageMake.cri.searchField }">   		
    		<input type="hidden" name="searchKeyword" value="${ pageMake.cri.searchKeyword }">    		
    	</form>
    </div>
    <!-- end 페이징 -->
    <!-- 게시물 인서트 -->
    <div>
    	<button id="insertBtn" type="button" class="btn btn-outline-dark">게시물 등록</button>
    </div>
    <!-- end 게시물 인서트 -->

<%@include file="../includes/footer.jsp"%>