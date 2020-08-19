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
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/regmod")
public class BoardRegmodSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//화면 띄우는 용도(등록창,수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		if(hs.getAttribute(Const.LOGIN_USER) == null) {
			response.sendRedirect("/login");
			return;
		}
		
		ViewResolver.forward("board/regmod", request, response);
	}

	//처리용도 (DB에 등록/수정) 실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
		//int i_user = Integer.parseInt(request.getParameter("i_user"));
		
		BoardVO param = new BoardVO();
		
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(loginUser.getI_user());
		
		int result = BoardDAO.insBoard(param);
		
		if(result != 1) {			//에러발생
			request.setAttribute("msg", "에러가 발생했습니다. 관리자에게 문의 ㄱ");
			request.setAttribute("data", param);
			doGet(request, response);
			return;
		}	
		response.sendRedirect("/board/list");			
	}
}