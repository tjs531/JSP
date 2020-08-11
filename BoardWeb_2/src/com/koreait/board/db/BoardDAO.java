package com.koreait.board.db;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.koreait.board.vo.BoardVo;

public class BoardDAO {
	public static List<BoardVo> selBoardList(){
		List<BoardVo> list = new ArrayList();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = " SELECT i_board, title, i_student FROM t_board ORDER BY i_board DESC";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				int i_student = rs.getInt("i_student");
				
				BoardVo vo = new BoardVo();
				
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setI_student(i_student);
				
				list.add(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps, rs);
		}
		
		return list;
		
	}
	
	public static BoardVo selBoard(BoardVo param){		//파라메터는 int로 해도 되는데 여기서는 BoardVo로 보내는게 나중에 수정이 더 쉬움
		BoardVo vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = " SELECT i_board, title, ctnt, i_student FROM t_board Where i_board=?";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, param.getI_board());
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				String ctnt = rs.getNString("ctnt");
				int i_student = rs.getInt("i_student");
				
				vo = new BoardVo();				//위에서 선언하면 구별하기 힘들다?
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setCtnt(ctnt);
				vo.setI_student(i_student);
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps, rs);
		}
		
		return vo;
	}
	
	public static int insBoard(BoardVo param){
		Connection con = null;
		PreparedStatement ps = null;
		
		String sql = "insert into t_board(i_board, title, ctnt, i_student) values (seq_board.nextval,?,?,?)";
		int result =0;															//sequence 생성하고 사용. (숫자가 1씩 증가) 

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setNString(1,param.getTitle());			
			ps.setNString(2,param.getCtnt());	
			ps.setInt(3,param.getI_student());
			result = ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}
		
		return result;
	}
	
	public static int delBoard(int i_board){
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		
		String sql = "delete from t_board where i_board=?";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1,i_board); 
			result = ps.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}
		
		return result;
	}
}
