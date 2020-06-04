<%@page import="com.aeho.demo.vo.QnaBoardVo"%>
<%@page import="java.security.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../includes/header.jsp"%>
<style>

	.table{ background: rgba(255, 255, 255, 0.7); }
	
	#insertBtn{ background: #A3A1FC; border: 1px solid #A3A1FC; color: white; border-radius: 10px; }
	#insertBtn:hover{ background: #CBCAFF; border: 1px solid #CBCAFF; }
	
	#resetBtn{ background: #c8ccd0; border: 1px solid #c8ccd0; color: white; border-radius: 10px; }
	#resetBtn:hover{ background: #e9ecef; border: 1px solid #e9ecef; }
</style>

	<h2>QNA 등록</h2>
	<form id="insertForm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="qb_no" value="${qb_no }" name="qb_no">
		<table class="table table-bordered">

		<tr>
		<td>카테고리</td>
		<td>
			<select name="c_no" id="c_no">
					<option value="11001" <c:if test="${c_no == 11001}">selected</c:if><c:if test="${qb_no != 0}">disabled="true"</c:if>>가입</option>
					<option value="11002" <c:if test="${c_no == 11002}">selected</c:if><c:if test="${qb_no != 0}">disabled="true"</c:if>>로그인</option>
					<option value="11003" <c:if test="${c_no == 11003}">selected</c:if><c:if test="${qb_no != 0}">disabled="true"</c:if>>신고/회원</option>
					<option value="11004" <c:if test="${c_no == 11004}">selected</c:if><c:if test="${qb_no != 0}">disabled="true"</c:if>>기타</option>
			</select>
		</td>
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
			
			<tbody>
				<c:forEach items="${list }" var="qnaboard">
					<tr>
						<td align="center"><c:out value="${qnaboard.qb_no }" /></td>
						<td align="center">
							<c:if test="${qnaboard.c_no == 11001}">가입 관련</c:if>
							<c:if test="${qnaboard.c_no == 11002}">로그인 관련</c:if>
							<c:if test="${qnaboard.c_no == 11003}">회원/신고 관련</c:if>
							<c:if test="${qnaboard.c_no == 11004}">기타문의</c:if>
						</td>
						<td>
							<a class="" href="/qnaboard/get?qb_no=${qnaboard.qb_no }">
								<c:out value="${qnaboard.qb_title }" />
							</a>
						</td>	
						<td align="center"><c:out value="${qnaboard.m_id }" /></td>
						<td align="center">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${qnaboard.qb_date }" />
						</td>
					</tr>
						</c:forEach>
					</tbody>
			
			
		</table>
		<button type="submit" id="insertBtn" class="btn btn-outline-light">등록</button>
		<button type="reset" id="resetBtn" class="btn btn-outline-light">취소</button>
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