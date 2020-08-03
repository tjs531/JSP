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
	String strI_board = request.getParameter("i_board");	

	int i_board = Integer.parseInt(strI_board);					

	String sql = "SELECT title, ctnt, i_student FROM t_board where i_board = ?" ;
	
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
<title>Insert title here</title>
</head>
<body>
	<div>											<!-- html에서 on으로 시작하는건 이벤트.onsubmit="return false" 하면 값이 전송되지 않음. 다른거 쓰면 다 전송됨. 그냥 chk()적으면 안되고 return chk() 써야 함.(onsubmit함수가 return해줘야 함)-->
		<form id="frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">				<!-- post로 보내면 주소창에 정보가 나타나지 않고 정보를 캡슐화 해서 전달. (주소창에는 /jsp/boardWriteProc.jsp 까지만 나타남-->
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