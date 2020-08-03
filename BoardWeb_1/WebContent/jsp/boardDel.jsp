<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
    
<%!	

String m;
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
	String strI_board = request.getParameter("i_board");	

	int i_board = Integer.parseInt(strI_board);					

	String sql = "DELETE FROM t_board WHERE i_board = ?";		//자바에서 날리는 쿼리문은 auto commit.
	
	Connection con = null;
	PreparedStatement ps = null;
	
	int result=-1;
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);				
		ps.setInt(1,i_board);			
		
		result = ps.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	} finally {			
		if(ps!=null) { try{ ps.close(); }catch(Exception e){} }				
		if(con!=null) { try{ con.close(); }catch(Exception e){} }
	}
	
	System.out.println("result : " + result);
	
	switch(result){
		case -1:
			response.sendRedirect("/jsp/boardDetail.jsp?err=-1&i_board=" + i_board);			//결과를 띄우지 않고 바로 페이지 이동. 결과를 띄우고싶으면(alert 등..) javascript 이용해야함.
			break;
		case 0:
			response.sendRedirect("/jsp/boardDetail.jsp?err=0&i_board=" + i_board);				//쿼리 스트링에 빈칸 있으면 안됨!
			break;
		case 1:
			response.sendRedirect("/jsp/boardlist.jsp");
			break;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><%=result%>개의 값이 삭제되었습니다.</div>
</body>
</html>