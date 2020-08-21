<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일</title>
<style>
	.container {text-align:center;}
	.content {margin: 30px;}
	table {border-collapse: collapse; width: 700px; margin:0 auto;}
	table th,td {border:1px solid black; height: 20px;}
	th {width:100px;}
	#tolist {margin: 50px;}
</style>
</head>
<body>
	<div class="container">
		<h1>디테일</h1>
		
		<div>
			
			<c:if test = "${loginUser.i_user == vo.i_user }">
				<a href="/board/regmod?i_board=${vo.i_board}">수정</a>
				<form id="delFrm" action="/board/del" method="post">
					<input type="hidden" name="i_board" value="${vo.i_board }">
					<a href="#" onclick="submitDel()">삭제</a>
					<!--  <input type="submit" value="삭제">-->
				</form>
				<!-- <a href="/board/del?i_board=${vo.i_board }">삭제</a> -->
			</c:if>
		</div>
	
		<div class="content">
			<table>			
				<tr>
				<th>제목 </th> 
				<td>${vo.title}</td>
				</tr>
				<tr>
				<th>작성자 </th> 
				<td>${vo.nm }</td>
				</tr>
				<tr>
				<th>작성일시</th> 
				<td>${vo.r_dt }</td>
				</tr>
				<tr>
				<th>수정일시</th>
				<td>${vo.m_dt}</td>
				</tr>
				<tr>
				<th>조회수</th>
				<td>${vo.hits}</td>
				</tr>
				<tr>
				<th>내용</th> 
				<td>${vo.ctnt }</td>
				</tr>
			</table>
			<a href="/board/list" id="tolist">리스트로</a>
		</div>
	</div>
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