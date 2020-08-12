package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVo;

@WebServlet("/boardMod")
public class BoardMod extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		int i_board = Utils.parseStrToInt(strI_board, 0);		//문자열을 정수로 바꿈.혹시 숫자가 아닌 문자열이 섞여있으면 0이 리턴
		
		if(i_board ==0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVo param = new BoardVo();
		param.setI_board(i_board);
		
		BoardVo data = BoardDAO.selBoard(param);	//DB로 값 받기	
		request.setAttribute("data", data);	
		
		
		String jsp = "/WEB-INF/view/boardRegmod.jsp";
		request.getRequestDispatcher(jsp).forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String i_board = request.getParameter("i_board");
		String title=request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		//String i_student=request.getParameter("i_student");
		BoardVo param = new BoardVo();
		param.setTitle(title);
		param.setCtnt(ctnt);
		//param.setI_student(Integer.parseInt(i_student));
		param.setI_board(Integer.parseInt(i_board));
		
		int result = BoardDAO.updateBoard(param);
		
		if(result == 1) { 	//정상
			response.sendRedirect("/boardDetail?i_board="+ i_board);
		}else {
			request.setAttribute("msg", "에러가 발생했습니다.");
			doGet(request, response);
		}
	}

}
