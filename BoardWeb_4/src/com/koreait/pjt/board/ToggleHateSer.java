package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

/**
 * Servlet implementation class ToggleHateSer
 */
@WebServlet("/board/toggleHate")
public class ToggleHateSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String i_board = request.getParameter("i_board");
		String yn_hate = request.getParameter("yn_hate");
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
		BoardVO vo = new BoardVO();
		
		vo.setI_board(Integer.parseInt(i_board));
		vo.setI_user(loginUser.getI_user());
	
		if(Integer.parseInt(yn_hate) == 0) {
			BoardDAO.insHate(vo);
		}else {
			BoardDAO.delHate(vo);
		}
		
		request.setAttribute("vo", BoardDAO.selDetail(vo));
		ViewResolver.forwardLoginChk("board/detail", request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
