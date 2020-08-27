package com.koreait.pjt.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int page = MyUtils.getIntParameter(request, "page");
		page = (page==0) ? 1 : page;
		
		BoardVO param= new BoardVO();
		param.setRecord_cnt(Const.RECORD_CNT); //한 페이지 당 20개 뿌리겠다.
		param.setEldx(page * param.getRecord_cnt());
		param.setSldx(param.getEldx() - param.getRecord_cnt());
		
		request.setAttribute("page", page);
		request.setAttribute("pagingCnt", BoardDAO.selPagingCnt(param));
		request.setAttribute("list",  BoardDAO.selBoardList(param));
		ViewResolver.forwardLoginChk("board/list", request, response);
	}
}