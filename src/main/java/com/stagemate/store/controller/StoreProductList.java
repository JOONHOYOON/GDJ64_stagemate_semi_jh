package com.stagemate.store.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stagemate.store.model.vo.Product;
import com.stagemate.store.model.vo.StoreLike;
import com.stagemate.store.model.vo.StoreUpfile;
import com.stagemate.store.service.StoreService;


@WebServlet("/store/productList.do")
public class StoreProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StoreProductList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		//페이징처리
		int cPage;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));			
		}catch(NumberFormatException e) {
			cPage=1;
		}
		int numPerPage;
		try {
			numPerPage=Integer.parseInt(request.getParameter("numPerpage"));			
		}catch(NumberFormatException e) {
			numPerPage=6;
		}
		
		//1. DB에 있는 데이터 가져오기
		//정렬기준 확인
		String sort=request.getParameter("sort");
		List<Product> products=new ArrayList<>();
		if (sort == null || sort.isEmpty()||sort.equals("new")) {
		    // 기본 정렬방식
			products=new StoreService().selectAllProduct(cPage,numPerPage);
		} else {
			//정렬 기준 매개변수로 가지는 메소드
			products=new StoreService().selectAllProductOrderBySort(cPage,numPerPage,sort);
		}
		List<StoreUpfile> files=new StoreService().selectAllFile();
		List<StoreLike> likes=new StoreService().selectAllLike();
		//2.DB에서 가져온 데이터 저장(화면출력)
		request.setAttribute("sortFilter", sort);
		request.setAttribute("products", products);
		request.setAttribute("files", files);
		request.setAttribute("likes", likes);
		//3 페이지바 구성
		//3-1) DB에 저장된 전체 데이터의 수를 가져오기
		int totalData=new StoreService().selectProductCount();
		//3-2)전체 페이지 수 계산 *소숫점주의!
		int totalPage=(int)Math.ceil((double)totalData/numPerPage);
		//3-3) 페이지바 시작번호 계산
		int pageBarSize=3;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		//3-4)페이지바를 구성하는 html 저장
		String contextPath=request.getContextPath();
		String pageBar="";
		//맨처음 페이지표시
		if(pageNo==1) {
			pageBar+="<span><img src='"+contextPath+"/images/yoonjin/button/double-arrow-left.svg' alt='arrow-left'></span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+1+"'><img src='"+contextPath+"/images/yoonjin/button/double-arrow-left.svg' alt='arrow-left'></a>";
		}
		//이전표시
		if(pageNo==1) {
			pageBar+="<span><img src='"+contextPath+"/images/yoonjin/button/arrow-left.svg' alt='arrow-left'></span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+(pageNo-1)+"'><img src='"+contextPath+"/images/yoonjin/button/arrow-left.svg' alt='arrow-left'></a>";
		}
		//선택할 페이지 번호 출력
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<span>"+pageNo+"</span>";
			}else {
				pageBar+="<a class='bar-num' href='"+request.getRequestURI()+"?cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//다음표시
		if(pageNo>totalPage) {
			pageBar+="<span><img src='"+contextPath+"/images/yoonjin/button/arrow-right.svg' alt='arrow-right'></span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+(pageNo+1)+"'><img src='"+contextPath+"/images/yoonjin/button/arrow-right.svg' alt='arrow-right'></a>";
		}
		//마지막 페이지표시
		if(pageNo>totalPage) {
			pageBar+="<span><img src='"+contextPath+"/images/yoonjin/button/double-arrow-right.svg' alt='arrow-right'></span>";
		}else {
			pageBar+="<a href='"+request.getRequestURI()+"?cPage="+totalPage+"'><img src='"+contextPath+"/images/yoonjin/button/double-arrow-right.svg' alt='arrow-right'></a>";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		
		//4.출력할 화면을 선택(이동)
		request.getRequestDispatcher("/views/store/productList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
