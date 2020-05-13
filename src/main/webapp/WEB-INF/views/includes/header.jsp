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
/*         #customNav{
			padding-left:200px;
			padding-right: 200px;
        }	 */
    </style>
    <script>
		$(function(){
			var menuCategory = function(categoryInfo){
				$(".dropdown-menu").empty();
				$.ajax("/menuCategory",{
					data: categoryInfo,
					success:function(data){
						console.log("ajax 통신");
						var menus = JSON.parse(data)
						$.each(menus,function(idx,menu){
							console.log(menu)
							var categoryName = $("<a class='dropdown-item'></a>").text(menu.c_dist).attr("href","/board/list?categoryNum="+menu.c_no);
							var line = $("<div class='dropdown-divider'></div>");
							$(".dropdown-menu").append(categoryName,line);
						})
					}
				})
			}

			$("#brodMenu").click(function(e){
				var info = {startNum:1, endNum:100};
				menuCategory(info);
			})
			
			$("#entMenu").click(function(e){
				var info = {startNum:101, endNum:200};
				menuCategory(info);
			})
			
			$("#movieMenu").click(function(e){
				var info = {startNum:201, endNum:300};
				menuCategory(info);
			})
			
			$("#gameMenu").click(function(e){
				var info = {startNum:301, endNum:400};
				menuCategory(info);
			})
			
			$("#sportMenu").click(function(e){
				var info = {startNum:401, endNum:500};
				menuCategory(info);
			})
		})
    </script>
</head>

<body>
    <!--header-->
    <div class="jumbotron mb-0" id="headerTop" style="background-color: rgb(163, 161, 252);">
    	<div class="container">
            <div class="row">
                <div class="col-4">
                    <a href="/aeho">
                        <img src="/img/ma.png" width="200px" height="120px">
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
    <!--end header-->
    <!--menu -->
    <nav class="navbar navbar-dark bg-dark justify-content-center" id="customNav">
    	<div>
	    	<div>
	            <ul class="nav">
	                <li class="nav-item"><a href="#" class="nav-link">공지사항</a></li>
	                <li class="nav-item"><a href="/category/category" class="nav-link">카테고리</a></li>
	                <li id="brodMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	방송
				        </a>
				        <div id="bMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="entMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	연예
				        </a>
				        <div id="eMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="movieMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	영화
				        </a>
				        <div id="mMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">			        				         	
				        </div>
     				</li>
	                <li id="gameMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	게임
				        </a>
				        <div id="gMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="sportMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	스포츠
				        </a>
				        <div id="sMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">			        				         	
				        </div>
     				</li>
	                <li class="nav-item"><a href="/goods/list" class="nav-link">굿즈</a></li>
	                <li class="nav-item"><a href="#" class="nav-link">일정</a></li>
	                <li class="nav-item"><a href="/vote/vote" class="nav-link">투표</a></li>
	            </ul>
	        </div>
    	</div>
    </nav>
    <!--end menu -->

    <!--content-->
    <div class="container pt-3">