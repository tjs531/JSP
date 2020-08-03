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
																	
	String title = request.getParameter("title");					//모든 값은 String으로 넘어옴(값이 안넘어오면 null이 저장됨) -> 만약 value값이 int값이라면 일단 String으로 받고 형변환 해줘야 함.(단,문자가 섞여있거나 null일때 형변환 하면 에러터짐)
	String ctnt = request.getParameter("ctnt");						//여기서 넘어오는 title, ctnt등은 키값. value값이 String title, String ctnt에 저장됨. (key-value: 맵)
	String strI_student = request.getParameter("i_student");
	
	//"".equals(title) : title이 null 이거나 빈칸이면.
	//서버에서도 체크해주고 자바스크립트에서도 체크해줘야한다.
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = "insert into t_board(i_board, title, ctnt, i_student) select nvl(max(i_board),0)+1,?,?,? from t_board";		//Detail 화면으로 가려면 i_board 값을 보내야 하는데 여기서는 i_board값을 알 수 없음.
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
		response.sendRedirect("/jsp/boardlist.jsp");
		return;											//result가 1이면 insert문이 잘 실행되었다는 뜻이므로 return해서 메소드 종료. (break면 switch만 종료됨)
														//break 해버리면 맨 아래 response.sendRedirect가 또 실행됨. 두번 실행되면 안됨.
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