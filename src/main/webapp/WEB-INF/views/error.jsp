<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>
<div class="d-flex justify-content-center">
    <div class="alert alert-danger" role="alert">
	    <h1>에러 페이지</h1>
	    <h4>비정상적인 접근입니다.</h4>
		에러 코드 : <span>${code}</span>
	    <br>
	         에러 메세지 : <span>${msg}</span>
	    <br>
	         시간 : <span>${timestamp}</span>
	    <hr>
	    <a href="/aeho">
	    	메인 페이지
	    </a>
    </div>
</div>
<%@include file="includes/footer.jsp"%>  
