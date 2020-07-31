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
	//request.setCharacterEncoding("UTF-8");							//post방식에선 한글쓰면 깨져서 이거 써줘야 함.(톰캣에서 설정한 UTF-8은 get방식 설정). 이렇게 하면 매번 적어야해서 귀찮고 나중에 관리하기도 힘듦. 
																	//서버에서 설정하면 한번만 쓰면 됨. (Web.xml)
	String title = request.getParameter("title");					//모든 값은 String으로 넘어옴
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = "insert into t_board(i_board, title, ctnt, i_student) select nvl(max(i_board),0)+1,?,?,? from t_board";
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);				
		ps.setString(1,title);			
		ps.setString(2,ctnt);	
		ps.setString(3,strI_student);
		
		ps.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	} finally {			
		if(ps!=null) { try{ ps.close(); }catch(Exception e){} }				
		if(con!=null) { try{ con.close(); }catch(Exception e){} }
	}
	
	
%>

<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student: <%=strI_student %></div>