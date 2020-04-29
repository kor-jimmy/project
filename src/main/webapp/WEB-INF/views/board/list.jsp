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
    <h2><c:out value="${catkeyword}"/> 게시판 입니다.</h2>
    <table>
        <thead>
            <tr>
                <td>게시물번호</td>
                <td>작성자</td>
                <td>제목</td>
                <td>날짜</td>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list }" var="board" >
               
               		<tr>
	                    <td><c:out value="${board.b_no }"/></td>
	                    <td><c:out value="${board.m_id }"/></td>
	                    <td><a href="/board/get?b_no=${board.b_no }"><c:out value="${board.b_title }"/></a></td>
	                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_date }"/></td>
                	</tr>
            </c:forEach>
        </tbody>
    </table>
    <hr>
    <button id="insertBtn">게시물 등록</button>
    <input type="hidden" name="c_no" id="c_no" value="${c_no}">

<%@include file="../includes/footer.jsp"%>  
