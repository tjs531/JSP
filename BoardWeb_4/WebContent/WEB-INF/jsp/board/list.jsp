<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.koreait.pjt.vo.BoardVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
	table {border-collapse: collapse; text-align:center;}
	table th, td{border:1px solid black; width:100px;}
	.itemRow:hover {cursor : pointer; background-color:lightgrey;}
</style>
</head>
<body>
	<div>${loginUser.nm}님 환영합니다!</div>
	<div>
		<a href="/board/regmod">글쓰기</a>			<!-- '/board/reg'는 기본주소(localhost:8089) 바로 뒤에 붙는다. /를 빼고 'board/reg'만 쓰면 기존에 써있던 주소(ex> localhost:8089/board/list)의 맨 뒤만 바뀌게 된다.(localhost:8089/board/board/reg)-->
		<a href="/logout" >로그아웃</a>
	</div>
	<h1>리스트</h1>
	
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>작성일자</th>
		</tr>
		<c:forEach items="${list}" var ="item">
		<tr class="itemRow" onclick="todetail(${item.i_board})">
			<td>${item.i_board}</td>
			<td>${item.title}</td>
			<td>${item.hits}</td>
		<!-- <td>${item.i_user}</td> -->
			<td>${item.nm }</td>	
			<td>${item.r_dt}</td>
		</tr>
		</c:forEach>
	</table>
	
	<script>
		function todetail(i_board){
			location.href='/board/detail?i_board=' + i_board
		}
		
	</script>
</body>
</html>