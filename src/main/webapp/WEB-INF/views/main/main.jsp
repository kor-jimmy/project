<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<style>
    #carousel-inner img{
        width: 1100px;
        height: 300px;
    }
</style>
<script type="text/javascript">
	$(function(){
		$.ajax("http://192.168.0.35:5000/videos", 
			{dataType: "jsonp",
			jsonpCallback: "getVideos",
			success: function(data){
				var rand = Math.round(Math.random()*10);
				//<iframe width="560" height="315" src="https://www.youtube.com/embed/iDjQSdN_ig8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				d = data[rand]
				str = d.substr(d.lastIndexOf("=")+1);
				console.log(str);
				frame = $("<iframe width='350' height='250' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>").attr("src", "https://www.youtube.com/embed/"+str);
				$("#iframe").append(frame);
        }});
        
        $("#carouselExampleIndicators").carousel({
            interval:3000,
            pause:"hover",
            wrap: true
        })
	});
</script>

        <div class="row">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                  <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                </ol>
                <div class="carousel-inner">
                  <div class="carousel-item active">
                    <img class="d-block w-100" src="/img/slideBts.png">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>전 세계를 강타한 K-POP 열풍!</h5>
                        <p>방탄소년단</p>
                      </div>
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100" src="/img/slideTwice.png">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>CearUp!</h5>
                        <p>트와이스</p>
                      </div>
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100" src="/img/slidePeng.png">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>EBS 연습생</h5>
                        <p>자이언트 펭TV의 펭수!</p>
                      </div>
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100" src="/img/slideLol.png">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>라이엇</h5>
                        <p>리그오브레전드</p>
                      </div>
                  </div>
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
            <!--left content-->
            <div class="col-sm-4">
                <h2>About BTS</h2>
                <p>전 세계를 강타한 남조선의 아이돌!</p>
                <img src="/img/bts.jpg" class="img-fluid">
                <p>남조선이 자랑하는 8인의 인민 남자 집단!</p>
                <hr>
                <h3>사이드 메뉴</h3>
                <p>사이드 메뉴에서 여러 소식을 확인해 보세요!</p>
                <ul class="list-group">
                    <li class="list-group-item list-group-item-action"><a href="#">Ae-Ho 공지사항</a></li>
                    <li class="list-group-item list-group-item-action"><a href="#">이벤트</a></li>
                    <li class="list-group-item list-group-item-action"><a href="#">일정확인</a></li>
                </ul>
                <hr>
                <h3>오늘의 영상</h3>
                <div id="iframe">
                    
                </div>
            </div>
            <!--right content-->
            <div class="col-sm-8">
                <h2>ChearUp! Twice</h2>
                <p>열도를 강타한 9인조 인민 여자 동무 집단!</p>
                <img src="/img/twice.png" class="img-fluid">
                <hr>
                <!--오늘의 주요 소식-->
                <h2>오늘의 주요 소식!</h2>
                <p>[단독] 송가인 소속사, SBS 손잡고 트로트 오디션 론칭</p>
                <p>새로운 트로트 오디션이 탄생한다. 전국 트로트 인재들이 한자리에 모인다.</p>
                <div class="text-center">
                    <img src="/img/song.jpg" class="img-fluid rounde mb-3">
                </div>
                <p>27일 방송관계자에 따르면 SBS가 차세대 트로트 대형가수를 선발하는 오디션을 준비하고 있다. 50억대 엄청난 제작비를 들인 고퀄리티 트로트 오디션으로 알려져 있다.</p>
            </div>
        </div>

<%@include file="../includes/footer.jsp"%>
