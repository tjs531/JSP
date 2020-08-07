package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVo;
import com.koreait.board.common.Utils;

@WebServlet("/boardDetail")
public class BoardDetailSer extends HttpServlet {
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
		
		request.setAttribute("data", data);				//그냥 i_baord 만 보내도 된다. but 이렇게 보내는게 수정이 편해서 미래의 나를 위해..
		
		String jsp = "/WEB-INF/view/boardDetail.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
		//RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardDetail.jsp");
		//rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
