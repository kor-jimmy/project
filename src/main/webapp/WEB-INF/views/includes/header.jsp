<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>

<head>

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

</head>

    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <title>AE-HO!</title>
    <!-- 글꼴 -->
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <link href="/resources/css/total.css" rel="stylesheet">
    <link href="/resources/css/header.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
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
    <script src="../resources/editor/summernote-lite.js"></script>
	<script src="../resources/editor/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/editor/summernote-lite.css">
	
	<!-- alert창 디자인 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
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
		#topIcon{
			margin-right: 30px;
    		margin-bottom: 30px;
		}
		.topPick{
			padding: 12px 18px 12px 18px;
			margin: 10px;
			border: 1.5px solid #5FEAC9;
			border-radius: 50px;
			text-align: center;
			background: rgb(255,255,255,0.7);
			opacity: 0.9;
			display: inline-block;
			color: gray;
			transition: all ease 0.2s 0s;
		}
		
		.topPick:hover{
			cursor: pointer;
			background: linear-gradient(15deg, #a3a1fc, #5FEAC9);
			color: white;
		}
		
		#topPicksLabel{
			font-weight: bold;
			color: gray;
		}

    </style>
    <script>
		$(function(){
			//각 분류별 카테고리를 호출하는 함수.
			var menuCategory = function(categoryInfo, key){
				console.log("함수 동작중");
				$("#"+key).empty();
				$.ajax("/menuCategory",{
					data: categoryInfo,
					success:function(data){
						console.log("ajax 통신");
						var menus = JSON.parse(data)
						$.each(menus,function(idx,menu){
							console.log(menu)
							var categoryName = $("<a class='dropdown-item'></a>").text(menu.c_dist).attr("href","/board/list?categoryNum="+menu.c_no);
							var line = $("<div class='dropdown-divider'></div>");
							$("#"+key).append(categoryName,line);
						})
					}
				})
			}

			$("#brodMenu").click(function(e){
				var info = {startNum:1, endNum:100};
				var key = "bMenu";
				menuCategory(info,key);
			})
			
			$("#entMenu").click(function(e){
				var info = {startNum:101, endNum:200};
				var key = "eMenu";
				menuCategory(info,key);
			})
			
			$("#movieMenu").click(function(e){
				var info = {startNum:201, endNum:300};
				var key = "mMenu";
				menuCategory(info,key);
			})
			
			$("#gameMenu").click(function(e){
				var info = {startNum:301, endNum:400};
				var key = "gMenu";
				menuCategory(info,key);
			})
			
			$("#sportMenu").click(function(e){
				var info = {startNum:401, endNum:500};
				var key = "sMenu";
				menuCategory(info,key);
			})
			
			//검색
			$("#mainTotalSearch").on("click", function(){
				var search_keyword = $("#mainSearch").val();
				location.href="/search/search?keyword="+search_keyword;
			});

			$('#mainSearch').keypress(function(event){
			     if ( event.which == 13 ) {
			         $('#mainTotalSearch').click();
			         return false;
			     }
			});

			$.ajax("/search/listPicks", {success: function(data){
				console.log(data);
				$.each(data, function(idx, p){
					var keyword = $("<div class='topPick'></div>").html(p.p_keyword);
					var a = $("<a></a>").attr("href", "/search/search?keyword=" + p.p_keyword);
					a.append(keyword);
					$("#topPicksList").append(a);
				});
			}});
			
			$("#mypage").on("click",function(){
				var id = ($("#userId").html()).split(":")[1];
				console.log(id);
				location.href="/member/get?m_id="+id;
			})
			
			$("#userMenu").hide();
			
			$("#fixedMenu").on("click",function(e){
				$("#userMenu").show();
				
			})

		})
    </script>
</head>

<body>
    <!--header-->
    <div class="mb-0" id="headerTop" style="background-color: rgb(163, 161, 252);">
    	<div class="container">
            <div class="row">
            	<div class="col-sm">

            	</div>
                <div class="col-sm" align="center">
                    <a href="/aeho">
                        <img src="/img/ma.png" width="200px" height="120px">
                    </a>
                </div>
                <div class="col-sm" align="right">
                	<div class="pt-5">
                		<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">
                			<p id="serachIcon">
                				<span>SEARCH</span>
                				<img src="/img/search.png" width="20px" height="20px">
                			</p>
                		</button>
                	</div>
                </div>
            </div>
        </div>
    </div>
<%--<div class="mb-0" id="headerTop" style="background-color: rgb(163, 161, 252);">
    	<div class="container">
            <div class="row">
                <div class="col-3">
                    <a href="/aeho">
                        <img src="/img/ma.png" width="200px" height="120px">
                    </a>
                </div>
                <div class="col-6">
                	<form class="form-group">
                		<div class="input-group mt-5">
	                		<input type="text" class="form-control" id="mainSearch" placeholder="애호하는 것을 검색하세요!">
	                		<div class="input-group-append">
	                			<button type="button" id="mainTotalSearch">
			            	    	<img src="/img/search.png" width="20px" height="20px">
			              		</button>
	                		</div>
                		</div>
               	 	</form>
                </div>
         		<div class="col-3">
         			<div align="center" class="p-4">
         				<!-- side menu -->
						<input type="checkbox" id="menuicon">
						<label for="menuicon">
							<span></span>
							<span></span>
							<span></span>
						</label>
	         			<div>
	         				<sec:authorize access="hasRole('ROLE_MASTER')">
	         					<!-- <span class="badge badge-pill badge-warning">관리자가 로그인하였습니다.</span> -->
		         				<a href="/admin/admin" class="badge badge-pill badge-warning">관리자 페이지</a>
		         			</sec:authorize>
	         			</div>
						<div>
							<sec:authorize access="isAnonymous()">
								<br><br>
								<a href="/loginCustom" class="badge badge-light">로그인</a>
								<a href="/member/insert" class="badge badge-light">회원가입</a>
							</sec:authorize>
						</div>
						<div>
							<sec:authorize access="isAuthenticated()">
								<img src="/img/userICON.png" width="40" height="40" id="mypage"><br>
								<!-- 유저아이디 -->
								<span class="badge badge-pill badge-dark">
									<div id="userId">ID :<sec:authentication property="principal.username"/></div>
								</span>
								<a href="/logout" class="badge badge-light">로그아웃</a>   
							</sec:authorize>
						</div>
         			</div>

         		</div>
            </div>
        </div>
    </div> --%>
    <!--end header-->



    <!--menu -->
    <nav class="navbar justify-content-center" id="customNav" style="background-color: #D4F2F2">
    	<div>
	    	<div>
	            <ul class="nav">
	                <li class="nav-item"><a href="/board/list?categoryNum=10000" class="nav-link text-secondary">공지사항</a></li>
	                <li class="nav-item"><a href="/category/category" class="nav-link text-secondary">카테고리</a></li>
	                <li id="brodMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle text-secondary" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	방송
				        </a>
				        <div id="bMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="entMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle text-secondary" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	연예
				        </a>
				        <div id="eMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="movieMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle text-secondary" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	영화
				        </a>
				        <div id="mMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">			        				         	
				        </div>
     				</li>
	                <li id="gameMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle text-secondary" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	게임
				        </a>
				        <div id="gMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">		        				         	
				        </div>
     				</li>
	                <li id="sportMenu" class="nav-item dropdown">
				        <a class="nav-link dropdown-toggle text-secondary" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          	스포츠
				        </a>
				        <div id="sMenu" class="dropdown-menu" aria-labelledby="navbarDropdown">			        				         	
				        </div>
     				</li>
	                <li class="nav-item"><a href="/goods/list" class="nav-link text-secondary">굿즈</a></li>
	                <li class="nav-item"><a href="#" class="nav-link text-secondary">일정</a></li>
	                <li class="nav-item"><a href="/vote/vote" class="nav-link text-secondary">투표</a></li>
	            </ul>
	        </div>
    	</div>
    </nav>
    <!--end menu -->
	
	<a style="display:scroll;position:fixed;bottom:10px;right:10px;z-index: 1000" href="#" title="맨위로">
		<img width=60 height=60 id='topIcon' src="/img/topIcon2.png">
	</a>

	<a style="position: fixed; bottom: 10px; left: 10px; z-index: 1000">
		<!-- side menu -->
		<div style="margin-left: 30px; margin-bottom: 30px">
			<div id="userMenu">
				
			</div>
			<div id="fixedMenu">
				<input type="checkbox" id="menuicon">
				<label for="menuicon">
					<span></span>
					<span></span>
					<span></span>
				</label>
			</div>
		</div>
	</a>


	<!-- Modal -->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content p-5" align="center">
 				<div class="serachBox">
					<!-- <h1 id="serachBoxH1">Search</h1> -->
					<br>
					<form>
						<input type="text" id="mainSearch"  name="" placeholder="AE-HO하는 것을 검색해주세요!">
						<input id="mainTotalSearch" name="" value="Search">
					</form>
					<br><br><br>
					<div>
						<h5 id="topPicksLabel" class="mb-3">인기검색어</h5>
					</div>
					<div id="topPicksList"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->
	
    <!--content-->
    <div class="container pt-3">
    