package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

public class BoardDAO {
	public static List<BoardVO> selBoardList() {
		final List<BoardVO> list = new ArrayList();			//레퍼런스변수에 final 붙이면 '주소값'을 변경할 수 없다. (그 안에 값을 넣고 빼고 하는건 가능)
		
		//String sql = "SELECT i_board, title, hits, i_user, r_dt FROM t_board4 ORDER BY i_board DESC";
		String sql = "SELECT A.i_board, A.title, A.hits, B.nm, A.r_dt FROM t_board4 A, t_user B where A.i_user= B.i_user ORDER BY i_board DESC";
				
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { }

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					//int i_user = rs.getInt("i_user");
					String r_dt = rs.getNString("r_dt");
					String nm = rs.getNString("nm");
					
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					//vo.setI_user(i_user);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					
					list.add(vo);
				}
				return 1;
			}
			
		});
		
		return list;
	}
	
	public static int insBoard(BoardVO param) {
		String sql = "INSERT INTO t_board4(i_board, title,ctnt,i_user) values (seq_board.nextval,?,?,?)";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_user());
			}
		});
	}
	
	public static List<String> getname(int i_user) {
		List<String> str = new ArrayList();
		String sql = "Select nm from t_user where i_user="+i_user;
		
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { }

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					str.add(rs.getNString("nm"));
				}
				return 1;
			}
			
		});
		
		return str;
	}
}
