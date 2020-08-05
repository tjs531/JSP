<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.koreait.board.vo.BoardVo" %>
<%@ page import = "java.util.List" %>
<% 
	//String strI_board = request.getParameter("i_board");
	@SuppressWarnings("unchecked")
	List<BoardVo> list = (List)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>게시판 리스트
	<a href="/boardWrite"><button>글쓰기</button></a></div>
	<table>
	<tr>
		<th>No</th>
		<th>제목</th>
		<th>작성자</th>
	</tr>
	<% for(BoardVo i : list) { %>
		<tr>
			<td><%=i.getI_board()%></td>
			<td><%=i.getTitle() %></td>
			<td><%=i.getI_student() %></td>
		</tr>
	<% } %>
	</table>
</body>
</html>