   <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.stagemate.member.model.vo.Member, java.util.Arrays" %>
<%
   Object loginMemberUncast = request.getSession().getAttribute("loginMember");
   Member loginMember = null;
   if (loginMemberUncast != null) {
      loginMember = Member.class.cast(loginMemberUncast);
   }
   
   String saveId = "";
   Cookie[] cookies = request.getCookies();
   if (cookies != null) {
      saveId = Arrays.stream(cookies)
                  .filter(cookie -> cookie.getName().equals("saveId"))
                  .findFirst()
                  .map(cookie -> cookie.getValue())
                  .orElse("");
   }
%>
<header class="min1280px">
    <div class="header-container max1280px">
        <div class="header-container-logo" onclick="toMainPage();">
            <img src="<%= request.getContextPath() %>/images/common/logo_header.svg" alt="로고_헤더">
        </div>
        <nav>
            <ul>
                <li><a href="<%= request.getContextPath() %>" class="sample">홈</a></li>
                <li><a href="<%= request.getContextPath() %>/musical.do">뮤지컬</a></li>
                <li><a href="<%= request.getContextPath() %>/act.do">연극</a></li>
                <li><a href="<%= request.getContextPath() %>/concert.do">콘서트</a></li>
                <li><a href="<%= request.getContextPath()%>/store/productList.do">스토어</a></li>
                <li><a href="<%= request.getContextPath()%>/board/boardList.do">커뮤니티</a></li>
            </ul>
        </nav>
        <div class="w-20p">
        </div>
        <div class="header-container-icons">
	        <div>
	        <% if (loginMember == null) { %>
	            <p class="icons_text_upper">GUEST</p>
	            <input type="button" value="" 
	            		onclick="toLoginPage();"  
	            		style="background-image: url('<%= request.getContextPath() %>/images/common/icon_logout.svg')">
	            <p class="icons_text_lower fw-bold">로그인</p>
            <% } else { %>
               <p class="icons_text_upper"><%= loginMember.getMemberNm()%></p>
               <input type="button" value=""
                     onmouseenter="showModalLogOut();"  
                     style="background-image: url('<%= request.getContextPath() %>/images/common/icon_login.svg')">
            <% } %>
	        </div>
            <div>
                <input type="button" value="" onclick="myCart();"
                	style="background-image: url('<%= request.getContextPath() %>/images/common/icon_cart.svg')">
                <p class="icons_text_lower fw-bold">장바구니</p>
            </div>
            <div>
                <input type="button" value="" 
                	style="background-image: url('<%= request.getContextPath() %>/images/common/icon_notice.svg')"
                	onclick="location.assign('<%=request.getContextPath()%>/notice//noticeList.do');">
                <p class="icons_text_lower fw-bold">공지사항</p> 
            </div>
        </div>
        <div class="modal-logout-container">
         <div class="logout-content_msg">
            <% if (loginMember != null) { %>
               <% if (loginMember.getMemberId().equals("stageadmin")) { %>
                  <h5><a href="<%= request.getContextPath() %>/myBatisMemberList.do">관리자 페이지</a></h5>
               <% } else { %>
                  <h5><a href="<%= request.getContextPath()%>/Detail/DetailListServlet.do">마이 페이지</a></h5>
            <% } } %>
            <div></div>
            <h5><a href="<%= request.getContextPath() %>/member/logout.do">로그아웃</a></h5>
         </div>
         <div class="logout-content_close">
            <input type="button" value="" 
            onclick="closeModalLogOut();"
                  style="background-image: url('<%= request.getContextPath() %>/images/common/profile-btn_close.svg')">
         </div>
      </div>
    </div>
</header>
<script>
function showModalLogOut() {
   const btnClose = $(".logout-content_close");
   btnClose.width("8%");
   btnClose.height(btnClose.width());
   
   $(".modal-logout-container").css("transition", "all 1s")
                     .addClass("modal-logout-show");
}

function closeModalLogOut() {
   $(".modal-logout-container").css("transition", "")
                  .removeClass("modal-logout-show");
}
function myCart(){
 <% if(loginMember != null) {%>
    location.assign('<%=request.getContextPath()%>/store/selectCartList.do?id=<%=loginMember.getMemberId()%>');
 <% } else { %>
    alert("로그인 후 이용가능한 서비스입니다.");
   location.assign('<%=request.getContextPath()%>/login.do');
 <% } %>
}
function myCart(){
 <% if(loginMember != null) {%>
	 location.assign('<%=request.getContextPath()%>/store/selectCartList.do?id=<%=loginMember.getMemberId()%>');
 <% } else { %>
 	alert("로그인 후 이용가능한 서비스입니다.");
	location.assign('<%=request.getContextPath()%>/login.do');
 <% } %>
}
</script>