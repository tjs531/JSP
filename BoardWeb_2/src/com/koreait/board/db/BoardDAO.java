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
}
