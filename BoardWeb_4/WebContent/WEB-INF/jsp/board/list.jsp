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
	.container {text-align:center;}
	table {border-collapse: collapse; text-align:center; width:1000px; margin: 0 auto;}
	table th, td{border:1px solid black; height: 30px;}
	th {background-color:#f5d1ca;}
	.itemRow:hover {cursor : pointer; background-color:lightgrey;}
	#list {display: inline-block;}
	#btn {width:1000px; height:30px; margin-bottom: 10px; border-radius: 20px; border:none; background-color:#f5d1ca;}
</style>
</head>
<body>
	<div class="container">
	<div>${loginUser.nm}님 환영합니다! <a href="/logout" >로그아웃</a></div>
	
	<div id="list"><h1>리스트</h1> </div>
	<!--  <a href="/board/regmod">글쓰기</a>			<!-- '/board/reg'는 기본주소(localhost:8089) 바로 뒤에 붙는다. /를 빼고 'board/reg'만 쓰면 기존에 써있던 주소(ex> localhost:8089/board/list)의 맨 뒤만 바뀌게 된다.(localhost:8089/board/board/reg)-->
	<input type="button" onclick="toregmod()" id="btn" value="글쓰기">
		
	<table>
		<tr>
			<th class="i_board">번호</th>
			<th class="title">제목</th>
			<th class="hits">조회수</th>
			<th class="i_user">작성자</th>
			<th class="date">작성일자</th>
		</tr>
		<c:forEach items="${list}" var ="item">
		<tr class="itemRow" onclick="todetail(${item.i_board})">
			<td class="i_board">${item.i_board}</td>
			<td class="title">${item.title}</td>
			<td class="hits">${item.hits}</td>
		<!-- <td>${item.i_user}</td> -->
			<td class="i_user">${item.nm }</td>	
			<td calss="date">${item.r_dt}</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	
	<script>
		function todetail(i_board){
			location.href='/board/detail?i_board=' + i_board
		}
		
		function toregmod(){
			location.href="/board/regmod"
		}
		
	</script>
</body>
</html>