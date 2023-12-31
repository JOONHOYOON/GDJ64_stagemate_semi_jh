package com.stagemate.board.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stagemate.board.model.vo.Board;
import com.stagemate.board.model.vo.BoardComment;
import com.stagemate.board.service.BoardService;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardView.do")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("no"));


		Cookie[] cookies = request.getCookies();
		String boardRead = "";
		boolean isRead = false;
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("boardRead")) {
					boardRead = c.getValue();
					if (boardRead.contains("|" + boardNo + "|")) {
						isRead = true;
					}
					break;
				}

			}
		}
		if(!isRead) {
			Cookie c=new Cookie("boardRead",boardRead+"|"+"boardNo"+"|");
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}

		Board b = new BoardService().selectBoardByNo(boardNo, isRead);

		//		String read=Arrays.stream(cookies).filter(c->c.getName().equals("boardRead")).findFirst().orElse(new Cookie("boardRead","")).getValue();
//		
//		boolean isRead=read.contains("|" + boardNo + "|");
//		
//		if(!isRead) {
//			Cookie c=new Cookie("boardRead", read+"|"+boardNo+"|");
//			c.setMaxAge(60*60*24);
//			response.addCookie(c);

		List<BoardComment> comments = new BoardService().selectBoardComment(boardNo);

		request.setAttribute("comments", comments);

		request.setAttribute("board", b);

		request.getRequestDispatcher("/views/board/boardView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
