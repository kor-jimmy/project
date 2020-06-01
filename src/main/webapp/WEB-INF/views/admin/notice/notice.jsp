<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../header.jsp"%>

<script type="text/javascript">
	$(function(){
		//페이징 관련 내용
		var actionForm = $("#actionForm");
		
		$(".page-link").on("click", function(e){
			//a태그 기본 속성 제거
			e.preventDefault();
			console.log("click");
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})
	})
	
</script>

<div class="col mt-4">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">
				<c:if test="${categoryNum==10010 }">관리자 공지사항</c:if>
				<c:if test="${categoryNum==10000 }">유저 공지사항</c:if>
			</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<a href="/admin/notice/insert?c_no=10000">공지사항 등록</a>
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
					<c:forEach items="${list }" var="board">
						<tr>
							<td align="center"><c:out value="${board.b_no }" /></td>
							<td align="center">
								<c:if test="${board.c_no == 10001}">일반</c:if>
								<c:if test="${board.c_no == 10002}">징계/정책</c:if>
								<c:if test="${board.c_no == 10003}">업데이트</c:if>
								<c:if test="${board.c_no == 10004}">이벤트</c:if>
								<c:if test="${board.c_no == 10010}">관리자</c:if>
							</td>
							<td>
								<a class="" href="/board/get?b_no=${board.b_no }" target="_blank">
									<c:out value="${board.b_title }" />
									<span class="badge badge-light">${board.b_replycnt }</span>
								</a>
							</td>	
							<td align="center"><c:out value="${board.m_id }" /></td>
							<td align="center">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }" />
							</td>
							<td align="center"><c:out value="${board.b_hit }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr>
			<!-- 페이징 -->
			<nav ria-label="Page navigation example">
				<ul class="pagination justify-content-end">
					<c:if test="${pageMake.prev }">
						<li class="page-item disabled">
							<a class="page-link" href="${pageMake.startPage -1 }">이전</a>
						</li>
						<!-- <li>&nbsp;/&nbsp;</li> -->
					</c:if>
					<c:forEach var="num" begin="${pageMake.startPage }" end="${pageMake.endPage }">
						<li class="page-item ${pageMake.cri.pageNum==num ? "active": ""}">
							<a class="page-link" href="${num }">${num }</a>
						</li>
						<!-- <li>&nbsp;/&nbsp;</li> -->
					</c:forEach>
					<c:if test="${pageMake.next }">
						<li class="page-item">
							<a class="page-link" href="${pageMake.endPage+1 }">다음</a>
						</li>
					</c:if>
				</ul>
				<!-- 페이징 관련 a태그 속성 관리 -->
				<form id="actionForm" action="/admin/notice/notice" method="get">
					<input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMake.cri.amount }"> 
					<input type="hidden" name="categoryNum" value="${pageMake.cri.categoryNum }">
				</form>
			</nav>
			<!-- end 페이징 -->
		</div>
	</div>
</div>

<%@include file="../footer.jsp"%>
