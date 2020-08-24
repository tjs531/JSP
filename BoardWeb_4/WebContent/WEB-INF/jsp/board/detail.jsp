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
	.content {margin: 5px auto; width: 500px; line-height:30px; }
	.container h1 {margin-top:50px;}
	.menu {display: inline-block; margin-top:10px; margin-left:50px;}
	.menu form {display: inline-block;}
	a { text-decoration:none; color: grey; padding-left:10px;}
	#tolist {margin-left:-50px;}
	#title {font-size:1.8em; font-weight: bold; color:#f5d1ca; padding:10px;}
	#ctnt {font-size:1.1em; background-color:#F8F8F4; padding:50px; border-radius: 20%;}
	.sub {font-size:0.8em; color:grey;}
	#like {margin-left:20px;}
</style>
</head>
<body>
	<div class="container">
		<h1></h1>
		
		<div class="content">
		
			<div id="title">${vo.title}<span id="like"></span></div>
			<div class="sub">
			<div id="nm">작성자 : ${vo.nm}</div>
			<div id="m_dt">수정일시: ${vo.m_dt}</div>
			<div id="hits">조회수 : ${vo.hits}</div>
			</div>
			<div id="ctnt">${vo.ctnt}</div>
		
			</div>
			<div class="menu">
				<a href="/board/list" id="tolist">리스트로</a>
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
		
	</div>
	<script>
		var like = document.querySelector("#like");
		
		if( ${vo.yn_like} == 0 ){
			like.innerText = '💔';
		} else {
			like.innerText = '❤';
		}
		
		function submitDel(){
			if(confirm("삭제하시겠습니까?")){
				delFrm.submit();
			}
		}
		
		function submitMod(){
			modFrm.submit();
		}
		
		
	</script>
</body>
</html>