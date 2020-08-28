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
		
		HttpSession hs = (HttpSession)request.getSession();
		
		String searchText = request.getParameter("searchText");
		searchText = (searchText == null ? "" : searchText);
		
		int page = MyUtils.getIntParameter(request, "page");
		page = (page==0 ? 1 : page);
		
		int recordCnt = MyUtils.getIntParameter(request, "record_cnt");
		recordCnt = (recordCnt == 0? 10: recordCnt);
		
		BoardVO param= new BoardVO();
		param.setRecord_cnt(recordCnt); //한 페이지 당 뿌리는 갯수
		param.setSearchText("%"+ searchText + "%");
		
		int pagingCnt = BoardDAO.selPagingCnt(param);			//페이지 개수
		
		if(pagingCnt < page) {
			page = pagingCnt;
		}
		
		int eIdx = page * recordCnt;
		int sIdx = eIdx - recordCnt;
		
		param.setSldx(sIdx);
		param.setEldx(eIdx);
		
		hs.setAttribute("searchText", searchText);

		request.setAttribute("page", page);
		request.setAttribute("pagingCnt", pagingCnt);
		request.setAttribute("list",  BoardDAO.selBoardList(param));
		
		//hs.setAttribute("recordCnt", recordCnt);

		ViewResolver.forwardLoginChk("board/list", request, response);
	}
}