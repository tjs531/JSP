<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
	integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
	crossorigin="anonymous">
<style>
.container {
	text-align: center;
}

.content {
	margin: 5px auto;
	width: 500px;
	line-height: 30px;
}

.container h1 {
	margin-top: 50px;
}

.menu {
	display: inline-block;
	margin-top: 10px;
	margin-left: 50px;
}

.menu form {
	display: inline-block;
}

a {
	text-decoration: none;
	color: grey;
	padding-left: 10px;
}

#tolist {
	margin-left: -50px;
}

#title {
	font-size: 1.8em;
	font-weight: bold;
	color: #DBC9EC;
	padding: 10px;
}

#ctnt {
	font-size: 1.1em;
	background-color: #F0E9F7;
	padding: 50px;
	border-radius: 20%;
}

.sub {
	font-size: 0.8em;
	color: grey;
}

#like {
	margin-left: 20px;
}

.pointerCursor {
	cursor: pointer;
}

.material-icons {
	color: #f5d1ca;
}

.likelist {
	
}

.like_hate_btn {
	list-style-type:none;
}
</style>
</head>
<body>
	<div class="container">
		<h1></h1>

		<div class="content">
			<div id="title">${vo.title}</div>
			<div class="sub">
				<div id="nm">작성자 : ${vo.nm}</div>
				<div id="m_dt">수정일시: ${vo.m_dt}</div>
				<div id="hits">조회수 : ${vo.hits}</div>
			</div>

		<!-- 	<div class="like_hate_btn"> -->
				<!--  <div class="pointerCursor" onclick="toggleLikeorHate(1)">-->
				<div class="pointerCursor" onclick="toggleLike(${vo.yn_like})">
					<c:if test="${vo.yn_like == 1}">
						<i class="fas fa-thumbs-up"></i>
					</c:if>
					<c:if test="${vo.yn_like == 0}">
						<i class="far fa-thumbs-up"></i>
					</c:if>
					${likelist.size() }
				</div>

		<!-- 	<div class="pointerCursor" onclick="toggleLikeorHate(2)">
					<c:if test="${vo.yn_hate == 1}">
						<i class="fas fa-thumbs-down"></i>
					</c:if>
					<c:if test="${vo.yn_hate == 0}">
						<i class="far fa-thumbs-down"></i>
					</c:if>
					${hatelist.size() }
				</div> -->	
		<!--  	</div>-->

			<div class="likelist">
				<c:forEach items="${likelist}" var="like">
					${like.nm}
				</c:forEach>
				<c:if test="${likelist.size() != 0}">
					님이 좋아합니다.
				</c:if>
			</div>
			<div id="ctnt">${vo.ctnt}</div>

		</div>
		<div class="menu">
			<a href="/board/list" id="tolist">리스트로</a>
			<c:if test="${loginUser.i_user == vo.i_user }">
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

		function submitDel(){
			if(confirm("삭제하시겠습니까?")){
				delFrm.submit();
			}
		}
		
		function submitMod(){
			modFrm.submit();
		}
		
		function toggleLike(yn_like){
			location.href="/board/toggleLike?i_board=${vo.i_board}&yn_like="+yn_like;
		}
		
		
/*		function toggleLikeorHate(loh){
			if(loh == 1){
				location.href="/board/toggleLike?i_board=${vo.i_board}&yn_like=${vo.yn_like}";
			}else{
				location.href="/board/toggleLike?i_board=${vo.i_board}&yn_hate=${vo.yn_hate}";
			}
		}*/
	</script>
</body>
</html>