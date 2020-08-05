<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
    
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
	String strI_board = request.getParameter("i_board");	
	String title = request.getParameter("title");					
	String ctnt = request.getParameter("ctnt");						
	String strI_student = request.getParameter("i_student");
	

	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = "UPDATE t_board SET title= ?, ctnt =? , i_student=? WHERE i_board = ?";		
																
	int result = -1;
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);				
		ps.setNString(1,title);			
		ps.setNString(2,ctnt);	
		ps.setInt(3,Integer.parseInt(strI_student));
		ps.setInt(4,Integer.parseInt(strI_board));
		
		result = ps.executeUpdate();			
		
	}catch(Exception e){
		e.printStackTrace();
	} finally {			
		if(ps!=null) { try{ ps.close(); } catch(Exception e){} }				
		if(con!=null) { try{ con.close(); } catch(Exception e){} }
	}
	
	int err=0;
	
	switch(result){
	case 1:
		response.sendRedirect("/jsp/boardDetail.jsp?i_board="+ strI_board);
		return;											
	case 0:												
		err = 10;
		break;
	case -1:											
		err = 20;
		break;
	}
	
	response.sendRedirect("/jsp/boardMod.jsp?err=" + err + "&i_board=" + strI_board);
	
%>

<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student: <%=strI_student %></div>