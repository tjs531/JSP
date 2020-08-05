package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/boardList")				//주소 매핑 (원하는 주소를 적어주면 됨). 주소값이 클래스명이랑 똑같으면 보안에 안좋아서 url만 보고 파일명을 유추할 수 없도록 고쳐줘야 한다.(FM)
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;			//private(접근지시어)안적으면 디폴트. (같은 패키지 안에서는 접근 가능)
      
    public BoardListSer() {
        super();
    }

    //get방식으로 날리고 싶으면 이 부분에 적으면 됨
    //request : 사용자가 나에게 요청한 모든 정보가 들어있음.
    //response : 응답
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());				//append내용이 사용자에게 응답으로 전송
		String strI_board = request.getParameter("i_board");
		System.out.println("Servlet i_board : " + strI_board);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
	}

	//post방식으로 날리고 싶으면 이 부분에 적으면 됨 (post방식은 form으로 보낼 수 있다.)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
