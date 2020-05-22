<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<style>
	#container{

	}
	a, li{
		text-decoration: none;
		list-style: none;
		display: inline-block;
		float: left;
	}
	.cat{
		padding: 15px;
		margin: 10px;
		border: 1.5px solid #5FEAC9;
		border-radius: 50px;
		text-align: center;
		background: white;
		opacity: 0.9;
		display: inline-block;
		color: gray;
	}
	.cat:hover{
		box-shadow: 0px 0px 10px #ECECEC;
		cursor: pointer;
		background: linear-gradient(15deg, #a3a1fc, #5FEAC9);
		color: white;
	}
	#box{
		
		margin: 20px;
	}
	.head{
		margin-bottom: 20px;
		padding: 20px;
		border: 1px solid #a3a1fc;
		border-radius: 20px;
		width: 20%;
		height: 100px;
		display: table;
		font-size: 15px;
		color: slategray;
	}
	.head:hover{
		box-shadow: 0px 0px 10px #ECECEC;
		cursor: pointer;
	}
	.clicked_head{
		color: #8882F8;
		border: 2px solid #8882F8;
	}
	.around{
		display: table-cell;
		vertical-align: middle;
		text-align: center;
	}
	.contents{
		margin-left: 20px;
		padding: 20px;
		width: 70%;
		float: right;
	}
	
</style>
<script type="text/javascript">
$(function(){
	$(".contents").hide();

	$(".head").click(function(){
		$(this).toggleClass("clicked_head");
		$(this).next(".contents").slideToggle(500);
	});
});
</script>
<div id="container">
	<h2>카테고리 목록</h2>
	<br>
	<ul>
		<div id="box">
		<nav>
		  <ul class="nav nav-stacked">
		    <li class="head nav-link"><span class="around"><b>방송</b></span></li>
		   	<div class="contents">
				<c:forEach var="cat" items="${ list }">
					<c:if test="${ cat.c_no <= 100 }">
						
							<a href="/board/list?categoryNum=${cat.c_no }">
								<div class="cat">
									<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
								</div>
							</a>
						
					</c:if>
				</c:forEach>
			</div>
		  </ul>
		</nav>
		
		<nav>
		  <ul class="nav nav-stacked">
		    <li class="head nav-link"><span class="around"><b>연예</b></span></li>
		    <div class="contents">
				<c:forEach var="cat" items="${ list }">
					<c:if test="${ cat.c_no <= 200 && cat.c_no > 100 }">
						<a href="/board/list?categoryNum=${cat.c_no }">
							<div class="cat">
								<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		  </ul>
		</nav>
		
		<nav>
		  <ul class="nav nav-stacked">
		    <li class="head nav-link"><span class="around"><b>영화</b></span></li>
		    <div class="contents">
				<c:forEach var="cat" items="${ list }">
					<c:if test="${ cat.c_no <= 300 && cat.c_no > 200 }">
						<a href="/board/list?categoryNum=${cat.c_no }">
							<div class="cat">
								<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		  </ul>
		</nav>
		
		<nav>
		  <ul class="nav nav-stacked">
		    <li class="head nav-link"><span class="around"><b>게임 / 취미</b></span></li>
		    <div class="contents">
				<c:forEach var="cat" items="${ list }">
					<c:if test="${ cat.c_no <= 400 && cat.c_no > 300 }">
						<a href="/board/list?categoryNum=${cat.c_no }">
							<div class="cat">
								<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		  </ul>
		</nav>
		
		<nav>
		  <ul class="nav nav-stacked">
		    <li class="head nav-link"><span class="around"><b>스포츠 / 기타</b></span></li>
		    <div class="contents">
				<c:forEach var="cat" items="${ list }">
					<c:if test="${ cat.c_no <= 500 && cat.c_no > 400 }">
						<a href="/board/list?categoryNum=${cat.c_no }">
							<div class="cat">
								<li><div class="categories" id="${ cat.c_dist }"><c:out value="${ cat.c_dist }"/></div></li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		  </ul>
		</nav>

		</div>
	</ul>
	
</div>
<%@include file="../includes/footer.jsp"%>