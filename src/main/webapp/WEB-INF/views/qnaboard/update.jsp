<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/header.jsp"%>
<link href="/resources/css/button.css" rel="stylesheet">
<style>
	.table{ background: rgba(255, 255, 255, 0.7); }
</style>

	<h2>QNA 수정</h2>
	<form id="updateForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="qb_no" name="qb_no" value="${qnaboard.qb_no}">
	<input type="hidden" id="c_no" name="c_no" value="${qnaboard.c_no}">
	<table class="table table-bordered">
		<tr>
			<td>QNA 제목</td>
			<td><input type="text" name="qb_title" required="required" value="${qnaboard.qb_title }"></td>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="m_id" readonly="readonly" value="${qnaboard.m_id }"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea id="qb_content" class="text_content" name="qb_content" rows="30%" cols="100%">${qnaboard.qb_content }</textarea></td>
		</tr>
	</table>
	<button type="submit" id="updateBtn" class="btn btn-outline-light">수정</button>
	</form>
	<script>
	//summernote 적용
	$(function(){
		var fileList = [];
		var uploadFileList = [];

		//시큐리티 csrf
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		//이미지 파일 유효성 검사
		var imgCheck = new RegExp("^(image)/(.*?)");
		var maxSize = 10485760;
		
		$("#qb_content").summernote({
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
					$.each(files,function(idx,file){
						uploadSummernoteImageFile(file,$("#qb_content"));
					})
				}	
			}
		})
		
		//파일
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
				url : "/qnaboard/testUpload",
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

		
		//클릭이벤트()
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
				url : "/qnaboard/update",
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token)	
				},
				cache:false,
				success : function(qnaBoardNum){
					console.log(qnaBoardNum);
					if(qnaBoardNum>0){
						$.each(fileList,function(idx,f){
							var url = f.url;
							var src = url.substring(12);
							var myUpload = {
								uuid : src.split("_")[0],
								filename : src.split("_")[1],
								qb_no : qnaBoardNum,
								uploadpath : "C:\\\aehoUpload\\qnaboard\\"
							}
							uploadFileList.push(myUpload)
						})
						console.log(uploadFileList);
						$.ajax({
							url : "/qnaboard/fileDBupload",
							data : JSON.stringify(uploadFileList),
							dataType : "json",
							contentType:"application/json; charset=utf-8",
							type: "POST",
							beforeSend: function(xhr){
								xhr.setRequestHeader(header,token)	
							},
							cache:false,
							success : function(msg){
								location.href="/qnaboard/get?qb_no="+qnaBoardNum;
							}
						})
					}
				}
			})
		})
	})
	</script>
<%@include file="../includes/footer.jsp"%>