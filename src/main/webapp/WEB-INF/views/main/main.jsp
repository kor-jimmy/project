<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<style>
    #carousel-inner img{
        width: 1100px;
        height: 300px;
    }
    #bestContent{
    	/* 설정한 너비보다 길면 말줄임 사용 */
    	text-overflow: ellipsis;
    	/* 줄바꿈 사용지 않음 */
    	white-space: nowrap;
    	overflow: hidden;
    	display: block;
    }
    
	
	#voteBox{ width: 90%; cursor: pointer;}
	.hoverVote{ filter: brightness(0.60); }
   
   li{
		list-style: none !important;
	}
	a{
		text-decoration: none !important;
		color: dimgray;
	}
	
	.mainContent{
		display: flex;
		border-radius: 20px;
		background: rgba(255, 255, 255, 0.7);
	}
	#goodsList{
		width: 100%;
		height: auto;
	}
	.goodsBox{
		text-overflow: ellipsis;
		white-space: nowrap;
		word-wrap:normal;
		overflow: hidden;
		float: left;
		margin: 5px 20px 10px 20px;
		width: 100%;
		
		color: dimgray;
	}
	.goodsBox li{
		height: 160px; 
	}
	.goodsImg{
		width: 150px;
		border: 1px solid lightgray;
		margin-bottom: 60%;
	}
	.imgDiv{
		display:inline-block;
		width: 150px;
	}
	.conDiv{
		display:inline-block;
		text-align: left;
		width: 60%;
		margin-left: 30px;
	}
	
		
	table { 
		border-collapse: collapse; 
		border-spacing: 0;		
		width: 100%; 
		table-layout: fixed;
	}
	
	td { 
		vertical-align: middle; 
		overflow:hidden;
		white-space : nowrap;
		text-overflow: ellipsis;
	 }
	
	td.textOverDefault {
		white-space : normal; /*기본값*/
		text-overflow: clip; /*기본값*/
	}


</style>
<script type="text/javascript">
	$(function(){

		$(".carousel-item").first().addClass("active");
		$(".indicators").first().addClass("active");
		
		$.ajax("http://192.168.0.17:5000/videos", 
			{dataType: "jsonp",
			jsonpCallback: "getVideos",
			success: function(data){
				var rand = Math.round(Math.random()*10);
				//<iframe width="560" height="315" src="https://www.youtube.com/embed/iDjQSdN_ig8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				d = data[rand]
				str = d.substr(d.lastIndexOf("=")+1);
				console.log(str);
				frame = $("<iframe width='100%' height='300px'  frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>").attr("src", "https://www.youtube.com/embed/"+str);
				$("#iframe").append(frame);
        }});
        
        $("#carouselExampleIndicators").carousel({
            interval:3000,
            pause:"hover",
            wrap: true
        })
        
		//진탁) 일,주,월 최고의 게시물 호출 함수
        var todayBest = function(){
            $.ajax("/todayBest",{success:function(data){
            	$("#bestContent").empty();
                var ul = $("<ul class='list-group list-group-flush' style='cursor:pointer;'></ul>");
                var list = JSON.parse(data);
                $.each(list, function(idx,content){
                	var category = $("<span class='badge badge-secondary'></span>").text(content.c_dist);
                    var li = $("<li id='listContent' class='list-group-item'></li>").attr("b_no",content.b_no);
					var b_title = $("<p></p>");
					b_title.append(category,content.b_title)
					var cnt = $("<p></p>");
                    var b_loveCnt= $("<span class='badge badge-danger'></span>").text("좋아요  " + content.b_lovecnt);
                    var b_replyCnt = $("<span class='badge badge-info'></span>").text("댓글 " + content.b_replycnt);
                    cnt.append(b_loveCnt,"   ",b_replyCnt);
                    li.append(b_title,cnt);
                    ul.append(li);
                })
                $("#bestContent").append(ul);
            }})
        }
        
		var weekBest = function(){
			console.log("주간 추천")
            $.ajax("/weekBest",{success:function(data){
            	$("#bestContent").empty();
                var ul = $("<ul class='list-group list-group-flush' style='cursor:pointer;'></ul>");
                var list = JSON.parse(data);
                $.each(list, function(idx,content){
                	var category = $("<span class='badge badge-secondary'></span>").text(content.c_dist);
                    var li = $("<li id='listContent' class='list-group-item'></li>").attr("b_no",content.b_no);
					var b_title = $("<p></p>");
					b_title.append(category,content.b_title)
					var cnt = $("<p></p>");
                    var b_loveCnt= $("<span class='badge badge-danger'></span>").text("좋아요  " + content.b_lovecnt);
                    var b_replyCnt = $("<span class='badge badge-info'></span>").text("댓글 " + content.b_replycnt);
                    cnt.append(b_loveCnt,"   ",b_replyCnt);
                    li.append(b_title,cnt);
                    ul.append(li);
                })
                $("#bestContent").append(ul);
            }})
		}

		var monthBest = function(){
			console.log("월간 추천")
            $.ajax("/monthBest",{success:function(data){
            	$("#bestContent").empty();
                var ul = $("<ul class='list-group list-group-flush' style='cursor:pointer;'></ul>");
                var list = JSON.parse(data);
                $.each(list, function(idx,content){
                	var category = $("<span class='badge badge-secondary'></span>").text(content.c_dist);
                    var li = $("<li id='listContent' class='list-group-item'></li>").attr("b_no",content.b_no);
					var b_title = $("<p></p>");
					b_title.append(category,content.b_title)
					var cnt = $("<p></p>");
                    var b_loveCnt= $("<span class='badge badge-danger'></span>").text("좋아요  " + content.b_lovecnt);
                    var b_replyCnt = $("<span class='badge badge-info'></span>").text("댓글 " + content.b_replycnt);
                    cnt.append(b_loveCnt,"   ",b_replyCnt);
                    li.append(b_title,cnt);
                    ul.append(li);
                })
                $("#bestContent").append(ul);
            }})
		}
        
		monthBest();

		//베스트 게시물 클릭 이벤트.
        $(document).on("click","#listContent",function(e){
        	location.href="/board/get?b_no="+$(this).attr("b_no");
        })

        //일간,월간,주간 버튼 이벤트
        $("#todayBestBtn").click(function(){
        	todayBest();
        })
        $("#weekBestBtn").click(function(){
			weekBest();
        })
        $("#monthBestBtn").click(function(){
			monthBest();
        })

       	//진탁) 0603 유저 공지사항, 최신 게시물
		$.ajax({
			url:"/userNotice",
			type:"GET",
			success:function(result){
				var adminNoitce = JSON.parse(result);
				$.each(adminNoitce, function(idx, notice){
					var date = moment(notice.b_date).format("YYYY-MM-DD");
					var type = "";
					if(notice.c_no == 10001){
						type = "일반"
					}
					if(notice.c_no == 10002){
						type = "징계/정책"
					}
					if(notice.c_no == 10003){
						type = "업데이트"
					}
					if(notice.c_no == 10004){
						type = "이벤트"
					}
					var tr = $("<tr class='noticeList' b_no="+notice.b_no+"></tr>");
					var td1 = $("<td></td>").html(type);
					var td2 = $("<td></td>").html(notice.b_title);
					var td3 = $("<td></td>").html(date);

					tr.append(td1,td2,td3);
					$("#userNotice").append(tr);
				})
			}
		})

		//공지사항 게시물 클릭이벤트 
		$(document).on("click",".noticeList",function(e){
			var b_no = $(this).attr("b_no");
			self.location = "/board/get?b_no="+b_no;
		})

		//진탁 0603) 새로올라온 글 메인페이지용
		$.ajax({
			url:"/mainNewBoard",
			type:"GET",
			success:function(result){
				var boardList = JSON.parse(result);
				$.each(boardList, function(idx, board){
					var date = moment(board.b_date).format("YYYY-MM-DD");
					var tr = $("<tr class='newBoardList' b_no="+board.b_no+"></tr>");
					var td1 = $("<td></td>").html(board.c_dist);
					var td2 = $("<td></td>").html(board.b_title);
					var td3 = $("<td></td>").html(board.m_nick);
					var td4 = $("<td></td>").html(date);

					tr.append(td1,td2,td3,td4);
					$("#newBoard").append(tr);
				})
			}
		})
		
		//새글 게시물 클릭이벤트 
		$(document).on("click",".newBoardList",function(e){
			var b_no = $(this).attr("b_no");
			self.location = "/board/get?b_no="+b_no;
		})
		
		/*최신 굿즈 게시물*/
		$.ajax("/mainNewGoods", {success: function(goodsList){
			var goodsList = JSON.parse(goodsList);
			$.each(goodsList, function(idx, item){
				console.log(g);
				var g = item;
				
				var div = $("<div class='goodsBox mb-2'></div>");
				
				var con = g.g_content;
				var img;

				var imgDiv = $("<div class='imgDiv'></div>").attr("display", "inline-block");
				
				if(con.indexOf("<img src=") != -1){
					img = $(con.substring(con.indexOf("<img src="), con.indexOf("style"))+"></img>").addClass("rounded goodsImg");
				}else{
					img = $("<img src='/img/no_image.png' class='rounded goodsImg'></img>");
				}

				var contentDiv = $("<div class='conDiv'></div>").attr("display", "inline-block");
				var gc_dist = $("<small class='text-muted'></small>");
				if(g.gc_code == 1)
					gc_dist.html("[팝니다] ");
				else
					gc_dist.html("[삽니다] ");
				
				var title = $("<b></b>").html(g.g_title);
				var writer = $("<p></p>").html(g.m_nick);
				var content = $("<p></p>").html(g.g_content.replace(/(<([^>]+)>)/ig,""));
				var g_date = moment(g.g_updatedate).format('YYYY-MM-DD HH:mm:ss');
				var date = $("<span></span>").html(g_date);
				//var replyCnt = $("<span class='badge badge-light'></span>").html(g.g_replycnt);
				
				var a = $("<a></a>").attr("href","/goods/get?g_no="+g.g_no).append(title);
				contentDiv.append(gc_dist, a, "&nbsp;", writer, content, date);
				imgDiv.append(img);
				var li = $("<li></li>").append(imgDiv, contentDiv);
				div.append(li);
				$("#goodsList").append(div);
			});
			
		}});

		/*투표*/
		// 아름) 06/03 추가
		//진행중인 투표 목록
		var topicList = function(){
			$.ajax("/vote/list", {success: function(list){
				//console.log(list);
				if(list.length < 1){
					var text = $("<div></div>").html("현재 진행중인 투표가 없습니다.");
					$("#voteBox").append(text);
				}
				var list = JSON.parse(list);
				$.each(list, function(idx, v){
					if(idx > 0){
						return false;
					}
					
					var radiusContainer = $('<div class="radiusContainer" style="width: 100%; height: 150px; display: inline-block; background: white; position: relative; border-radius: 30px; overflow: hidden; margin: 5px 0px 5px 0px;"></div>').attr("idx", idx);
					var textBox = $('<div style="width: inherit; height: 150px; position: absolute; display: table; z-index: 10; color: white; text-shadow: 2px 2px 5px black;"></div>');
					var text = $('<div style="display:table-cell; text-align:center; vertical-align:middle;"><h2 id="timeText'+idx+'" style="display: inline-block; text-align: center;"></h2></div>');
					var imglocBox = $('<div id="picDiv" style="width: 110%; height: 150px; margin-left: -5%; display: inline-block; text-align: center;"></div>');
					var divA = $('<div class="divA" style="position:relative; width: 50%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var divB = $('<div class="divB" style="position:relative; width: 50%; height: 150px; transform: skew(15deg); display: inline-block; overflow: hidden;"></div>');
					var imgA = $('<img src="/img/vote/'+v.vt_img_a+'" style="width: 100%; margin-right: 30%; margin-top: -30%; opacity: 0.6;">');
					var imgB = $('<img src="/img/vote/'+v.vt_img_b+'" style="width: 100%; margin-right: 30%; margin-top: -30%; opacity: 0.6;">');

					divA.append(imgA);
					divB.append(imgB);
					imglocBox.append(divA, divB);
					textBox.append(text);
					radiusContainer.append(textBox, imglocBox);

					
					var mainDiv = $('<div></div>').attr("index", idx);
					var sudDiv = $("<div></div>").append(radiusContainer);

					mainDiv.append(sudDiv);
					$("#voteBox").append(mainDiv);

					start_timer(v.vt_end, idx);

				});
			}});
		}

    var remainInterval;

	var start_timer = function(endTime, idx){
		remainInterval = setInterval( function(){ remainTime(endTime, idx); }, 1000 );
	}

	var remainTime = function(endTime, idx){
		var start = new Date().getTime();
		var end = new Date(endTime).getTime();
		var remain = end - start;
		
		var hours = Math.floor(remain / (1000*60*60));
		var min = Math.floor((remain / (1000 * 60 )) % 60 );
		var sec = Math.floor((remain / 1000) % 60);

		if(hours < 10){ hours = "0" + hours }
		if(min < 10){ min = "0" + min }
		if(sec < 10){ sec = "0" + sec }

		var text_time = hours + " : " + min + " : " + sec;

		$("#timeText"+idx).html(text_time);
		
		if(remain < 0){
			clearInterval(remainInterval);
			$.ajax({
				type: "POST",
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache: false, 
	            url: "/vote/updateState",
				data: {vt_no: trList[idx].vt_no},
				success: function(re){
					if(re > 0){
						self.location = "/vote/vote";							
					}
				}
			});
		}else{
			remain = remain - 1000;
		}
	}
	
	topicList();

	$("#voteBox").hover(function(){
		$(this).children("div").addClass("hoverVote");
	}, function(){
		$(this).children("div").removeClass("hoverVote");
	});
        
	

	//진탁) 06.04 인기 카테고리 작업 
	$.ajax({
		url:"/popCategory",
		type:"GET",
		success:function(result){
			var categoryList = JSON.parse(result);
			$.each(categoryList,function(idx,category){
				if(idx>4){
					return false;	
				}
				var div = $("<div class='line'></div>").html(idx+1+"위  "+category.c_dist);
				$(".animated-text").append(div);
			})
		}
	})

	});
</script>
		<!-- 이미지 슬라이드 -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
            	<% int idx = 0; %>
            	<c:forEach var="l" items="${ slideImageList }">
            		<li data-target="#carouselExampleIndicators" data-slide-to="<%= idx %>" class="indicators"></li>
            		<% idx += 1; %>
            	</c:forEach>
            </ol>
            <div class="carousel-inner">
            <c:forEach var="s" items="${ slideImageList }">
            	<div class="carousel-item">
	                <img class="d-block w-100" src="/img/${ s.s_img }">
	                <div class="carousel-caption d-none d-md-block">
	                    <h5>${ s.s_title }</h5>
	                    <p>${ s.s_text }</p>
	                </div>
	            </div>
            </c:forEach>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- end 이미지 슬라이드 -->
        <hr>
        <div class="row">
            <!--left content-->
            <!--인기글 일간,주간,월간-->
            <div class="col-sm-5">
            	<div>
            		<h3>Ae?-Ho! 인기글</h3>
	                <p>
	                    <button id="todayBestBtn" type="button" class="btn btn-light">today</button>
	                    <button id="weekBestBtn" type="button" class="btn btn-light">week</button>
	                    <button id="monthBestBtn" type="button" class="btn btn-light">month</button>
	                </p>
		            <div class="mainContent">
		                <div id="bestContent">
	
		                </div>
            		</div>
            		
            	</div>
            	<br>
                <hr>
                <br>
                <div>    
	                <h3> Ae?-Ho! 추천 영상</h3>
	                <div id="iframe">
	                    
	                </div>
	                <br>
	                <hr>
	                <br>
	                <h4> Ae?-Ho! 실시간 인기 카테고리!</h4>
	                <div class="mainContent">
	                	<div style="width: 100%;height: auto">
						    <div class="animated-text">
						    
						    </div>  
					    </div>        	
	                </div>
	                <br>
                </div>
            </div>
            <!--right content-->
            <div class="col-sm-7">
            	<!-- 새로 올라온글 -->
            	<div>
            		<h3>새로운 Ae-Ho Content!</h3>
            		<div class="mainContent">			        	
	           			<table class="table table-hover">
					        <thead>
					            <tr align="center">
					                <th width="20%">카테고리</th>
					                <th width="40%">제목</th>
					                <th width="15%">작성자</th>
					                <th width="20%">게시날짜</th>
					            </tr>
					        </thead>
					        <tbody id="newBoard" align="center">
					        
					        </tbody>
					    </table>
            		</div>

            	</div>
            	<br>
            	<hr>
            	<br>
            	<!-- 새로 올라온 굿즈글 -->
            	<div>
            		<h3>새로운 Ae-Ho품!</h3>
            		<div class="mainContent" id="goodsDiv" align="center">
						<ul id="goodsList" class="mt-5">
							
						</ul>
					</div>
            	</div>
            	<br>
            	<hr>
            	<br>
            	<!-- 유저 공지사항 -->
                <div>
                	<h4>Ae-Ho 공지사항!</h4>
                	<br>
                	<div class="mainContent">
		                <table class="table table-hover">
					        <thead>
					            <tr align="center">
					                <th width="20%">분류</th>
					                <th width="40%">제목</th>
					                <th width="20%">날짜</th>
					            </tr>
					        </thead>
					        <tbody id="userNotice" align="center">
					        
					        </tbody>
					    </table>
						
					</div>
					<a class="float-right" href="/main/notice?categoryNum=10000">더보기</a>
                </div>
                <br>
            	<hr>
            	<br>
            </div>
        </div>
        
        <div class="row">
        	<div class="col-lg-12"> 
        		<h4>Ae-Ho's PICK!</h4>
        		<div align="center">
        			<div id="voteBox" onclick="location.href='/vote/vote'" title="지금 투표하러 가기"></div>
        		</div>
        	</div>
        </div>

<%@include file="../includes/footer.jsp"%>
