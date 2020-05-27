<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>

  <title>Ae-Ho 관리자 모드</title>

  <!-- Custom fonts for this template-->
  <link href="/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
  
    <!-- Bootstrap core JavaScript-->
  <script src="/resources/admin/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/admin/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="/resources/admin/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/resources/admin/js/demo/chart-area-demo.js"></script>
  <script src="/resources/admin/js/demo/chart-pie-demo.js"></script>
  
      <!-- summer note -->
    <script src="/resources/editor/summernote-lite.js"></script>
	<script src="/resources/editor/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/editor/summernote-lite.css">
	<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin/admin">
        <div class="sidebar-brand-text mx-3">Ae-Ho 관리 페이지</div>
      </a>
      
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/aeho">
        <div class="sidebar-brand-text mx-3">메인페이지</div>
      </a>
      

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Menu -->
      <div class="sidebar-heading">
        Community 관리
      </div>

      <!-- 카테고리 관리 메뉴 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#categoryEdit" aria-expanded="true" aria-controls="categoryEdit">
          <span>카테고리</span>
        </a>
        <div id="categoryEdit" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">카테고리 관리</h6>
            <a class="collapse-item" href="/admin/category/manage">카테고리 정보 관리</a>
          </div>
        </div>
      </li>

      <!-- 게시물 관리 메뉴 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <span>게시물</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">게시물  관리</h6>
            <a class="collapse-item" href="/admin/notice/notice?categoryNum=10000">공지사항 관리</a>
            <a class="collapse-item" href="/admin/report/board">게시물 신고</a>
            <a class="collapse-item" href="/admin/report/reply">댓글 신고</a>
          </div>
        </div>
      </li>
      
      <!-- 굿즈 관리-->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#goodsEdit" aria-expanded="true" aria-controls="goodsEdit">
          <span>굿즈</span>
        </a>
        <div id="goodsEdit" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">굿즈 관리</h6>
            <a class="collapse-item" href="#">굿즈 목록</a>
            <a class="collapse-item" href="#">신고 접수</a>
          </div>
        </div>
      </li>
      
      <!-- 투표 관리-->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#voteEdit" aria-expanded="true" aria-controls="voteEdit">
          <span>투표</span>
        </a>
        <div id="voteEdit" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">투표 관리</h6>
            <a class="collapse-item" href="/admin/vote/manage">투표 정보 관리</a>
          </div>
        </div>
      </li>
      
      <!-- qna-->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#qna" aria-expanded="true" aria-controls="qna">
          <span>Q&A</span>
        </a>
        <div id="qna" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Q&A</h6>
            <a class="collapse-item" href="#">신규 Q&A</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- User -->
      <div class="sidebar-heading">
      	User
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#userEdit" aria-expanded="true" aria-controls="userEdit">
          <span>회원</span>
        </a>
        <div id="userEdit" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">회원관리</h6>
            <a class="collapse-item" href="/admin/member/list">회원 목록/관리</a>
          </div>
        </div>
      </li>
      
	  <!-- Divider -->
      <hr class="sidebar-divider">
      
      <!-- Page -->
      <div class="sidebar-heading">
      	Page
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#pageEdit" aria-expanded="true" aria-controls="pageEdit">
          <span>페이지</span>
        </a>
        <div id="pageEdit" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">페이지 관리</h6>
            <a class="collapse-item" href="#">메인 이미지</a>
          </div>
        </div>
      </li>

    </ul>
    <!-- End of Sidebar -->
    
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">
      	<!-- Begin Page Content -->
        <div class="container-fluid">

