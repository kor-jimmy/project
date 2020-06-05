<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp"%>
<link href="/resources/css/button.css" rel="stylesheet">
<style>
	.table{ background: rgba(255, 255, 255, 0.7); }

</style>
<h2>게시물 등록</h2>
<hr>
<form id="insertForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="c_no" value="${c_no}">
<input type="hidden" name="m_id" id="m_id" value="<sec:authentication property="principal.username"/>">
<table class="table table-bordered">
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" id="b_title" required="required" style="width:40%;" maxlength="30"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea class="text_content" id="b_content" name="b_content" required="required" rows="30%" cols="100%"></textarea></td>
	</tr>
</table>
<button type="submit" id="insertBtn" class="btn btn-outline-dark">게시물 등록</button>
<button type="reset" id="resetBtn" class="btn btn-outline-dark">취소</button>
</form>

<script type="text/javascript">

	$(function(){
		var fileList = [];
		var uploadFileList = [];

		//이미지 파일 유효성 검사
		var imgCheck = new RegExp("^(image)/(.*?)");
		var maxSize = 10485760;

		
		//섬머노트
		$("#b_content").summernote({
			disableDragAndDrop : true,
			height: 700,
			minHeight:700,
			maxHeight:700,
			focus:true,
			lang:"ko-KR",
			placeholder:"Ae-Ho는 깨끗한 웹 서비스를 지향 합니다. 욕설 및 비방, 차별발언은 이용에 제한이 될 수 있습니다.",
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
						uploadSummernoteImageFile(file, $("#b_content"));
						console.log(file);
					});
				}	
			}
		})
		
		//파일처리
		function uploadSummernoteImageFile(files, editor) {
			data = new FormData();

			data.append("file", files);
			//이미지 파일인지에 대한 유효성 검사.
			if(!imgCheck.test(files.type)){
				alert("이미지 파일만 업로드 해주세요! ^3^");
				return false;
			}
			//이미지 파일 최대 용량에 대한 유효성 검사 최대 10mb로 제한
			if(files.size>maxSize){
				alert("파일의 용량이 너무 큽니다... -ㅅ-!");
				return false;
			}
			
			$.ajax({
				data : data,
				type : "POST",
				url : "/board/testUpload",
				contentType : false,
				processData : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader(header,token)
				},
				success : function(data) {
	            	//항상 업로드된 파일의 url이 있어야 한다.
					$(editor).summernote('insertImage', data.url);
					//리스트에 담기.
					fileList.push(data);
					console.log(fileList);
				}
			});
		}

		//시큐리티 csrf 
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		console.log(token)
		console.log(header)
		
		//폼태그 기본속성 제거
		$("#insertBtn").on("click",function(e){
			if($("#b_title").val() == null || $("#b_title").val() == "" || 
					$("#b_content").val() == null || $("#b_content").val() == ""){
				alert("제목이나 글 내용을 비워둘 수는 없습니다.");
				return;
			}
			e.preventDefault();
			var myInsert = $("#insertForm").serialize();
			var date = new Date();
			var year = date.getYear()+1900;
			var month = date.getMonth()+1;
			if( month < 10 ) {
				month = "0"+month;
			}	
			$.ajax({
				url : "/board/insert",
				data : myInsert,
				type : "POST",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header,token)
				},
				cache : false,
				success : function(boardNum){
					console.log(boardNum);
					if(boardNum>0){
						$.each(fileList,function(idx,f){
							var url = f.url;
							var src = url.substring(12);
							var myUpload = {
								uuid : src.substring(0, 36),
								filename : src.substring(37),
								b_no : boardNum,
								uploadpath : "C:\\\aehoUpload\\board\\"
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
							beforeSend : function(xhr){
								xhr.setRequestHeader(header,token)
							},
							cache : false,
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
