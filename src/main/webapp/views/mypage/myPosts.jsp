<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp"%>
<link rel="stylesheet" href="<%=contextPath%>/css/yelin/store/style_shoppingBasket.css">
<link rel="stylesheet" href="<%=contextPath%>/css/yoonjin/style_mypage_nav.css">
<link rel="stylesheet" href="<%=contextPath%>/css/yoonjin/style_myPosts.css">
<%@ page import="java.util.List"%>
<%

%>
<title>My Page | 관심목록</title>
</head>
<body>
    <%@ include file="/views/common/header.jsp"%>
    <section class="min1280px">
        <div id="sectionContainer" class="max1280px" style="min-height: 720px;">
        	<div class=mypageContainer>
        	<div id="mypage_nav">
        		<div id="user_profile">
                    <img src="<%=contextPath%>/images/yoonjin/information/default_profile.png" alt="user_profile_img" id="img_profile">
        			<h5><%=loginMember.getMemberId() %> 님</h5>
        			<p><%=loginMember.getMemberEmail() %><p>
        			                <input type="hidden" id="userId" name="userId" value="<%=loginMember.getMemberId()%>">
        		</div>
        		<hr>
        		<div id="user_nav">
					<nav>   
						<ul id="mypage_nav_ul">
							<li class="li1"><a href="#">내 정보 관리</a></li>
							<li class="li1"><a href="<%= request.getContextPath() %>/mypage/wishList.do?userId=<%=loginMember.getMemberId()%>">관심목록</a></li>
							<li class="li1"><a href="<%=request.getContextPath()%>/store/selectCartList.do?id=<%=loginMember.getMemberId()%>">장바구니</a></li>
							<li class="li1">구매내역
								<ul>
									<li class="li2"><a href="#">구매상세내역</a></li>
									<li class="li2"><a href="#">리뷰 작성</a></li>
								</ul>
							</li>
							<li class="li1">내가 쓴 글
								<ul>
									<li class="li2"><a href="<%= request.getContextPath() %>/views/mypage/myPosts.jsp">커뮤니티</a></li>
									<li class="li2"><a href="<%= request.getContextPath() %>/views/mypage/myInquiry.jsp">1:1문의</a></li>
								</ul>
							</li>
							<li class="li1"><a href="#">회원 탈퇴</a></li>
						</ul>
					</nav>
        		</div>
        		<div id="nav_btn_logout">
        			<a href="<%= request.getContextPath() %>/member/logout.do" id="logout_btn_mypage">로그아웃</a>
        		</div>
			</div>
            <div class="postListContainer">
                <p class="ShoppingBasket_eng">My Page</p>
                <p class="ShoppingBasket_kor">내가 쓴 글</p>
                <!-- 리스트 선택 -->
                <div class="post_ul_container">
                	<ul>
                		<li id="li-boardList" class="li-boardList selected_li ">작성글</li>
                		<li id="li-commentList" class="li-commentList">작성댓글</li>
                	</ul>
                	<hr>
                </div>
                <!-- 목록리스트 -->
                <div id="boardListContainer">
	                <table>
	                	<colgroup>
	                		<col style="width:30px">
	                		<col style="width:300px">
	                		<col style="width:100px">
	                		<col style="width:30px">
	                	</colgroup>
	                	<thead>
		                	<tr>
		                		<th scope="col"><input type="checkbox" id="checkbox-listAll"></th>
		                		<th scope="col">제목</th>
		                		<th scope="col">작성일</th>
		                		<th scope="col">조회수</th>
		                	</tr>
	                	</thead>
	                	<tbody>
		                	<tr>
		                		<td><input type="checkbox" class="boardChkbox"></td>
		                		<td style="text-align: center;">I’ve been waiting for this day</td>
		                		<td style="text-align: center;">2023-06-27</td>
		                		<td style="text-align: center;">0</td>
		                	</tr>
		                	<tr>
		                		<td><input type="checkbox" class="boardChkbox"></td>
		                		<td style="text-align: center;">the way I’m walking hand in hand with you</td>
		                		<td style="text-align: center;">2023-06-09</td>
		                		<td style="text-align: center;">5</td>
		                	</tr>
		                	<tr>
		                		<td><input type="checkbox" class="boardChkbox"></td>
		                		<td style="text-align: center;">just like all the sunlight is watch over me</td>
		                		<td style="text-align: center;">2023-06-01</td>
		                		<td style="text-align: center;">6</td>
		                	</tr>
	                	</tbody>
	                </table>
	                <div id="post-btnContainer">
	                	<button>삭제</button>
	                	<button>글쓰기</button>
	                </div>
                </div>
                <div id="commentListcontainer" style="display: none;">
					<table>
	                	<colgroup>
	                		<col style="width:30px">
	                		<col style="width:600px">
	                	</colgroup>
	                	<thead>
		                	<tr>
		                		<th scope="col"><input type="checkbox" id="checkbox-commentAll"></th>
		                		<th scope="col" style="text-align: center;">제목</th>
		                	</tr>
	                	</thead>
	                	<tbody>
	                		<tr>
	                			<td><input type="checkbox" class="commentChkbox"></td>
	                			<td>
	                				<div class="div_comment_td">
	                					<p class=comment_content>comment comment comment comment comment<p>
	                					<p class=comment_date>2023.05.24<p>
	                					<p class=comment_ref_title>title title title title title title title <p>
	                				</div>
	                			</td>
	                		</tr>
	                		<tr>
	                			<td><input type="checkbox" class="commentChkbox"></td>
	                			<td>
	                				<div class="div_comment_td">
	                					<p class=comment_content>comment comment comment comment comment<p>
	                					<p class=comment_date>2023.05.24<p>
	                					<p class=comment_ref_title>title title title title title title title <p>
	                				</div>
	                			</td>
	                		</tr>
	                	</tbody>
	                </table>
	                <div id="post-btnContainer">
	                	<button>삭제</button>
	                	<button>글쓰기</button>
	                </div>
                </div>
               <div class="page-bar">
               		<%-- <%=request.getAttribute("pageBar") %> --%>
               </div>
            </div>
        </div>
    </section>

   <%@ include file="/views/common/footer.jsp"%>
</body>
<script src="<%=contextPath%>/js/jquery-3.7.0.min.js"></script>
<script>
$(document).ready(function() {
	  // 초기 설정은 공연 버튼이 선택되어 있음
	  $("#boardListContainer").show();
	  $("#commentListcontainer").hide();

	  // 작성글 클릭 시
	  $("#li-boardList").click(function() {
	    $(this).addClass("selected_li");
	    $("#li-commentList").removeClass("selected_li");

	    $("#commentListcontainer").hide();
	    $("#boardListContainer").show();
	  });

	  // 댓글 클릭 시
	  $("#li-commentList").click(function() {
	    $(this).addClass("selected_li");
	    $("#li-boardList").removeClass("selected_li");

	    $("#boardListContainer").hide();
	    $("#commentListcontainer").show();
	  });
	});
</script>
</html>
