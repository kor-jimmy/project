<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AE-HO!</title>
    <!-- 글꼴 -->
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <link href="/resources/css/total.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- 페이징 때문에 넣어논거 충돌나서 다시 닫음. --> 
 	<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->  
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css"> -->
<!-- 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
  
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
    </script>
  
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
    </script>
    
    <!-- summer note -->
    <script src="/resources/editor/summernote-lite.js"></script>
	<script src="/resources/editor/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/editor/summernote-lite.css">
	<style>
        #searchDiv{
            margin-top: 50px;
        }
        #headerTop{
        	padding-top: 5px;
        	padding-bottom: 5px;
        }
        #customNav{
			padding-left:200px;
			padding-right: 200px;
        }	
    </style>
</head>

<body>
    <!--header-->
    <div class="jumbotron mb-0" id="headerTop" style="background-color: rgb(163, 161, 252);">
    	<div class="container">
            <div class="row">
                <div class="col-4">
                    <a href="/aeho">
                        <img src="/img/mainImg.png" width="200px" height="120px">
                    </a>
                </div>
                <div class="col-5 text-center">
                        <div id="searchDiv">
                            <label for="mainSearch">통합검색</label>
                            <input type="text" name="mainSearch" id="mainSearch" size="30" placeholder="애호하는 것을 검색하세요!">
                            <button id="mainTotalSearch">
                                <img src="/img/search.png" width="20px" height="20px">
                            </button>
                        </div>
                </div>
            </div>
        </div>

    </div>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark text-center" id="customNav"> 
        <!-- <a href="/aeho" class="navbar-brand">Ae-Ho</a>
        토글
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button> -->
        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav justify-content-center">
                <li class="nav-item"><a href="#" class="nav-link">공지사항</a></li>
                <li class="nav-item"><a href="/category/category" class="nav-link">카테고리</a></li>
                <li class="nav-item"><a href="/goods/list" class="nav-link">굿즈</a></li>
                <li class="nav-item"><a href="#" class="nav-link">일정</a></li>
                <li class="nav-item"><a href="#" class="nav-link">투표</a></li>
            </ul>
        </div>
    </nav>
    <!--end header-->

    <!--content-->
    <div class="container pt-3">