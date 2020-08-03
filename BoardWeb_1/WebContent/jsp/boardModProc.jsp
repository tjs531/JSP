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
	String title = request.getParameter("title");					//모든 값은 String으로 넘어옴(값이 안넘어오면 null이 저장됨) -> 만약 value값이 int값이라면 일단 String으로 받고 형변환 해줘야 함.(단,문자가 섞여있거나 null일때 형변환 하면 에러터짐)
	String ctnt = request.getParameter("ctnt");						//여기서 넘어오는 title, ctnt등은 키값. value값이 String title, String ctnt에 저장됨. (key-value: 맵)
	String strI_student = request.getParameter("i_student");
	

	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = "UPDATE t_board SET title= ?, ctnt =? , i_student=? WHERE i_board = ?";		//Detail 화면으로 가려면 i_board 값을 보내야 하는데 여기서는 i_board값을 알 수 없음.
																																//(select로 따로 가져와야 하는데 쿼리문을 두개 써서 처리하면 여러명이 동시에 실행할 경우 문제 생길 수 있음.)
																																//쿼리문 하나로 처리할 수 있지만 그건 나중에.
																																//지금은 Detail로 못가니 list로 간다.
	int result = -1;
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);				
		ps.setNString(1,title);			
		ps.setNString(2,ctnt);	
		ps.setInt(3,Integer.parseInt(strI_student));
		ps.setInt(4,Integer.parseInt(strI_board));
		
		result = ps.executeUpdate();			//실행된 결과의 행의 갯수 (1이 넘어오면 잘된거고 0이 넘어오면 뭔가 잘못된 것)
		
	}catch(Exception e){
		e.printStackTrace();
	} finally {			
		if(ps!=null) { try{ ps.close(); }catch(Exception e){} }				
		if(con!=null) { try{ con.close(); }catch(Exception e){} }
	}
	
	int err=0;
	
	switch(result){
	case 1:
		response.sendRedirect("/jsp/boardDetail.jsp?i_board="+ strI_board);
		return;											
	case 0:												//넘어온 결과가 0개면
		err = 10;
		break;
	case -1:											//에러가 나면 원래 초기화 해준 -1값
		err = 20;
		break;
	}
	
	response.sendRedirect("/jsp/boardWrite.jsp?err=" + err);
	
%>

<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student: <%=strI_student %></div>