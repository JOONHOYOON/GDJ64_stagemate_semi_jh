package com.stagemate.event.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stagemate.event.model.vo.Event;
import com.stagemate.event.model.vo.EventUpfile;
import com.stagemate.event.model.vo.EventWish;
import com.stagemate.event.service.EventService;
import com.stagemate.review.model.vo.EventReviewTBJH;

/**
 * Servlet implementation class Musical
 */
@WebServlet("/act.do")
public class ActListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cPage;
		int numPerpage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		try {
			numPerpage = Integer.parseInt(request.getParameter("numPerpage"));
		} catch (NumberFormatException e) {
			numPerpage = 16;
		}

		List<Event> act = new EventService().selectAllEventAct(cPage, numPerpage);
		List<EventUpfile> files=new EventService().selectAllFile();
		List<EventReviewTBJH> er=new EventService().selectAllEventReview();
		request.setAttribute("er", er);
		int totalData = new EventService().selectEventCountAct();
		request.setAttribute("act", act);
		request.setAttribute("files", files);
		int totalPage = (int) Math.ceil((double) totalData / numPerpage);
		int pageBarSize = 3;
		int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageNo + pageBarSize - 1;
		String pageBar = "";
		String left_double_arrow = String.format("<img src='%s'>",
				request.getContextPath() + "/images/joonho/left_double_arrow.svg");
		String left_arrow = String.format("<img src='%s'>", request.getContextPath() + "/images/joonho/left_arrow.svg");
		String right_double_arrow = String.format("<img src='%s'>",
				request.getContextPath() + "/images/joonho/right_double_arrow.svg");
		String right_arrow = String.format("<img src='%s'>",
				request.getContextPath() + "/images/joonho/right_arrow.svg");
		if (pageNo == 1) {
			pageBar += "<span>" + left_double_arrow + "</span>";
		} else {
			pageBar += "<a href='" + request.getRequestURI() + "?cPage=" + (pageNo - 1) + "'>" + left_double_arrow
					+ "</a>";
		}
		if (cPage == 1) {
			pageBar += "<span>" + left_arrow + "</span>";
		} else {
			pageBar += "<a href='" + request.getRequestURI() + "?cPage=" + (cPage - 1) + "'>" + left_arrow + "</a>";
		}
		pageBar += "<div>";
		while (!(pageNo > pageEnd || pageNo > totalPage)) {
			if (pageNo == cPage) {
				pageBar += "<span>" + pageNo + "</span>";
			} else {
				pageBar += "<a href='" + request.getRequestURI() + "?cPage=" + pageNo + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		pageBar += "</div>";
		if (cPage == totalPage) {
			pageBar += "<span>" + right_arrow + "</span>";
		} else {
			pageBar += "<a href='" + request.getRequestURI() + "?cPage=" + (cPage + 1) + "'>" + right_arrow + "</a>";
		}

		if (pageNo > totalPage) {
			pageBar += "<span>" + right_double_arrow + "</span>";
		} else {
			pageBar += "<a href='" + request.getRequestURI() + "?cPage=" + pageNo + "'>" + right_double_arrow + "</a>";
		}
		List<EventWish> ew=new EventService().selectAllEventWish();
		request.setAttribute("ew", ew);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/views/event/act/act_list.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
