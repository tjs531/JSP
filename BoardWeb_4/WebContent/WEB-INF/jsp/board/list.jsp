<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.koreait.pjt.vo.BoardVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
<style>
	.container {text-align:center;}
	.head {margin-bottom:20px;}
	#name {font-weight:bold;}
	a {text-decoration:none;}
	#logout { color:red; font-size:0.8em;}
	table {border-collapse: collapse; text-align:center; width:1000px; margin: 0 auto; margin-bottom:10px;}
	table th, td{border:1px solid #ccc; height: 30px;}
	th {background-color:#DBC9EC;}
	.itemRow:hover {cursor : pointer; background-color:#F0E9F7;}
	#list h1 {display: inline-block; margin-left:340px; margin:30px auto; padding-left : 350px;}
	#btn {width:100px; height:30px; margin-bottom: 20px; margin-top:15px; margin-left: 850px; border-radius: 20px; border:none; background-color:#DBC9EC;}
	#btn:hover {cursor:pointer;}
	#page {font-size:1.2em;}
	#c_page {color:red; pointer-events: none; font-weight:bold; font-size:1.2em}
	#selFrm {margin-bottom: 20px; display: inline-block; margin-left: 200px;}
	#search {margin-left : 170px;display:inline-block;}
	#searchText {width:200px;}
	#selectFrm {display:inline-block;}
	.fontCenter {margin-left: 440px; margin-top:20px;}
</style>
</head>
<body>
	<div class="container">
		<div class="head"><span id="name">${loginUser.nm}</span>님 환영합니다! 
		<a href="/profile">프로필</a>
		<a href="/logout" id="logout">로그아웃</a></div>
		
		<div id="list"><h1>💃어서오십쇼🤸‍♀️</h1> 
	
			<form id="selFrm" action="/board/list" method="get">	<!-- param. : request.getParameter()을 줄여서 표현한 것. (request.getParameter("page")  =  param.page) -->
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="searchText" value=${param.searchText }>
		
				<div>
				레코드 수:
				<select id="selectFrm" name="record_cnt" onchange="changeRecord()">
					<c:forEach begin="10" end="30" step="10" var="item">
						<c:choose>
							<c:when test="${param.record_cnt == item }">
								<option value="${item }" selected>${item}개</option>
							</c:when>
							<c:otherwise>
								<option value="${item }">${item}개</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				</div>
			</form>
		</div>

		<!--  <a href="/board/regmod">글쓰기</a>			<!-- '/board/reg'는 기본주소(localhost:8089) 바로 뒤에 붙는다. /를 빼고 'board/reg'만 쓰면 기존에 써있던 주소(ex> localhost:8089/board/list)의 맨 뒤만 바뀌게 된다.(localhost:8089/board/board/reg)-->	
		<div><input type="button" onclick="toregmod()" id="btn" value="글쓰기"></div>
			
		<table>
			<tr>
				<th class="i_board">번호📑</th>
				<th class="title">제목🔖</th>
				<th class="i_user">작성자🤸‍♂️</th>
				<th class="hits">👀</th>
				<th class="date">👍</th>
			<!-- 	<th class="date">작성일자</th>  -->
			</tr>
			<c:forEach items="${list}" var ="item">
			<tr class="itemRow" onclick="todetail(${item.i_board})">
				<td class="i_board">${item.i_board}</td>
				<td class="title">${item.title}	 	${item.c_cmt==0? '' : [item.c_cmt]}</td>
			<!-- <td>${item.i_user}</td> -->
				<td class="i_user">${item.nm }</td>	
				<td class="hits">${item.hits}</td>
				<td class="like">${item.c_like}</td>
			<!-- 	<td class="date">${item.r_dt}</td> -->
			</tr>
			</c:forEach>
		</table>
		
		
		<div class="fontCenter">
			<c:forEach var="i" begin="1" end="${pagingCnt }">
				<span><a href="/board/list?page=${i}&record_cnt=${param.record_cnt}&searchText=${param.searchText}" id="${i==page ? 'c_page' : 'page'}" >${i}</a></span>
			</c:forEach>
			
			
			<div id="search">
			<form action="/board/list">
				<input id="searchText" type="search" name="searchText">
				<input type="hidden" name="record_cnt" value=${param.record_cnt }>
				<input type="submit" value="검색">
			</form>
		</div>
		</div>
	</div>
	
	<script>
	
		function click(){
			menu.style = 'color:red';
			
		}
		function todetail(i_board){
			location.href='/board/detail?i_board=' + i_board + '&page=${page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}';
		}
		
		function toregmod(){
			location.href="/board/regmod"
		}
		
		function changeRecord(){
			selFrm.submit();
		}
		
	</script>
</body>
</html>