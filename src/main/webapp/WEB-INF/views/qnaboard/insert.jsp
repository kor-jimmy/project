<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>

	<h2>QNA 등록</h2>
	
	<form id="insertForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="qb_no" value="${ qb_no }" name="qb_no">
	<table class="table table-bordered">
			
		<tr>
			<td>카테고리</td>
			<td><input type="hidden" id="c_no" name="c_no" readonly="readonly" value="${cv.c_no }">${cv.c_dist}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" id="qb_title" name="qb_title" required="required" style="width:40%;"></td>
		</tr>
				
		<tr>
			<td>작성자</td> 
			<td><input type="text" id="m_id" name="m_id" value="<sec:authentication property="principal.username"/>" required="required" readonly="readonly"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea class="text_content" id="qb_content" name="qb_content" row="30%" cols="100%"></textarea></td>
		</tr>
	</table>
	<button type="submit" id="insertBtn" class="btn btn-outline-dark">등록</button>
	<button type="reset" id="resetBtn" class="btn btn-outline-dark">취소</button>
	</form>
	<script type="text/javascript">
		$(function(){
			var fileList=[];
			var uploadFileList=[];
			var imgCheck = new RegExp("^(image)/(.*?)");
			var maxSize= 10485760;
			
			$("#qb_content").summernote({
				disableDragAndDrop : true,
				height: 700,
				minHeight:null,
				maxHeight:null,
				focus:true,
				lang:"ko-KR",
				placeholder:"본문 내용을 입력해주세요.",
				toolbar: [
				    ['style', ['style']],
				    ['font', ['fontsize','bold', 'italic', 'underline', 'clear']],
				    ['color', ['color']],
				    ['insert', ['picture','video']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['table', ['table']]
				    
				 ],
				callbacks:{
					onImageUpload : function(files){
						console.log(files);
						$.each(files, function(idx, file){
							uploadSummernoteImageFile(file, $("#qb_content"));
							console.log(file);
						});
					}	
				}
			})
			//파일처리
			function uploadSummernoteImageFile(file,editor){
				data=new FormData();
				data.append("file",file);
				console.log(file);

				if(!imgCheck.test(file.type)){
					alert("이미지 파일만 업로드해주세요");
					return false;
				}
				if(file.size>maxSize){
					alert("파일 용량이 너무 큽니다.");
					return false;
				}

				$.ajax({
					data: data,
					type: "POST",
					url: "/qnaboard/testUpload",
					contentType: false,
					processData: false,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)
					},
					success: function(data){
						$(editor).summernote('insertImage', data.url);
						fileList.push(data);
						console.log(fileList);
					}
				});
			}
		
			//시큐리티
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			console.log("토큰 : "+token+" / 헤더:"+header);

			$("#insertBtn").on("click",function(e){
				if($("#qb_title").val() == null || $("#qb_title").val() == "" || 
						$("#qb_content").val() == null || $("#qb_content").val() == ""){
					alert("제목이나 글 내용을 비워둘 수는 없습니다.");
					return;
				}
//				console.log("클릭동작")
				e.preventDefault();
				var myInsert = $("#insertForm").serialize();
				var date = new Date();
				var year = date.getYear()+1900;
				var month = date.getMonth()+1;
				if( month < 10 ) {
					month = "0"+month;
				}
				$.ajax({
					url: "/qnaboard/insert",
					data:myInsert,
					type: "POST",
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)
					},
					cache: false,
					success: function(qnaBoardNum){
						if(qnaBoardNum > 0){
							$.each(fileList,function(idx,f){
								var url = f.url;
								var src = url.substring(12);
								var myUpload = {
										uuid : src.split("_")[0],
										filename: src.split("_")[1],
										qb_no: qnaBoardNum,
										uploadpath: "C\\\aehoUpload\\qnaboard\\"+year+"\\"+month+"\\"
								}
								uploadFileList.push(myUpload)
							})
							console.log(uploadFileList);
							$.ajax({
								url:"/qnaboard/fileDBupload",
								data: JSON.stringify(uploadFileList),
								dataType: "json",
								contentType: "application/json; charset=utf-8",
								type: "POST",
								beforeSend: function(xhr){
									xhr.setRequestHeader(header,token)
								},
								cache: false,
								success: function(msg){
									location.href="/qnaboard/get?qb_no="+qnaBoardNum;
								}
							})
						}
						location.href="/qnaboard/get?qb_no="+qnaBoardNum;	//success그만하자
					}
				})
			})
		})
	</script>
	<%@include file="../includes/footer.jsp"%>