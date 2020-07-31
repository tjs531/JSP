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
	//finally에서 close해주려면 객체가 일단 생성되어 있어야 하기 때문에 객체들을 try 밖에 선언. (스코프 : 살아있는 범위(try catch밖)) 
	Connection con = null;						//DB연결
	PreparedStatement ps = null;				//쿼리문 실행(문장 완성 기능도 있다)
	ResultSet rs = null;						//select문의 결과를 담는다. (select때만 필요함)
	
	List<BoardVO> boardList = new ArrayList();
	
	
	String sql = " SELECT i_board, title FROM t_board ";			//쿼리문 양쪽에 빈칸 주는게 좋음.(쿼리문은 띄어쓰기 중요) 
																	//쿼리문 안에 ';'은  허용하면 안됨. 허용하면 인젝션 공격(쿼리문 삽입해서 공격) 가능해짐. ;붙이면 실행 안되게 만들어짐. 

	try {
		con = getCon();
		ps = con.prepareStatement(sql);				//쿼리문 연결해서 ps로.
		rs = ps.executeQuery();						//쿼리문 실행 select문만 무조건 executeQuery(); (리턴타입이 ResultSet이라서). 나머지 update, delete등등은 다른 메소드
		
		while(rs.next()) {							//rs: 커서(줄(DB테이블 튜플)을 가리키고 있음) , rs.next() 반환값은 boolean. 가리키고 있는 튜플에 값이 있다면 true
			int i_board = rs.getInt("i_board");		//getInt(int 형 컬럼명) 현재 가리키고 있는 레코드에서 가져오고 싶은 컬럼값 가져옴.(string을 받아와도 에러 안난다.(파싱해서))
			String title = rs.getNString("title");	//getNString(String 형 컬럼명) 얘는 string형 아닌거 가져오면 에러난다.
			
			BoardVO vo = new BoardVO();			//이 객체는 while문 안에 선언해야한다! (밖에 선언하면 여러줄은 되는데 다 같은값으로 나옴.(마지막 주소값만 저장))
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		}
	} catch(Exception e) {							//에러 상황을 분리해서 처리하고 싶으면 catch문 여러개 사용 가능. 
													//catch문을 여러개 쓰는 경우 Exception e를 제일 아래 써줘야 함.(에러를 다 잡아버려서 아래 있는 catch들은 무용지물.)
		e.printStackTrace();
	} finally {	
		if(rs!=null) { try{ rs.close(); }catch(Exception e){} }				//열때는 con->ps->rs순서, 닫을때는 반대로. 안닫아주면 리소스 많이 잡아먹어서 계속 쓰면 서버 죽음.
		if(ps!=null) { try{ ps.close(); }catch(Exception e){} }				//세개를 하나의 try로 감싸놓으면 rs나 ps가 에러나면 아래것도 안닫힘. 그래서 다 따로따로 줘야함.
		if(con!=null) { try{ con.close(); }catch(Exception e){} }
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<div>
	게시판 리스트
	<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		<% for(BoardVO vo : boardList) { %>
		<tr>
			<td><%=vo.getI_board() %></td>
			<td>
				<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()%>">			<!-- 원하는 데이터의 pk값을 보냄 -->
					<%=vo.getTitle() %>
				</a>
			</td>
		</tr>
		<% } %>
	</table>
</body>
</html>