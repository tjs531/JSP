<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>																	<!-- 입력받는 창, 처리하는 창 따로 분리해서 만드는 것이 좋다. 하나의 메소드는 하나의 역할만! -->
		<form action="/jsp/boardWriteProc.jsp" method="post">				<!-- post로 보내면 주소창에 정보가 나타나지 않고 정보를 캡슐화 해서 전달. (주소창에는 /jsp/boardWriteProc.jsp 까지만 나타남-->
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
</body>
</html>