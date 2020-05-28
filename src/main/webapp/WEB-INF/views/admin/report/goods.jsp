<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../header.jsp"%>
<style>
	a{
		text-decoration: none !important;
		color: dimgray;
	}
	.page-link{
		background-color: #000000;
		border-color: #000000;
	}
</style>

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
		
		//체크박스 전체 선택
		$("#checkAll").click(function(e){
			if($("#checkAll").prop("checked")){
				$("input[name='choose']").prop("checked",true);
				console.log("전체선택")
			}else{
				$("input[name='choose']").prop("checked",false);
				console.log("전체선택 해제")
			}
			
		})

		//체크박스 이벤트 처리.

		var checkBox = function(){
			var checkList = [];

			$("input[name='choose']:checked").each(function(idx, item){
				checkList.push($(this).val());
			})
			
			var checkBoxList = {list:checkList};
			console.log(checkBoxList);
			var re = confirm("선택된 게시물을 삭제하시겠습니까?")
			if(re){
				$.ajax({
					url:"/admin/report/chooseGoodsDelete",
					type:"POST",
					data:checkBoxList,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)	
					},
					cache:false,
					success:function(msg){
						alert(msg);
						location.href="/admin/report/goods";
					}
				})
			}				  
		}

		$("#chooseDelete").click(function(e){
			checkBox();
		})
		
	})
	
</script>
	
<div class="col mt-4">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-dark">신고 굿즈 게시물</h6>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<table class="table table-hover">
				<thead>
					<tr align="center">
						<th width="5%"><input type="checkbox" id="checkAll"></th>
						<th width="10%">번호</th>
						<th width="45%">제목</th>
						<th width="10%">작성자</th>
						<th width="10%">날짜</th>
						<th width="10%">신고수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ goodsList }" var="g">
						<tr>
							<td align="center"><input type="checkbox" value="${ g.g_no }" name="choose"></td>
							<td align="center"><c:out value="${ g.g_no }" /></td>
							<td>
								<a class="" href="/goods/get?g_no=${ g.g_no } " target="_blank">
									<c:out value="${ g.g_title }" />
									<span class="badge badge-light">${ g.g_replycnt }</span>
								</a>
							</td>	
							<td align="center">
								<a href="/admin/member/list?pageNum=1&amount=10&searchField=m_id&keyword=${ g.m_id }">
									<c:out value="${ g.m_id }" />
								</a>
							</td>
							<td align="center">
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${ g.g_date }" />
							</td>
							<td align="center"><c:out value="${ g.g_reportcnt }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<hr>
			<button id="chooseDelete">선택 삭제</button>
			<!-- 페이징 -->
			<nav ria-label="Page navigation example">
			
				<ul class="pagination justify-content-end">
					<c:if test="${ pageMake.prev }">
						<li class="page-item disabled">
							<a class="page-link" href="${ pageMake.startPage -1 }">이전</a>
						</li>
						<!-- <li>&nbsp;/&nbsp;</li> -->
					</c:if>
					<c:forEach var="num" begin="${ pageMake.startPage }" end="${ pageMake.endPage }">
						<li class="page-item ${ pageMake.cri.pageNum==num ? "active": ""}">
							<a class="page-link" href="${ num }">${ num }</a>
						</li>
						<!-- <li>&nbsp;/&nbsp;</li> -->
					</c:forEach>
					<c:if test="${ pageMake.next }">
						<li class="page-item">
							<a class="page-link" href="${ pageMake.endPage+1 }">다음</a>
						</li>
					</c:if>
				</ul>
				<!-- 페이징 관련 a태그 속성 관리 -->
				<form id="actionForm" action="/admin/report/board" method="get">
					<input type="hidden" name="pageNum" value="${ pageMake.cri.pageNum }">
					<input type="hidden" name="amount" value="${ pageMake.cri.amount }"> 
				</form>
			</nav>
			<!-- end 페이징 -->
			
		</div>
	</div>
</div>



<%@include file="../footer.jsp"%>
