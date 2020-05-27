<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../header.jsp"%>


<script type="text/javascript">
	$(function(){

		//시큐리티 csrf
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		//페이징 관련 내용
		var actionForm = $("#actionForm");
		
		$(".page-link").on("click", function(e){
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

		//전체회원
		$("#allMember").on("click", function(e){
			e.preventDefault();
			self.location = "/admin/member/list";
		});

		//회원 상태 수정
		$(".editMember").on("click",function(e){
			var m_id = $(this).attr("m_id");
			var role = $("#"+m_id+" #role").val();
			var m_state = $("#"+m_id+" #m_state").val();
			var m_bandate = $("#"+m_id+" #m_bandate").val();

			var year = m_bandate.substring(0,4);
			var month = m_bandate.substring(5,7)-1;
			var day = m_bandate.substring(8,10);
			var date = new Date(year,month,day);
			console.log(m_bandate);
			console.log(year)
			console.log(month)
			console.log(day)

			var state= {m_id:m_id,role:role,m_state:m_state,m_bandate:date}
			console.log(state);
	 		$.ajax({
					url:"/admin/member/updateState",
					type:"POST",
					data:state,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false,
					success:function(result){
						location.href="/admin/member/list";
					}
				})  
		})

	})
	
</script>

<div class="col mt-4">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">회원 목록 / 관리</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<table class="table table-hover">
				<thead>
					<tr align="center">
						<th width="15%">회원ID</th>
						<th width="15%">닉네임</th>
						<th width="10%">누적신고</th>
						<th width="20%">권한</th>
						<th width="10%">회원 상태</th>
						<th width="10%">정지 날짜</th>
						<th width="10%">날짜 지정</th>						
						<th width="10%">관리</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="member">
						<tr id="${member.m_id }">
							<td align="center"><c:out value="${member.m_id }" /></td>
							<td align="center"><c:out value="${member.m_nick }" /></td>
							<td align="center"><c:out value="${member.m_reportcnt }" /></td>
							<td align="center">
								<select id="role" class="custom-select mr-sm-2">
									<option value="ROLE_MASTER" <c:if test="${member.role == 'ROLE_MASTER'}">selected</c:if>>ROLE_MASTER</option>
									<option value="ROLE_MANAGER" <c:if test="${member.role == 'ROLE_MANAGER'}">selected</c:if>>ROLE_MANAGER</option>
									<option value="ROLE_USER" <c:if test="${member.role == 'ROLE_USER'}">selected</c:if>>ROLE_USER</option>
								</select>
							</td>
							<td align="center">
								<select id="m_state" class="custom-select mr-sm-2">
									<option value="ACTIVATE" <c:if test="${member.m_state == 'ACTIVATE'}">selected</c:if>>활성</option>
									<option value="DEACTIVATE" <c:if test="${member.m_state == 'DEACTIVATE'}">selected</c:if>>일시정지</option>
									<option value="BAN" <c:if test="${member.m_state == 'BAN'}">selected</c:if>>영구정지</option>
								</select>
							</td>
							<td align="center">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${member.m_bandate }" />
							</td>
							<td align="center">
								<input type="date" name ="m_bandate" id="m_bandate">
							</td>
							<td align="center">
								<button class="editMember btn btn-outline-dark" m_id="${member.m_id }">수정</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>
			
			<!-- 회원 검색 -->
		    <form id="searchForm" action="/admin/member/list" method="get">
			    <div class="form-row align-items-center">
				    	<input type="hidden" name="pageNum" id="pageNum" value="${pageMake.cri.pageNum}">
				    	<input type="hidden" name="amount" id="amount" value="${pageMake.cri.amount}">
			    	    <div class="col-sm-2 my-1">
			    	    	<select class="custom-select mr-sm-2" name="searchField">
					    		<option value="all" <c:out value="${ pageMake.cri.searchField eq 'all'?'selected':'' }"/>>아이디&닉네임</option>
					    		<option value="m_id" <c:out value="${ pageMake.cri.searchField eq 'm_id'?'selected':'' }"/>>아이디
					    		<option value="m_nick" <c:out value="${ pageMake.cri.searchField eq 'm_nick'?'selected':'' }"/>>닉네임
					    		<option value="role" <c:out value="${ pageMake.cri.searchField eq 'role'?'selected':'' }"/>>권한</option>
					    		<option value="m_state" <c:out value="${ pageMake.cri.searchField eq 'm_state'?'selected':'' }"/>>상태</option>
					    	</select>
			    	    </div>
						<div class="col-sm-6 my-1">
							<input type="text" class="form-control" id="keyword" name="keyword" value="${ pageMake.cri.keyword }">
						</div>
				    	
						<div class="col-sm-2 my-1">
							<button id="searchBtn" class="btn btn-outline-dark">검색</button>
						</div>
				    	
				    	<div class="col-sm-2 my-1">
				    		<button id="allMember" class="btn btn-outline-dark float-right">전체 회원</button>
				    	</div>
			    </div>
		    </form>
			
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
				<form id="actionForm" action="/admin/member/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMake.cri.amount }"> 
					<%-- <input type="hidden" name="categoryNum" value="${pageMake.cri.categoryNum }"> --%>
				</form>
			</nav>
			<!-- end 페이징 -->
			
		</div>
	</div>
</div>



<%@include file="../footer.jsp"%>