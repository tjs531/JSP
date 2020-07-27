<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.koreait.first.hs.*" %>
<%@ page import  = "java.sql.*" %>
<%@ page import  = "java.util.*" %>

<%
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userName = "hr";
	String password = "koreait2020";

	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String sql = "SELECT * FROM countries";
			
	List<CountriesVO> list = new ArrayList();
	
	try{
		con = DriverManager.getConnection(url, userName, password);
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			CountriesVO vo = new CountriesVO();
			vo.setCountry_id(rs.getString("country_id"));
			vo.setCountry_name(rs.getString("country_name"));
			vo.setRegion_id(rs.getInt("region_id"));
			
			list.add(vo);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally {
		try{
			rs.close();
			ps.close();
			con.close();
		}catch(Exception e){}
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
<style>
	table, th, td { border:1px solid black; border-collapse: collapse;}
</style>
</head>
<body>
	<div>나라 정보</div>
	<div>
		<table>
			<tr>
				<th>country_id</th>
				<th>나라명</th>
				<th>지역ID</th>
			</tr>
			
			<%for(CountriesVO vo : list) {%>
			<tr>
				<td><%=vo.getCountry_id() %> </td>
				<td><%=vo.getCountry_name() %> </td>
				<td><%=vo.getRegion_id() %></td>
			</tr>
			<% } %>
	</table></div>
</body>
</html>