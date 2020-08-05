<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.koreait.hs.web.BoardVO" %>
<%!	
	public Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userName = "hr";
		String password = "koreait2020";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(url, userName, password);
		System.out.println("접속성공!");
		return con;
	}
%>
<%
	String msg="";
	String err = request.getParameter("err");
	if(err != null){
		switch(err){
		case "10":
			msg="등록할 수 없습니다.";
			break;
		case "20":
			msg="DB에러 발생";
			break;
		}
	}
%>
<%
	String strI_board = request.getParameter("i_board");	

	int i_board = Integer.parseInt(strI_board);					

	String sql = "SELECT title, ctnt, i_student FROM t_board where i_board = ?" ;
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	BoardVO vo = new BoardVO();
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);		
		ps.setInt(1,i_board);			
		
		rs = ps.executeQuery();		
		
		
		if(rs.next()){							
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");	
			int i_student = rs.getInt("i_student");
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
	}catch(Exception e){
		e.printStackTrace();
	} finally {	
		if(rs!=null) { try{ rs.close(); }catch(Exception e){} }				
		if(ps!=null) { try{ ps.close(); }catch(Exception e){} }				
		if(con!=null) { try{ con.close(); }catch(Exception e){} }
	}
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="msg"><%=msg %></div>
	<div>											
						
		<form id="frm" action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">		
			<input type="hidden" name="i_board" value="<%=i_board %>">      <!--form 태그 action안에 ?i_board=i_board 추가해줘도 되지만
																			주소창에 i_board를 띄우기 싫다면 이런 방법으로 보내도 된다.(form 태태그 아래에)-->
			<div><label>제목: <input type="text" name="title" value=<%=vo.getTitle()%> ></label></div>
			<div><label>내용: <textarea name="ctnt"><%=vo.getCtnt()%></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student" value = <%=vo.getI_student()%>></label></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
	
	<script>

		function eleValid(ele, nm){
			if(ele.value.length == 0 ){
				alert(nm + '을(를) 입력해주세요');
				ele.focus();
				return true;
			}
		}
		
		//자바스크립트에서 체크하는건 사용자 편의를 위해서. 서버에서도 따로 더블체크 해줘야 한다.
		function chk() {
			
			if(eleValid(frm.title,'제목')) {
				return false;
			}else if(eleValid(frm.ctnt,'내용')){
				return false;
			}else if(eleValid(frm.i_student,'작성자')){
				return false;
			}
			
		}
	</script>
</body>
</html>