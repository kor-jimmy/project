<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#insertBtn").on("click",function(){
            var c_no = $("#c_no").val();
			self.location = "/board/insert?c_no="+c_no;
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
		
	})
</script>
    <h2><c:out value="${catkeyword}"/></h2>
    <hr>
    <table class="table table-hover">
        <thead>
            <tr align="center">
                <th width="10%">번호</th>
                <th width="50%">제목</th>
                <th width="10%">작성자</th>
                <th width="10%">날짜</th>
                <th width="10%">조회수</th>
                <th width="10%">Love</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list }" var="board" >
               		<tr>
	                    <td align="center"><c:out value="${board.b_no }"/></td>
	                    <td><a href="/board/get?b_no=${board.b_no }"><c:out value="${board.b_title }"/>[<c:out value="${board.b_replycnt }"/>]</a></td>
	                    <td align="center"><c:out value="${board.m_id }"/></td>
	                    <td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
	                    <td align="center"><c:out value="${board.b_hit }"/></td>
	                    <td align="center"><c:out value="${board.b_lovecnt }"/></td>
                	</tr>
            </c:forEach>
        </tbody>
    </table>
    <hr>
    <button id="insertBtn" type="button" class="btn btn-outline-dark">게시물 등록</button>
    <input type="hidden" name="c_no" id="c_no" value="${c_no}">
    
    <!-- 페이징 -->
    <div class="pull-right">
    	<ul class="pagination">
    		<c:if test="${pageMake.prev }">
				<li class="paginate_button previous">
					<a href="${pageMake.startPage -1 }">이전</a>
				</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMake.startPage }" end="${pageMake.endPage }">
				<li class="paginate_button ${pageMake.cri.pageNum==num ? "active": ""}">
					<a href="${num }">${num }</a>
				</li>
			</c:forEach>    		
			
			<c:if test="${pageMake.next }">
				<li class="paginate_button next">
					<a href="${pageMake.endPage+1 }">다음</a>
				</li>
			</c:if>
    	</ul>
    	<!-- 페이징 관련 a태그 속성 관리 -->
    	<form id="actionForm" action="/board/list" method="get">
    		<input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
    		<input type="hidden" name="amount" value="${pageMake.cri.amount }">
    		<input type="hidden" name="categoryNum" value="${pageMake.cri.categoryNum }">    		
    	</form>
    </div>

<%@include file="../includes/footer.jsp"%>  
