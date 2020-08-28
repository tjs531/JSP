package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

public class BoardDAO {
	public static List<BoardVO> selBoardList(BoardVO param) {
		final List<BoardVO> list = new ArrayList();			//레퍼런스변수에 final 붙이면 '주소값'을 변경할 수 없다. (그 안에 값을 넣고 빼고 하는건 가능)
		
		//String sql = "SELECT A.i_board, A.title, A.hits, B.nm, A.r_dt FROM t_board4 A, t_user B where A.i_user= B.i_user ORDER BY i_board DESC";
		
		/*String sql = "select A.i_board, A.title, A.hits, B.nm, A.r_dt, "
				+ " NVL((select count(i_user) from t_board4_like group by i_board having a.i_board=i_board),0) as c_like,"
				+ " NVL((select count(i_cmt) from t_board4_cmt group by i_board having i_board=A.i_board),0) as c_cmt "
				+ " from t_board4 A, t_user B "
				+ " where A.i_user = B.i_user "
				+ " order by A.i_board desc";*/
		
		String sql = "select A.* from (select  rownum as rnum, A.* from (select A.i_board, A.title, A.hits, B.nm, A.r_dt, "
				+ " NVL((select count(i_user) from t_board4_like group by i_board having a.i_board=i_board),0) as c_like,"
				+ " NVL((select count(i_cmt) from t_board4_cmt group by i_board having i_board=A.i_board),0) as c_cmt "
				+ " from t_board4 A, t_user B "
				+ " where A.i_user = B.i_user "
				+ " and a.title like ? "
				+ " order by A.i_board desc) A where rownum<=? ) A where a.rnum>?";
		
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { 
				ps.setNString(1, param.getSearchText());
				ps.setInt(2, param.getEldx());
				ps.setInt(3, param.getSldx());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					//int i_user = rs.getInt("i_user");
					String r_dt = rs.getNString("r_dt");
					String nm = rs.getNString("nm");
					int c_like = rs.getInt("c_like");
					int c_cmt = rs.getInt("c_cmt");
					
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					//vo.setI_user(i_user);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					vo.setC_like(c_like);
					vo.setC_cmt(c_cmt);
					
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
	
	public static BoardVO selDetail(BoardVO param) {
		BoardVO vo = new BoardVO();
		
		vo.setI_board(param.getI_board());
		
		//String sql = "SELECT A.title, A.hits, B.nm, B.i_user, A.ctnt, TO_CHAR(A.r_dt,'YYYY/MM/DD HH24:MI') as r_dt, TO_CHAR(A.m_dt,'YYYY/MM/DD HH24:MI') as m_dt FROM t_board4 A, t_user B where A.i_user= B.i_user AND A.i_board=?";
		/*String sql = "SELECT A.title, A.hits, B.nm, B.i_user, A.ctnt, TO_CHAR(A.r_dt,'YYYY/MM/DD HH24:MI') as r_dt, TO_CHAR(A.m_dt,'YYYY/MM/DD HH24:MI') as m_dt, DECODE(C.i_user, null, 0, 1) as yn_like "
				+ " FROM t_board4 A inner join t_user B on A.i_user= B.i_user "
				+ " left join t_board4_like C "
				+ " on A.i_board = C.i_board and C.i_user = ? "
				+ " where A.i_board = ? "; */
		
		String sql = "SELECT B.nm, A.i_user, A.title, A.ctnt, A.hits, TO_CHAR(A.r_dt,'YYYY/MM/DD HH24:MI') As r_dt, "
				+ " TO_CHAR(A.m_dt,'YYYY/MM/DD HH24:MI') as m_dt, DECODE(C.i_user, null, 0, 1) as yn_like "
				+ " from t_board4 A inner join t_user B "
				+ " on A.i_user = B.i_user "
				+ " left join t_board4_like C "
				+ " on A.i_board = C.i_board "
				+ " and C.i_user =? "
				+ " where A.i_board=?";
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { 
				ps.setInt(1, param.getI_user());
				ps.setInt(2, param.getI_board());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					String title = rs.getNString("title");
					String r_dt = rs.getNString("r_dt");
					String m_dt = rs.getNString("m_dt");
					String nm = rs.getNString("nm");
					String ctnt = rs.getNString("ctnt");
					int i_user = rs.getInt("i_user");
					int hits = rs.getInt("hits");
					int yn_like = rs.getInt("yn_like");
					
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					vo.setM_dt(m_dt);
					vo.setCtnt(ctnt);
					vo.setI_user(i_user);
					vo.setYn_like(yn_like);
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
	
	public static int updBoard(BoardVO vo) {
		String sql = "UPDATE t_board4 SET title=?, ctnt=?, m_dt = sysdate where i_board=? AND i_user=?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, vo.getTitle());
				ps.setNString(2, vo.getCtnt());
				ps.setInt(3, vo.getI_board());
				ps.setInt(4, vo.getI_user());
			}
			
		});
	}
	
	////////////////// Hits /////////////////////////////
	
	public static int updHits(BoardVO vo) {
		//String sql = "UPDATE t_board4 SET hits=hits+1 where i_board=?";
		
		String sql = "UPDATE t_board4 SET hits=(select count(i_user) from t_hits where i_board=? group by i_board) where i_board=?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, vo.getI_board());
				ps.setInt(2, vo.getI_board());
			}
		});
	}
	
	public static int insHits(BoardVO vo) {
		String sql = "insert into t_hits values (?,?)";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, vo.getI_board());
				ps.setInt(2, vo.getI_user());
			}
		});
	}
	
	/////////////////// like ///////////////////////////
	
	public static int insLike(BoardVO vo) {
		String sql = "INSERT into t_board4_like(i_board,i_user) values (?,?)";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, vo.getI_board());
				ps.setInt(2, vo.getI_user());
			}
		});
	}
	
	public static int delLike(BoardVO vo) {
		String sql = "DELETE FROM t_board4_like where i_board=? AND i_user=?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, vo.getI_board());
				ps.setInt(2, vo.getI_user());
			}
		});
	}
	
	//like 누른사람 리스트
	public static List<UserVO> selLikeList(BoardVO vo,String likeorhate) {
		//String sql = "Select B.nm, B.profile_img from t_board4_like A, t_user B where A.i_user = B.i_user and A.i_board=?";
		
		String sql = "Select B.nm, B.profile_img from t_board4_"+likeorhate+" A, t_user B where A.i_user = B.i_user and A.i_board=?";
		
		final List<UserVO> list = new ArrayList<UserVO>();
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { 
				ps.setInt(1, vo.getI_board());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					String nm = rs.getNString("nm");
					String img = rs.getNString("profile_img");
					UserVO vo = new UserVO();
					vo.setNm(nm);
					vo.setProfile_img(img);
					
					list.add(vo);
				}
				return 1;
			}
		});
		
		return list;
	}
	
	////////////////////////paging///////////////////////////
	
	//페이징 숫자 가져오기
	public static int selPagingCnt(final BoardVO param) {
		String sql = "select ceil(count(i_board) / ?) from t_board4 "
				+ " Where title like ? ";
		
		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException { 
				ps.setInt(1, param.getRecord_cnt());
				ps.setNString(2, param.getSearchText());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					return rs.getInt(1);				//스칼라값일때는 인덱스 써서 가져오는것도 괜찮음.(1번째 나오는 값)
				}
				return 0;
			}
		});
	}
	
	
}
	