package com.stagemate.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stagemate.admin.service.AdminService;
import com.stagemate.admin.service.AdminService2;
import com.stagemate.admin.service.AdminServiceImpl2;
import com.stagemate.common.AESEncryptor;
import com.stagemate.member.model.vo.Member;

/**
 * Servlet implementation class MyBatisMemberListServlet
 */
@WebServlet("/myBatisMemberList.do")
public class MyBatisMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBatisMemberListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminService2 service=new AdminServiceImpl2();
		int cPage;
		int numPerpage;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e){
			cPage=1;
		}
		try {
			numPerpage=Integer.parseInt(request.getParameter("numPerpage"));
		}catch(NumberFormatException e){
			numPerpage=10;
		}
		
		List<Member> ms=service.listMember2(cPage,numPerpage);
		for(Member m:ms) {
			try {
				m.setMemberEmail(AESEncryptor.decrypt(m.getMemberEmail()));
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("member", ms);
		int totalData=service.selectMemberCount();
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageBarSize=5;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		String pageBar="";
		String left_double_arrow = String.format("<img src='%s'>", request.getContextPath() + "/images/joonho/left_double_arrow.svg");
		String left_arrow = String.format("<img src='%s'>", request.getContextPath() + "/images/joonho/left_arrow.svg");
		String right_double_arrow = String.format("<img src='%s'>", request.getContextPath() + "/images/joonho/right_double_arrow.svg");
		String right_arrow = String.format("<img src='%s'>", request.getContextPath() + "/images/joonho/right_arrow.svg");
		if(pageNo==1) {
			pageBar+="<span>"+left_double_arrow+"</span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+(pageNo-1)+"'>"+left_double_arrow+"</a>";
		}
		if(cPage==1) {
			pageBar+="<span>"+left_arrow+"</span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+(cPage-1)+"'>"+left_arrow+"</a>";
		}
		pageBar+="<div>";
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<span>"+pageNo+"</span>";
			}else {
				pageBar+="<a href='"+request.getRequestURI()+"?cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		pageBar+="</div>";
		if(cPage==totalPage) {
			pageBar+="<span>"+right_arrow+"</span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+(cPage+1)+"'>"+right_arrow+"</a>";
		}
		
		if(pageNo>totalPage) {
			pageBar+="<span>"+right_double_arrow+"</span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+pageNo+"'>"+right_double_arrow+"</a>";
		}
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/views/admin/admin_membermanage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
