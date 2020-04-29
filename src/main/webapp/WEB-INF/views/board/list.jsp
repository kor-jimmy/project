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
	                    <td><a href="/board/get?b_no=${board.b_no }"><c:out value="${board.b_title }"/></a></td>
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

<%@include file="../includes/footer.jsp"%>  
