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
	String strI_board = request.getParameter("i_board");			//boardlist에서 보내준 값 받기. (? 뒤에 있는 value값 가져오는 것. 만약 '...?i_board=3&title='value'' 을 보냈다면  title값도 받아올 수 있음.)
																	//but 굳이 여러개 받아올 필요 없다.(pk값 받아왔으니 됐다.)
																	//만약 넘어올 value값이 없다면 strI_board에 null 저장됨.
																	//request는 내장객체. 이 소스가 들어있는 클래스의 매개변수 중 request 객체가 있다. (들어오는 요청을 받는 매개변수)
																	//\workspace_web\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\ROOT\org\apache\jsp\jsp 에 있는 소스파일 참고.
																	//레퍼런스 변수 앞에 final이 있으면 주소값 고정(값은 바꿀 수 있음. 값을 고정하려면 그 안에 선언한 전역변수에 붙여줘야 함) ->속도가 빨라진다.
																	
	if(strI_board == null){										//만약에 i_board가 넘어오지 않으면 strI_board 값은 null이 됨.
																//strI_board 가 null 인 경우는 i_board에 저장될 수 없어서 에러터진다. 예외처리 해줘야 함(ex> 경고창 띄우기 등)
%>
	<script>
		alert('잘못된 접근입니다.');
		location.href='/jsp/boardlist.jsp';
	</script>
<%
		return;						//return 없으면 아래 소스 다 실행한다. return 으로 꼭 종료해줘야 한다.
	}
																	
	int i_board = Integer.parseInt(strI_board);
																	
	String sql = "SELECT title, ctnt, i_student FROM t_board where i_board = ?" ;
	//String sql = "SELECT title, ctnt, A.i_student, nm FROM t_board A inner join t_student B on A.I_student=B.I_student where i_board="+ strI_board;  //조인
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	BoardVO vo = new BoardVO();
	//String nm=null;
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);				//쿼리문 ? 에 주입할 수 있음.(쿼리문에서 직접 + 해도 되지만 많아지면 가독성 떨어짐.)
		//ps.setInt(1,3);							//쿼리문에 값을 넣기. (1번째 ?에 3을 넣는다)
		ps.setInt(1,i_board);			//strI_board를 정수형으로 바꿔서 쿼리문 1번째 ?에 주입.
		//setString은 문자열 양끝에 자동으로 홑따옴표('') 넣어줌.
		
		rs = ps.executeQuery();						//완성된 쿼리문 실행
		
		
		while(rs.next()){							//0줄일수도 있으니까 while이나 if(rs.next()){} 의 조건으로 확인을 해줘야 에러가 안터짐.(여러줄일때는 while을 써야 여러줄 다 받아옴)
			String title = rs.getNString("title");	//getString과 똑같지만 getString은 에러날 가능성이 아주야아아악간 있다(톰캣에서 어떤 기능을 끄면...). getNString은 안전.
			String ctnt = rs.getNString("ctnt");	
			int i_student = rs.getInt("i_student");
			//nm = rs.getNString("nm");
			
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
<title>상세페이지</title>
<style>
	table {border-collapse:collapse;}
	th, td{text-align:center; border: 1px solid black; width: 100px; height: 50px; }	
</style>
</head>
<body>
	<div><a href="/jsp/boardlist.jsp">리스트로 가기</a>
		<a href="#" onclick="procDel(<%=i_board%>)">삭제</a>
		<a href="/jsp/boardMod.jsp?i_board=<%=i_board%>">수정</a>
		</div>

	<div>제목 : <%=vo.getTitle() %></div>
	<div>내용 : <%=vo.getCtnt()%></div>
	<div>작성자 : <%=vo.getI_student()%></div>
	
	<script>
		function procDel(i_board){
			//alert('i_board : ' + i_board);
			if(confirm('삭제 하시겠습니까?')){				//confirm 의 return타입 : boolean
				location.href = '/jsp/boardDel.jsp?i_board='+i_board;				//boardDel.jsp로 i_board 값 보냄.
			}
		}
	</script>
</body>
</html>