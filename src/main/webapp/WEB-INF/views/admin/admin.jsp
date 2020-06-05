<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%@include file="../admin/header.jsp"%>
    
    <style type="text/css">
	
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

    
    <script>
		$(function(){
			//URI 차트
			$.ajax({
				url:"/admin/listLog",
				type:"GET",
				success:function(result){
					var listLog = JSON.parse(result);
					//chart js 이용
					var ctx = document.getElementById("logChart").getContext("2d");
					var logChart = new Chart(ctx,{
						type:"bar",
						data : {
							labels : [listLog[0].log_uri,listLog[1].log_uri,listLog[2].log_uri,listLog[3].log_uri,listLog[4].log_uri],
							datasets : [{
								label: "URI 요청",
								data : [listLog[0].cnt,listLog[1].cnt,listLog[2].cnt,listLog[3].cnt,listLog[4].cnt],
								backgroundColor : [
									'rgba(255, 99, 132, 0.2)',
					                'rgba(54, 162, 235, 0.2)',
					                'rgba(255, 206, 86, 0.2)',
					                'rgba(75, 192, 192, 0.2)',
					                'rgba(153, 102, 255, 0.2)'
								],
								borderColor: [
					                'rgba(255, 99, 132, 1)',
					                'rgba(54, 162, 235, 1)',
					                'rgba(255, 206, 86, 1)',
					                'rgba(75, 192, 192, 1)',
					                'rgba(153, 102, 255, 1)',
					                'rgba(255, 159, 64, 1)'
					            ],
					            borderWidth: 1
							}]
						},
						options:{
							//차트 크기 고정하는거 
							responsive : false,
							scales:{
								yAxes:[{
									ticks:{
										beginAtZero:true
									}
								}]
							}
						}

					})
				}
			})

			//인기 카테고리
			$.ajax({
				url:"/admin/popCategory",
				type:"GET",
				success:function(result){
					var popCategoryList = JSON.parse(result);
					var ctx = document.getElementById("categoryChart").getContext("2d");
					var logChart = new Chart(ctx,{
						type:"bar",
						data : {
							labels : [popCategoryList[0].c_dist,popCategoryList[1].c_dist,popCategoryList[2].c_dist,popCategoryList[3].c_dist,popCategoryList[4].c_dist],
							datasets : [{
								label: "인기 카테고리(누적 게시물)",
								data : [popCategoryList[0].cnt,popCategoryList[1].cnt,popCategoryList[2].cnt,popCategoryList[3].cnt,popCategoryList[4].cnt],
								backgroundColor : [
									'rgba(255, 99, 132, 0.2)',
					                'rgba(54, 162, 235, 0.2)',
					                'rgba(255, 206, 86, 0.2)',
					                'rgba(75, 192, 192, 0.2)',
					                'rgba(153, 102, 255, 0.2)'
								],
								borderColor: [
					                'rgba(255, 99, 132, 1)',
					                'rgba(54, 162, 235, 1)',
					                'rgba(255, 206, 86, 1)',
					                'rgba(75, 192, 192, 1)',
					                'rgba(153, 102, 255, 1)',
					                'rgba(255, 159, 64, 1)'
					            ],
					            borderWidth: 1
							}]
						},
						options:{
							//차트 크기 고정하는거 
							responsive : false,
							scales:{
								yAxes:[{
									ticks:{
										beginAtZero:true
									}
								}]
							}
						}

					})
					
				}
			})
			
			var listWeeklyPicks = function(){
				$.ajax({
					url:"/admin/listWeeklyPicks",
					type:"GET",
					success:function(result){
						var listPick = JSON.parse(result);
						console.log(listPick);
						var canvas = $("<canvas id='searchChart' width='350' height='350'></canvas>");
						$("#serachPickDiv").append(canvas);
						var ctx = document.getElementById("searchChart");
						var doughnutChart = new Chart(ctx,{
							type: 'doughnut',
							data:  {
								labels : [listPick[0].p_keyword,listPick[1].p_keyword,listPick[2].p_keyword,listPick[3].p_keyword,listPick[4].p_keyword],
								datasets : [{
									label: "주간 인기검색어",
									data : [listPick[0].cnt,listPick[1].cnt,listPick[2].cnt,listPick[3].cnt,listPick[4].cnt],
									backgroundColor : [
										'rgba(255, 99, 132, 0.2)',
						                'rgba(54, 162, 235, 0.2)',
						                'rgba(255, 206, 86, 0.2)',
						                'rgba(75, 192, 192, 0.2)',
						                'rgba(153, 102, 255, 0.2)'
									],
									borderColor: [
						                'rgba(255, 99, 132, 1)',
						                'rgba(54, 162, 235, 1)',
						                'rgba(255, 206, 86, 1)',
						                'rgba(75, 192, 192, 1)',
						                'rgba(153, 102, 255, 1)',
						                'rgba(255, 159, 64, 1)'
						            ],
						            borderWidth: 1
								}]
							},
							options:{
								responsive : false
							}
						})
					}
				})
			}
			listWeeklyPicks();
			
			var listMonthlyPicks = function(){
				$.ajax({
					url:"/admin/listMonthlyPicks",
					type:"GET",
					success:function(result){
						var listPick = JSON.parse(result);
						console.log(listPick);
						var canvas = $("<canvas id='searchChart' width='350' height='350'></canvas>");
						$("#serachPickDiv").append(canvas);
						
						var ctx = document.getElementById("searchChart");
						
						var doughnutChart = new Chart(ctx,{
							type: 'doughnut',
							data:  {
								labels : [listPick[0].p_keyword,listPick[1].p_keyword,listPick[2].p_keyword,listPick[3].p_keyword,listPick[4].p_keyword],
								datasets : [{
									data : [listPick[0].cnt,listPick[1].cnt,listPick[2].cnt,listPick[3].cnt,listPick[4].cnt],
									backgroundColor : [
										'rgba(255, 99, 132, 0.2)',
						                'rgba(54, 162, 235, 0.2)',
						                'rgba(255, 206, 86, 0.2)',
						                'rgba(75, 192, 192, 0.2)',
						                'rgba(153, 102, 255, 0.2)'
									],
									borderColor: [
						                'rgba(255, 99, 132, 1)',
						                'rgba(54, 162, 235, 1)',
						                'rgba(255, 206, 86, 1)',
						                'rgba(75, 192, 192, 1)',
						                'rgba(153, 102, 255, 1)',
						                'rgba(255, 159, 64, 1)'
						            ],
						            borderWidth: 1
								}]
							},
							options:{
								responsive : false
							}
						})
					}
				})
			}

			$("#weekSearch").on("click",function(){
				$("#searchChart").remove();
				listWeeklyPicks();
			})
			$("#monthSearch").on("click",function(){
				$("#searchChart").remove();
				listMonthlyPicks();
			})

			//관리자 공지사항
			$.ajax({
				url:"/admin/adminNotice",
				type:"GET",
				success:function(result){
					var adminNoitce = JSON.parse(result);
					$.each(adminNoitce, function(idx, notice){
						var date = moment(notice.b_date).format("YYYY-MM-DD");
						var tr = $("<tr class='noticeList' b_no="+notice.b_no+"></tr>");
						var td1 = $("<td></td>").html(notice.b_no);
						var td2 = $("<td></td>").html(notice.b_title);
						var td3 = $("<td></td>").html(notice.m_id);
						var td4 = $("<td></td>").html(date);

						tr.append(td1,td2,td3,td4);
						$("#adminNotice").append(tr);
					})
				}
			})
			
			//유저 공지사항
			$.ajax({
				url:"/admin/userNotice",
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
						var td3 = $("<td></td>").html(notice.m_id);
						var td4 = $("<td></td>").html(date);

						tr.append(td1,td2,td3,td4);
						$("#userNotice").append(tr);
					})
				}
			})

			//공지사항 게시물 클릭이벤트 ==> 관리자 공지사항 상세페이지로 이동
			$(document).on("click",".noticeList",function(e){
				var b_no = $(this).attr("b_no");
				self.location = "/admin/notice/get?b_no="+b_no;
			})
			
		})
    </script>
    
          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <!-- <h1 class="h3 mb-0 text-gray-800">Dashboard</h1> -->
          </div>

          <!-- Cahrt 모음 -->

          <div class="row">
            <div class="col-lg-4">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary">요청별 상위 차트</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                	<canvas id="logChart" width="350" height="350"></canvas>
                </div>
              </div>
            </div>
            
            <div class="col-lg-4">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary">인기 검색어</h6>
                  	<div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <a class="dropdown-item" id="weekSearch" >주간</a>
                      <a class="dropdown-item" id="monthSearch">월간</a>
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card-body" id="serachPickDiv">
                	<!-- <canvas id="searchChart" width="300" height="300"></canvas> -->
                </div>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary">상위 카테고리</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                	<canvas id="categoryChart" width="350" height="350"></canvas>
                </div>
              </div>
            </div>
          </div>
          
         <div class="row">
         	<!-- 관리자 공지사항 -->
         	<div class="col-lg-6">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div
						class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">관리자 공지사항</h6>
					</div>
					<!-- Card Body -->
					<div class="card-body notice">
						   <table class="table table-hover">
					        <thead>
					            <tr align="center">
					                <th width="10%">번호</th>
					                <th width="40%">제목</th>
					                <th width="15%">작성자</th>
					                <th width="20%">날짜</th>
					            </tr>
					        </thead>
					        <tbody id="adminNotice" align="center">
					        	
					        </tbody>
					    </table>
					    <div>
					    	<a class="float-right" href="/admin/notice/notice?categoryNum=10010">더보기</a>
					    </div>
					</div>
				</div>
        	 </div>
        	 <!-- 유저 공지사항 -->
        	 <div class="col-lg-6">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div
						class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">유저 공지사항</h6>
					</div>
					<!-- Card Body -->
					<div class="card-body notice">
						   <table class="table table-hover">
					        <thead>
					            <tr align="center">
					                <th width="20%">분류</th>
					                <th width="40%">제목</th>
					                <th width="15%">작성자</th>
					                <th width="20%">날짜</th>
					            </tr>
					        </thead>
					        <tbody id="userNotice" align="center">
					        	
					        </tbody>
					    </table>
					    <div>
					    	<a class="float-right" href="/admin/notice/notice?categoryNum=10000">더보기</a>
					    </div>
					</div>
				</div>
        	 </div>
         </div>
      
      <%@include file="../admin/footer.jsp"%>
