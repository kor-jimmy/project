<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<link href="/resources/css/button.css" rel="stylesheet">
<link href="/resources/css/boardTable.css" rel="stylesheet">
<link href="/resources/css/elements.css" rel="stylesheet">
	<h2>상품등록</h2>
	<br>
	<form id="insertForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="gccodeValue" value="${ gc_code }">
	<input type="hidden" id="m_id" name="m_id" value="<sec:authentication property="principal.username"/>">
	<table class="table table-bordered opacity-table">
		<tr>
			<td>장터 카테고리</td>
			<td><input type="hidden" id="c_no" name="c_no" readonly="readonly" value="${cv.c_no }">${cv.c_dist}</td>
		</tr>
		<tr>
			<td>상품 제목</td>
			<td><input type="text" id="g_title" name="g_title" required="required" style="width:40%;" maxlength="30"></td>
		</tr>
		<tr>
			<td>삽니다/팝니다</td>
			<td>
				<select id="gc_code" name="gc_code">
					<option value="0" disabled="disabled" selected="selected">=선택=</option>
					<option value="1">팝니다</option>
					<option value="2">삽니다</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="number" id="g_price" name="g_price" required="required"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td class="contents-padding" id="contentTd"><textarea class="text_content" id="g_content" name="g_content" rows="30%" cols="100%"></textarea></td>
		</tr>
	</table>
	<button type="submit" id="insertBtn" class="btn btn-outline-light mainBtn">등록</button>
	<button type="reset" id="resetBtn" class="btn btn-outline-light grayBtn">취소</button>
	</form>
	<script type="text/javascript">
		$(function(){
			var fileList=[];
			var uploadFileList=[];
			var imgCheck = new RegExp("^(image)/(.*?)");
			var maxSize= 10485760;

			$("#gc_code").val($("#gccodeValue").val());
			
			$("#g_content").summernote({
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
							uploadSummernoteImageFile(file, $("#g_content"));
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
					url: "/goods/testUpload",
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
				var gc_code = $("#gc_code option:selected").val();
				if($("#g_title").val() == null || $("#g_title").val() == "" || 
						$("#g_content").val() == null || $("#g_content").val() == "" || gc_code == "0"){
					alert("제목, 본문, 삽니다/팝니다 분류는 비워둘 수 없습니다.");
					return false;
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
					url: "/goods/insert",
					data:myInsert,
					type: "POST",
					beforeSend: function(xhr){
						xhr.setRequestHeader(header,token)
					},
					cache: false,
					success: function(goodsNum){
						if(goodsNum > 0){
							$.each(fileList,function(idx,f){
								var url = f.url;
								var src = url.substring(12);
								var myUpload = {
										uuid : src.substring(0, 36),
										filename : src.substring(37),
										g_no: goodsNum,
										uploadpath: "C\\\aehoUpload\\goods\\"
								}
								console.log(myUpload);
								uploadFileList.push(myUpload)
							})
							console.log(uploadFileList);
							$.ajax({
								url:"/goods/fileDBupload",
								data: JSON.stringify(uploadFileList),
								dataType: "json",
								contentType: "application/json; charset=utf-8",
								type: "POST",
								beforeSend: function(xhr){
									xhr.setRequestHeader(header,token)
								},
								cache: false,
								success: function(msg){
									location.href="/goods/get?g_no="+goodsNum;
								}
							})
						}
					}
				})
			})
		})
	</script>
	<%@include file="../includes/footer.jsp"%>