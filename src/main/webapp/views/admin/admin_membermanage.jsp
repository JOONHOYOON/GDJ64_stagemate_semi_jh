<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp" %>
<%@ page import="java.util.List,com.stagemate.member.model.vo.Member"%>
<%
List<Member> members = (List) request.getAttribute("member");
String type=request.getParameter("searchType");
String keyword=request.getParameter("searchKeyword");
%>
<!-- 본인이 따로 적용할 CSS 파일 및 style 태그 -->
<link rel="stylesheet" href="<%= contextPath %>/css/joonho/style_admin_membermanage.css">
<!---------------------------------------->
<title>STAGEMATE/회원관리</title>
</head>
<body>
<%@ include file="/views/common/header.jsp" %>
<!-----------   아래에서 HTML 작업  ----------->
<section class="min1280px">
    <div class="max1280px">
        <div id="maincontainer">
			<!-- 관리자 사이드메뉴 -->
			<div id="store_admin_nav">
				<nav>
					<ul id="store_admin_nav_ul">
						<li><a href="<%=contextPath%>/admin/membermanage" class="select_nav_admin">회원 관리</a></li>
						<li>
							<a href="<%=contextPath%>/admin/eventlist">상품 관리</a>
							<ul>
								<li><a href="<%=contextPath%>/admin/eventlist">행사</a></li>
								<li><a href="<%=contextPath%>/admin/selectAllProduct.do">스토어</a></li>
							</ul>
						</li>
						<li>
							<a href="<%=contextPath%>/admin/SalesDetail.do">판매 관리</a>
							<ul>
								<li><a href="<%=contextPath%>/admin/SalesDetail.do">판매내역관리</a></li>
								<li><a href="">결제 취소 요청</a></li>
								<li><a href="">반품/교환 관리</a></li>
							</ul>
						</li>
						<li>
							<a href="">커뮤니티 관리</a>
							<ul>
								<li><a href="<%=contextPath%>/views/admin/admin_Board.jsp">게시판 관리</a></li>
								<li><a href="<%=contextPath%>/views/admin/admin_Comment.jsp">신고 관리</a></li>
							</ul>
						</li>
						<li>
							<a href="">고객센터</a>
							<ul>
								<li><a href="">공지사항 관리</a></li>
								<li><a href="">1:1문의 관리</a></li>
							</ul>
						</li>
					</ul>
				</nav>
			</div>
			<!-- 회원검색창 -->
			<div id="memberManage">
				<h2>회원관리</h2>
				<br>
				<hr>
				<div id="search-container">
					<select id="searchType">
						<option value="userId" <%=type!=null&&type.equals("userId")?"selected":"" %>>아이디</option>
						<option value="userName" <%=type!=null&&type.equals("userName")?"selected":"" %>>회원이름</option>
					</select>
					<div id="search-userId">
						<form action="<%= contextPath %>/admin/searchMember">
							<input type="hidden" name="searchType" value="MEMBER_ID"> <input
								type="text" name="searchKeyword" size="25"
								placeholder="검색할 아이디를 입력하세요" value="<%=type!=null&&type.equals("userId")?keyword:""%>"> 
								<button type="submit">조회</button>
						</form>
					</div>
					<div id="search-userName">
						<form action="<%= contextPath %>/admin/searchMember">
							<input type="hidden" name="searchType" value="MEMBER_NM">
							<input type="text" name="searchKeyword" size="25"
								placeholder="검색할 이름을 입력하세요"  value="<%=type!=null&&type.equals("userName")?keyword:""%>"> 
								<button type="submit">조회</button>
						</form>
					</div>
				</div>
				<!-- 회원테이블 -->
				<table id="admin_membermanage_table">
					<thead>
						<tr>
							<th></th>
							<th>아이디</th>
							<th>이름</th>
							<th>이메일</th>
							<th>가입일자</th>
							<th>탈퇴일자</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (members.isEmpty()) {%>
						<tr>
							<td id="noperson"colspan="6">등록된 회원이 없습니다.</td>
						</tr>
						<%} else {
							for (Member m : members) {
						%>
						<tr>
							<td><input type="checkbox" name="check" <%=m.getWthdrDate()!=null||m.getMemberId().equals("stageadmin") ? "disabled" : ""%>></td>
							<td><a href=""><%=m.getMemberId()%></a></td>
							<td><%=m.getMemberNm()%></td>
							<td><%=m.getMemberEmail()%></td>
							<td><%=m.getEnrollDate()%></td>
							<td><%=m.getWthdrDate() == null ? "-" : m.getWthdrDate()%></td>
						</tr>
						<%
						}
						}
						%>

					</tbody>
				</table>
				<br> <br>
				<!-- 강제탈퇴 버튼 -->
				<div id="withdrawal">
					<a href="#layer1" class="btn-example"><input type="button"
						class="btn-layout btn-brown " value="강제탈퇴"></a>
					<div id="layer1" class="pop-layer">
						<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
								<div id="inner_pop">
									<div>
										<img src="<%= contextPath %>/images/joonho/question.png">
									</div>
									<div>
										<p class="realout"></p>
									</div>
									<div>
										<div class="btn-r">
											<a  onclick="withdrawalend()" href="#layer2" class="btn-layerCloseNew" id="yes">확인</a>
										</div>
										<div class="btn-r">
											<a href="#" class="btn-layerClose" id="no">취소</a>
										</div>
									</div>
								</div>
								<!--// content-->
							</div>
						</div>
					</div>
					<div id="layer2" class="pop-layer">
						<div class="pop-container">
							<div class="pop-conts">
								<!--content //-->
								<div id="inner_pop">
									<div>
										<img src="<%= contextPath %>/images/joonho/approve.png">
									</div>
									<div>
										<p class="realoutend"></p>
									</div>
									<div>
										<div class="btn-r">
											<a href="<%= request.getContextPath() %>/admin/membermanage"  class="btn-layerCloseend" id="yesend">확인</a>
										</div>
									</div>
								</div>
								<!--// content-->
							</div>
						</div>
					</div>
				</div>
				<div id="page">
					<div class="pageBar">
						<%=request.getAttribute("pageBar") %>
					</div>
				</div>
			</div>
		</div>
    </div>
</section>
<!-----------   위에서 HTML 작업  ----------->
<%@ include file="/views/common/footer.jsp" %>
<script src="<%= contextPath %>/js/jquery-3.7.0.min.js"></script>
<script src="<%= contextPath %>/js/script_common.js"></script>
<!-- 본인이 따로 적용할 외부 JS 파일 및 script 태그 -->
<script src="<%= contextPath %>/js/joonho/script_admin_membermanage.js"></script>
<script>
$("#searchType").change(e=>{
	const type=$(e.target).val();
	$(e.target).parent().find("div").css("display","none");
	$("#search-"+type).css("display","inline-block")
})
$(()=>{
			$("#searchType").change();
			$("#numPerpage").change(e=>{
				let url=location.href;
				if(url.includes("?")){
					url=url.substring(0,url.indexOf("?")+1)+'searchType=<%=type%>&searchKeyword=<%=keyword%>&cPage=<%=request.getParameter("cPage")!=null?request.getParameter("cPage"):1%>&numPerpage='+e.target.value;
				}else{
					url+='?'
					url+='cPage=<%=request.getParameter("cPage")!=null?request.getParameter("cPage"):1%>&numPerpage='+e.target.value;
				}
				location.assign(url)
			})
		})
$(document).ready(function() {
	$("input[type='checkbox']").change(function() {
		if($("input[type='checkbox']:checked").length>1){
			 $(this).prop('checked', false);
			alert("1명씩 탈퇴 가능합니다.")
		}
	})
})
const withdrawalend=()=>{
	$.ajax({
		url: "<%=contextPath%>/admin/withdrawal.do", 
	    method: "POST",
	    data: {outid:outid}, 
	    success: function(response) {
	      console.log("데이터 등록 성공!");
	    },
	    error: function(xhr, status, error) {
	      console.error("데이터 등록 실패: " + error);
	    }
	});
}

</script>
<!-------------------------------------------->
</body>
</html>