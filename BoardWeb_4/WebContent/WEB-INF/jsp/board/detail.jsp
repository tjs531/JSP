<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일</title>
</head>
<body>
	<h1>디테일</h1>
	
	<div>
		<a href="/board/list">리스트로</a>
		<c:if test = "${loginUser.i_user == vo.i_user }">
			<!--  <form id="modFrm" action="/board/mod" method="post">
				<input type="hidden" name="i_board" value="${vo.i_board }">
				<input type="hidden" name="title" value="${vo.title }">
				<input type="hidden" name="ctnt" value="${vo.ctnt }">
				<input type="hidden" name="i_user" value="${vo.i_user }">
				<a href="#" onclick="submitMod()">수정</a>
			</form>-->
			
			<a href="/board/regmod?i_board=${vo.i_board}">수정</a>
			<form id="delFrm" action="/board/del" method="post">
				<input type="hidden" name="i_board" value="${vo.i_board }">
				<a href="#" onclick="submitDel()">삭제</a>
				<!--  <input type="submit" value="삭제">-->
			</form>
			<!-- <a href="/board/del?i_board=${vo.i_board }">삭제</a> -->
		</c:if>
	</div>

	<div>제목: ${vo.title}</div>
	<div>작성자: ${vo.nm }</div>
	<div>작성일시: ${vo.r_dt }</div>
	<div>조회수: ${vo.hits} </div>
	<div>내용: ${vo.ctnt }</div>
	
	<script>
		function submitDel(){
			delFrm.submit();
		}
		
		function submitMod(){
			modFrm.submit();
		}
	</script>
</body>
</html>