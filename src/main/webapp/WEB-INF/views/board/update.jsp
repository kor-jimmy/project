<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<h2>게시물 수정</h2>
<hr>
<form id="updateForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="b_no" name="b_no" value="${board.b_no}">

<table class="table table-bordered">
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" required="required" style="width:40%;" value="${board.b_title}"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="m_id" style="width:40%;" readonly="readonly" value="${board.m_id}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea class="text_content" id="b_content" name="b_content" rows="30%" cols="100%">${board.b_content}</textarea></td>
	</tr>
</table>
<button type="submit" id="updateBtn" class="btn btn-outline-dark">수정</button>
</form>
<script>
	$(function(){
		var fileList = [];
		var uploadFileList = [];

		//시큐리티 csrf
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		//이미지 파일 유효성 검사
		var imgCheck = new RegExp("^(image)/(.*?)");
		var maxSize = 10485760;
		
		$("#b_content").summernote({
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
					console.log(files)
					$.each(files,function(idx,file){
						uploadSummernoteImageFile(file,$("#b_content"));
					})
				}	
			}
		})

				//파일처리
		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			console.log(file);
			//이미지 파일인지에 대한 유효성 검사.
			if(!imgCheck.test(file.type)){
				alert("이미지 파일만 업로드 해주세요! ^3^");
				return false;
			}
			//이미지 파일 최대 용량에 대한 유효성 검사 최대 10mb로 제한
			if(file.size>maxSize){
				alert("파일의 용량이 너무 큽니다... -ㅅ-!");
				return false;
			}
			
			$.ajax({
				data : data,
				type : "POST",
				url : "/board/testUpload",
				contentType : false,
				processData : false,
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache:false,
				success : function(data) {
	            	//항상 업로드된 파일의 url이 있어야 한다.
					$(editor).summernote('insertImage', data.url);
					//리스트에 담기.
					fileList.push(data);
					console.log(fileList);
				}
			});
		}

		//폼태그 기본속성 제거
		$("#updateBtn").on("click",function(e){
			e.preventDefault();
			var myInsert = $("#updateForm").serialize();
			var date = new Date();
			var year = date.getYear()+1900;
			var month = date.getMonth()+1;
			if( month < 10 ) {
				month = "0"+month;
			}
			$.ajax({
				data : myInsert,
				type : "POST",
				url : "/board/update",
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache:false,
				success : function(boardNum){
					console.log(boardNum);
					if(boardNum>0){
						$.each(fileList,function(idx,f){
							var url = f.url;
							var src = url.substring(12);
							var myUpload = {
								uuid : src.split("_")[0],
								filename : src.split("_")[1],
								b_no : boardNum,
								uploadpath : "C:\\\aehoUpload\\board\\"+year+"\\"+month+"\\"
							}
							uploadFileList.push(myUpload)
						})
						console.log(uploadFileList);
						$.ajax({
							url : "/board/fileDBupload",
							data : JSON.stringify(uploadFileList),
							dataType : "json",
							contentType:"application/json; charset=utf-8",
							type : "POST",
							beforeSend: function(xhr){
								xhr.setRequestHeader(header,token)	
							},
							cache:false,
							success : function(msg){
								location.href="/board/get?b_no="+boardNum;
							}
						})
					}
				}
			})
		})
	})

</script>

<%@include file="../includes/footer.jsp"%>