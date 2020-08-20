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
	
/*	public static List<String> getname(int i_user) {
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
	}*/
	
	public static BoardVO selDetail(String i_board) {
		BoardVO vo = new BoardVO();
		
		vo.setI_board(Integer.parseInt(i_board));
		
		String sql = "SELECT A.title, A.hits, B.nm, B.i_user, A.ctnt, TO_CHAR(A.r_dt,'YYYY/MM/DD HH24:MI') as r_dt FROM t_board4 A, t_user B where A.i_user= B.i_user AND A.i_board=?";
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { 
				ps.setInt(1, Integer.parseInt(i_board));
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					String title = rs.getNString("title");
					String r_dt = rs.getNString("r_dt");
					String nm = rs.getNString("nm");
					String ctnt = rs.getNString("ctnt");
					int i_user = rs.getInt("i_user");
					int hits = rs.getInt("hits");
					
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					vo.setCtnt(ctnt);
					vo.setI_user(i_user);
				}
				return 1;
			}
		});
		return vo;
	}
	
	public static int delBoard(BoardVO param) {
		String sql = "DELETE FROM t_board4 where i_board=? AND i_user=?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
		});
	}
	
	public static int modBoard(BoardVO vo) {
		String sql = "UPDATE t_board4 SET title=?, ctnt=? where i_board=?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, vo.getTitle());
				ps.setNString(2, vo.getCtnt());
				ps.setInt(3, vo.getI_board());
			}
			
		});
	}
}