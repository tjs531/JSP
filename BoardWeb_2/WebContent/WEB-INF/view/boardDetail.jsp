<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "com.koreait.board.vo.BoardVo" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<style>
	table { border:1px solid black; border-collapse : collapse; width: 400px;}
	th {border: 1px solid black; width: 100px;}
	td {border: 1px solid black; width: 400px;}</style>
</head>
<body>
	<div><button onclick="doDel(${data.i_board})">삭제</button></div>
	<table>
	
	<tr class="number">
	<th>글번호: </th>
	<th>${data.i_board }</th>
	<tr class= "title">
	<th>제목 :</th>
	<td> ${data.title}</td>		<!--EL표현식 : 4개의 내장객체에 setAttribute로 담긴 것만 쓸 수 있다.
									(페이지컨텍스트->리퀘스트->세션->어플리케이션 순으로 탐색. 
									만약 페이지에 담긴게 없으면 리퀘스트 탐색.. 또 없으면 세션 탐색..
									모두 값이 없으면 null이 아니라 아예 값이 안찍힌다(편함!)) 
									getAttribute로 안받아줘도 됨.-->
	</tr>
	<tr class="student">
	<th>작성자</th>
	<td> ${data.i_student}</td>
	</tr>
	<tr class="content">
	<th>내용</th>
	<td> ${data.ctnt}</td>
	</table>

	<script>
		function doDel(i_board){
			if(confirm('삭제하시겠습니까?')){
				location.href='/boardDel?i_board=' + i_board
			}			
		}
	</script>
</body>
</html>