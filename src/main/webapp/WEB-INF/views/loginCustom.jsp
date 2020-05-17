<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>

<h2>로그인</h2>
<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
    <font color="red">
        <p>Your login attempt was not successful due to <br/>
            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
    </font>
</c:if>
<form action="/login" method="post">
	<input type="text" name="username" id="m_id">
	<input type="password" name="password" id="m_pwd">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="submit" value="로그인">
</form>

<a href="/member/insert">회원가입</a>

<%@include file="includes/footer.jsp"%>  
