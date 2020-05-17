<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="includes/header.jsp"%>

<h2>회원가입</h2>
<form action="/member/insert" method="post">
	아이디<input type="text" name="m_id" id="m_id">
	비밀번호<input type="password" name="m_pwd" id="m_pwd">
	닉네임<input type="text" name="m_nick" id="m_nick">
	email<input type="email" name="m_email" id="m_email">
	휴대전화<input type="text" name="m_phone" id="m_phone">
	<input type="button" value="회원가입">
	<input type="reset" value="리셋">
	<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
</form>


<%@include file="includes/footer.jsp"%>  
