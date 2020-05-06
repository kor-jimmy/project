<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<style>
	.uploadResult {
		width:100%;
		background-color: gray;
	}
	.uploadResult ul{
		display:flex;
		flex-flow: row;
		justify-content: center;
		aling-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img{
		width:20px;
	}
</style>
<h2>게시물 등록</h2>
<hr>
<form id="insertForm" action="/board/insert" method="post" enctype="multipart/form-data">
<input type="hidden" name="c_no" value="${c_no}">
<table class="table table-bordered">
	<tr>
		<td>게시물 제목</td>
		<td><input type="text" name="b_title" required="required" style="width:40%;"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="m_id" style="width:40%;" readonly="readonly" value="tiger"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea class="text_content" id="b_content" name="b_content" rows="30%" cols="100%"></textarea></td>
	</tr>
	<tr>
		<td>이미지</td>
		<td>
			<div class="form-group uploadDiv">
				<input type="file" name="uploadFile" multiple="multiple">
			</div>
			<div class="uploadResult"></div>
		</td>
	</tr>
</table>
<button type="submit" id="insertBtn" class="btn btn-outline-dark">게시물 등록</button>
<button type="reset" id="resetBtn" class="btn btn-outline-dark">리셋</button>
</form>

<script type="text/javascript">

	$(function(){
		//섬머노트
		$("#b_content").summernote({
			height: 700,
			minHeight:null,
			maxHeight:null,
			focus:true,
			lang:"ko-KR",
			placeholder:"본문 내용을 입력해주세요.",
			callbacks:{
				onImageUpload : function(files){
					uploadSummernoteImageFile(files[0],this);
				}	
			}
		})
		//파일처리
		function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		console.log(data);
		$.ajax({
			data : data,
			type : "POST",
			url : "/board/testUpload",
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}


/* 	     //게시판 등록 폼태그 기본이벤트 제거
	     var formObj = $("form[role='form']");
	     $("button[type='submit']").on("click",function(e){
		     e.preventDefault();
		     console.log("submit clicked");
		 })   

		 //파일 관련 스크립트
		 var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		 var maxSize = 524880;
		 function checkExtension(fileName, fileSize){
			if(fileSize>=maxSize){
				alert("파일 용량이 초과하였습니다.");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다");
				return false;
			}
		 }

		 $("input[type='file']").change(function(e){
		 	var formData = new FormData();
		 	var inputFile = $("input[name='uploadFile']");
		 	var files = inputFile[0].files;

		 	for(var i=0; i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				url : "/board/insert",
				processData : false,
				data : formData,
				type: "POST",
				datType : "json",
				success: function(result){
					console.log(result);
					//showUploadResult(result);
				}
			})
		 }) */
	})
</script>
<%@include file="../includes/footer.jsp"%>
