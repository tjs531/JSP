package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;

@WebServlet("/boardDel")
public class BoardDeleteSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String strI_board = request.getParameter("i_board");
		int i_board = Integer.parseInt(strI_board);			
		
		if(i_board == 0) {		//잘못된 값을 보냄(문자열 섞여있음)
			response.sendRedirect("/errPage?err=2&target=boardList");
			return;
		}
		
		int result = BoardDAO.delBoard(i_board);
		if(result == 1) {
			response.sendRedirect("/boardList");
		} else {
			response.sendRedirect("/errPage?err=1&target=boardList");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
