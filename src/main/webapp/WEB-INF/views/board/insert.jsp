<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<h2>게시물 등록</h2>
<hr>
<form id="insertForm" action="/board/insert" method="post">
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
</table>
<button type="submit" id="insertBtn" class="btn btn-outline-dark">게시물 등록</button>
<button type="reset" id="resetBtn" class="btn btn-outline-dark">리셋</button>
</form>
<script type="text/javascript">
	var oEditors = [];
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "b_content",
			sSkinURI: "/resources/editor/SmartEditor2Skin.html",
			htParams:{
				//툴바 사용여뷰
				bUseToolbar:true,
				//입력창 크기 조절바 사용 여부
				bUseVerticalResizer:false,
				//모드탭 html,text등 사용여부
				bUseModeChanger:false,
				//실행전 설정내용
				fOnBeforeunolad:function(){
				}
			},fOnAppLoad:function(){
				var content = "본문을 입력하세요"
				oEditors.getById["b_content"].exec("PASTE_HTML",[content]);
			},
			fCreator: "createSEditor2"
		});

		//저장버튼 클릭시 form 전송
	     $("#insertBtn").click(function(){
	         oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
	         $("#insertForm").submit();
	     });    
	})
</script>
<%@include file="../includes/footer.jsp"%>
