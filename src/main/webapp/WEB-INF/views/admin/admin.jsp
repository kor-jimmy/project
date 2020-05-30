<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="../admin/header.jsp"%>
    
    <script>
		$(function(){

			$.ajax({
				url:"/admin/listLog",
				type:"GET",
				success:function(result){
					var listLog = JSON.parse(result);
					console.log(listLog);
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

		})
    </script>
    
          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <!-- <h1 class="h3 mb-0 text-gray-800">Dashboard</h1> -->
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- 신규 가입, 누적회원 출력.  당일 기준으로 가입한 회원 숫자 출력 -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">신규 가입 (누적회원)</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">100(1,000)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 신규 게시물. 당일 기준으로 등록된 게시글의 수를 출력.  -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">신규 게시물</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">100</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- QNA 금일 기준으로 등록된 QNA 숫자 출력 클릭시 QNA 목록으로. -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1"> QNA</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">10</div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 추후 무엇을 출력할지 정할것. -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">여기엔 뭘넣을까?</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

            <div class="col-lg-5">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary">요청별 상위 차트</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                	<canvas id="logChart" width="400" height="400"></canvas>
                </div>
              </div>
            </div>

          </div>
      
      <%@include file="../admin/footer.jsp"%>
