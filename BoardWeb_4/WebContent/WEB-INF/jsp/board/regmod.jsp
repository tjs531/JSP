<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null? '등록':'수정' }</title>
</head>
<body>
	<div>
		<form id="frm" action="/board/regmod" method="post" onsubmit="return chk()">
			<input type="hidden" name="i_board" value="${vo.i_board }">
			<div>제목: <input type="text" name="title" value="${vo.title }" placeholder="제목쓰세요"></div>
			<div>내용: <textarea name="ctnt" placeholder="내용쓰세요">${vo.ctnt }</textarea></div>
			<div><input type="submit" value="등록"> <a href="/board/list">뒤로</a></div>	
		</form>
	</div>
	
	<script>
		function eleValid(ele, nm){
			if(ele.value.length == 0 ){
				alert(nm + '을(를) 입력해주세요');
				ele.focus();
				return true;
			}
			
		}
		
		function chk() {
			if(eleValid(frm.title,'제목')) {
				return false;
			}
			if(eleValid(frm.ctnt,'내용')){
				return false;
			}
			if(frm.title.value.length > 100){
				alert("제목 줄여")
				return false;
			}
			if(frm.ctnt.value.length > 2000){
				alert("내용 줄여")
				return false;
			}
		}
	</script>
</body>
</html>