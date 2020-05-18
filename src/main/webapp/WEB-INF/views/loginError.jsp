<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="includes/header.jsp"%>
<div class="d-flex justify-content-center">
    <div class="alert alert-danger" role="alert">
    	<h2 class="alert-heading">
    		<span class="badge badge-secondary">
    			Error
    		</span>
    	</h2>
    	<hr>
	    <p class="mb-0">접근 아이디 : ${name }</p>
	    <p class="mb-0">부여된 권한 : ${auth }</p>
	    <p class="mb-0">메세지 : ${msg }</p>
	    <hr>
	    <a href="/aeho">
	    	메인 페이지
	    </a>
    </div>
</div>
<%@include file="includes/footer.jsp"%>  
