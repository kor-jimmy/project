<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>
	<h2>에러 페이지</h2>
    <div class="container">
<!--         <form th:action="@{/logout}" method="post"> 
        <button class="btn btn-md btn-danger btn-block" name="registration"type="Submit">Logout</button> 
        </form> -->
        <div class="panel-group" style="margin-top:40px">
            <div class="panel panel-primary">
                <div class="panel-heading"> <span><c:out value="${name }"/></span></div>
                <p class="admin-message-text text-center"><c:out value="${auth }"/></p>
                <p class="admin-message-text text-center"><c:out value="${msg }"/></p>
            </div>
        </div>
    </div>

<%@include file="includes/footer.jsp"%>  
