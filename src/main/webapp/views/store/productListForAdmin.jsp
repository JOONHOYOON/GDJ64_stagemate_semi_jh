<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp"%>
<%@page import="java.util.List,com.stagemate.store.model.vo.Product"%>
<%-- <%
List<Product> products = (List) request.getAttribute("products");
%> --%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/yoonjin/style_product_list_for_admin.css">
<title>Store Management</title>
</head>
<body>
	<%@ include file="/views/common/header.jsp"%>
	<section class="min1280px">
		<div id="sectionContainer" class="max1280px body_height div_flex_style">
			<div id="store_admin_nav">
				<nav>
					<ul id="store_admin_nav_ul">
						<li>회원 관리</li>
						<li class="select_nav_admin">
							상품 관리
							<ul>
								<li>예매</li>
								<li class="select_nav_admin">스토어</li>
							</ul>
						</li>
						<li>
							판매 관리
							<ul>
								<li>판매내역관리</li>
								<li>결제 취소 요청</li>
								<li>반품/교환 관리</li>
							</ul>
						</li>
						<li>
							커뮤니티 관리
							<ul>
								<li>게시판 관리</li>
								<li>신고 관리</li>
							</ul>
						</li>
						<li>
							고객센터
							<ul>
								<li>공지사항 관리</li>
								<li>1:1문의 관리</li>
							</ul>
						</li>
					</ul>
				</nav>
			</div>
			<div id="store_manager_container">
				<div id="store_manager_nav">
					<nav>
						<span>상품관리</span>
                		<span><img src="<%=contextPath %>/images/yoonjin/button/arrow.svg" alt=""></span>
                		<span>스토어</span>
					</nav>
				</div>
				<hr>
				<div id="store_manager_list">
					<button id="insert_product_btn" class="btn-layout btn-white">상품등록</button>
					<table id="store_manager_tbl">
						<tr>
							<th id="manageTbl_productNo">번호</th>
							<th>행사</th>
							<th>상품명</th>
							<th>판매가격</th>
							<th>재고</th>
							<th>관리자 비고</th>
							<th>등록일</th>
							<th></th>
						</tr>
						<tr>
							<td>1</td>
							<td>행사이름</td>
							<td>상품이름</td>
							<td>7000</td>
							<td>55</td>
							<td>재고관리 수시로</td>
							<td>2023-05-08</td>
							<td>
								<button class="btn_store_mng">수정</button>
								<button class="btn_store_mng">삭제</button>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>행사이름2</td>
							<td>상품이름2</td>
							<td>5000</td>
							<td>29</td>
							<td>추후 재입고예정 없음</td>
							<td>2023-05-30</td>
							<td>
								<button class="btn_store_mng">수정</button>
								<button class="btn_store_mng">삭제</button>
							</td>
						</tr>
						<tr>
							<td>3</td>
							<td>행사이름3</td>
							<td>상품이름3</td>
							<td>3000</td>
							<td>109</td>
							<td></td>
							<td>2023-06-07</td>
							<td>
								<button class="btn_store_mng">수정</button>
								<button class="btn_store_mng">삭제</button>
							</td>
						</tr>
					</table>
				</div>
				<div class="page-bar">
					<%-- <%=request.getAttribute("pageBar")%> --%>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/views/common/footer.jsp"%>
	<script src="<%=contextPath%>/js/jquery-3.7.0.min.js"></script>
	<script src="<%=contextPath%>/js/script_common.js"></script>
	<script src="<%=request.getContextPath()%>/js/yoonjin/product_list_for_admin.js"></script>
</body>
</html>