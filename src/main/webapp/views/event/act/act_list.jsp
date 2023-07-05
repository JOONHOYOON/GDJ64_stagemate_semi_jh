<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp"%>
<%@ page
	import="java.util.List,com.stagemate.event.model.vo.Event,com.stagemate.event.model.vo.EventUpfile,com.stagemate.event.model.vo.EventWish,com.stagemate.review.model.vo.EventReviewTBJH"%>
<%
List<Event> acts = (List) request.getAttribute("act");
List<EventUpfile> files = (List) request.getAttribute("files");
List<EventWish> ew = (List) request.getAttribute("ew");
List<EventReviewTBJH> er = (List) request.getAttribute("er");
String text = (String) request.getAttribute("text");
String theme = request.getParameter("theme");
String searchtext = request.getParameter("searchtext");
%>
<!-- 본인이 따로 적용할 CSS 파일 및 style 태그 -->
<link rel="stylesheet"
	href="<%=contextPath%>/css/joonho/style_event_main.css">
<!---------------------------------------->
<title>STAGEMATE/연극</title>
</head>
<body>
	<%@ include file="/views/common/header.jsp"%>
	<!-----------   아래에서 HTML 작업  ----------->
	<section class="min1280px">
		<div class="max1280px">
			<div id="maincontainer">
				<div id="musical">
					<h2>연극</h2>
					<div id="chioce_array">
						<a onclick="changebolder(event)" class="bolderarray">마감일자순</a> | <a
							onclick="changebolder(event)">인기도순</a> | <a
							onclick="changebolder(event)">리뷰많은 순</a> | <a
							onclick="changebolder(event)">제목순</a>
					</div>
					<br>
					<form id="event_search">
						<div id="event_search">
							<input id="input_search_text" type="text" placeholder="Search..."
								value="<%=theme != null ? searchtext : ""%>">
							<div id="search_button">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
									xmlns="http://www.w3.org/2000/svg">
	                        <path
										d="M21.5 23.25L13.625 15.375C13 15.875 12.2812 16.2708 11.4688 16.5625C10.6562 16.8542 9.79167 17 8.875 17C6.60417 17 4.6825 16.2133 3.11 14.64C1.5375 13.0667 0.750833 11.145 0.75 8.875C0.75 6.60417 1.53667 4.6825 3.11 3.11C4.68333 1.5375 6.605 0.750833 8.875 0.75C11.1458 0.75 13.0675 1.53667 14.64 3.11C16.2125 4.68333 16.9992 6.605 17 8.875C17 9.79167 16.8542 10.6562 16.5625 11.4688C16.2708 12.2812 15.875 13 15.375 13.625L23.25 21.5L21.5 23.25ZM8.875 14.5C10.4375 14.5 11.7658 13.9529 12.86 12.8588C13.9542 11.7646 14.5008 10.4367 14.5 8.875C14.5 7.3125 13.9529 5.98417 12.8588 4.89C11.7646 3.79583 10.4367 3.24917 8.875 3.25C7.3125 3.25 5.98417 3.79708 4.89 4.89125C3.79583 5.98542 3.24917 7.31333 3.25 8.875C3.25 10.4375 3.79708 11.7658 4.89125 12.86C5.98542 13.9542 7.31333 14.5008 8.875 14.5Z"
										fill="white" />
	                    </svg>
							</div>
						</div>
					</form>
					<div id="choice">
						<div>
							<p>전체</p>
							<input type="radio" name="searchtheme"
								<%=theme == null || theme.equals("전체") ? "checked" : ""%> value="전체">
						</div>
						<div>
							<p>제목</p>
							<input type="radio" name="searchtheme"
								<%=theme != null && theme.equals("제목") ? "checked" : ""%> value="제목">
						</div>
						<div>
							<p>장소</p>
							<input type="radio" name="searchtheme"
								<%=theme != null && theme.equals("장소") ? "checked" : ""%> value="장소">
						</div>
					</div>
					<br> <br> <br>
					<div class="musical_content">
						<%
						if (acts.isEmpty()) {
						%>
						<div>등록된 연극이 없습니다. 확인 후 등록 해주세요</div>
						<%
						} else {
						for (Event a : acts) {
							for (EventUpfile u : files) {
						%>
						<%
						if ((a.getEventNo().equals(u.getEventNo())) && (u.getPurposeNo().equals("PUR1"))) {
						%>
						<div class="musical_product">
							<img src="<%=contextPath%>/upload/joonho/<%=u.getEuRename()%>"
								onclick="openprev('<%=a.getRsvOpenDt()%>','<%=a.getEventNo()%>')"
								width="250" height="350">
							<h4><%=a.getEventNm()%></h4>
							<h5><%=a.getLocation()%></h5>
							<div>
								<div class="like">
									<%
									String hearthave = "heart";
									String classheart = "empty";
									int ewsize = 0;
									if (ew != null) {
										for (EventWish ews : ew) {
									%>
									<%
									if (loginMember != null && a.getEventNo().equals(ews.getEventNo())
											&& loginMember.getMemberId().equals(ews.getMemberId())) {
										hearthave = "fillheart";
										classheart = "fill";
									}
									%>
									<%
									if (a.getEventNo().equals(ews.getEventNo())) {
										ewsize++;
									}
									%>
									<%
									}
									}
									%>
									<div id="likeheart">
										<img onclick="switchheart(event,'<%=a.getEventNo()%>');"
											src="<%=contextPath%>/images/joonho/<%=hearthave%>.svg"
											class="<%=classheart%>">
									</div>
									<p><%=ewsize%></p>
								</div>
								<%
								int reviewcount = 0;
								{
									if (er != null) {
										for (EventReviewTBJH ers : er) {
									if (ers.getEventNo().equals(a.getEventNo())) {
										reviewcount++;
									}
										}
									}
								}
								%>
								<div class="like">
									<div>
										<img src="<%=contextPath%>/images/joonho/text.svg" alt="">
									</div>
									<p><%=reviewcount%></p>
								</div>
							</div>
						</div>
						<%
						}
						%>
						<%
						}
						}
						}
						%>
					</div>
					<div id="page">
						<div class="pageBar">
							<%=request.getAttribute("pageBar")%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-----------   위에서 HTML 작업  ----------->
	<%@ include file="/views/common/footer.jsp"%>
	<script src="<%=contextPath%>/js/jquery-3.7.0.min.js"></script>
	<script src="<%=contextPath%>/js/script_common.js"></script>
	<!-- 본인이 따로 적용할 외부 JS 파일 및 script 태그 -->
	<script>
	if('<%=text%>'==null||'<%=text%>'=='마감일자순'){
		$("#chioce_array>a:first-child").addClass("bolderarray")
		$("#chioce_array>a:first-child").siblings().removeClass("bolderarray")
	}else if('<%=text%>'=='인기도순'){
		$("#chioce_array>a:nth-child(2)").addClass("bolderarray")
		$("#chioce_array>a:nth-child(2)").siblings().removeClass("bolderarray")
	}else if('<%=text%>'=='리뷰많은 순'){
		$("#chioce_array>a:nth-child(3)").addClass("bolderarray")
		$("#chioce_array>a:nth-child(3)").siblings().removeClass("bolderarray")
	}else if('<%=text%>'=='제목순'){
		$("#chioce_array>a:nth-child(4)").addClass("bolderarray")
		$("#chioce_array>a:nth-child(4)").siblings().removeClass("bolderarray")
	}
	const changebolder=(e)=>{
		location.href="<%=contextPath%>/event/arrayact.do?text="+$(e.target).text()
	}
	const switchheart=(e,eventNo)=>{
		if(<%=loginMember == null%>){
			alert("로그인 후 관심등록이 가능합니다.")
		}else{
			let countheart=parseInt($(e.target).parent().next().text())
			if ($(e.target).hasClass("empty")) {
		      $(e.target)
		        .attr("src", "<%=contextPath%>/images/joonho/fillheart.svg")
		        .addClass("fill")
		        .removeClass("empty");
		      $(e.target).parent().next().text(countheart + 1);
		      
		      $.ajax({
		        url: "<%=contextPath%>/event/addHeart.do", 
		        method: "POST",
		        data: {eventNo:eventNo , memberId:'<%=loginMember != null ? loginMember.getMemberId() : ""%>' }, 
		        success: function(response) {
		          console.log("데이터 등록 성공!");
		        },
		        error: function(xhr, status, error) {
		          console.error("데이터 등록 실패: " + error);
		        }
		      });
		
		    } else {
		      $(e.target)
		        .attr("src", "<%=contextPath%>/images/joonho/heart.svg")
		        .addClass("empty")
		        .removeClass("fill");
		      $(e.target).parent().next().text(countheart - 1);
		
		      $.ajax({
		        url: "<%=contextPath%>/event/removeHeart.do", 
		        method: "POST", 
		        data: { eventNo:eventNo , memberId:'<%=loginMember != null ? loginMember.getMemberId() : ""%>' }, 
		        success: function(response) {
		          console.log("데이터 삭제 성공!");
		        },
		        error: function(xhr, status, error) {
		          // 요청이 실패한 경우의 처리
		          console.error("데이터 삭제 실패: " + error);
		        }
		      });
		    } 
		}
	}
	const openprev=(e,n)=>{
		location.assign(getContextPath() + "/event/eventView.do?no=" + n);
	}
	$("#search_button").click(e=>{
		var theme=$('input[name=searchtheme]:checked').val()
		var searchtext=$('#input_search_text').val()
		if(searchtext==""){
			alert("검색어를 입력해주세요")
		}else{
			location.assign(getContextPath()+"/event/actsearch.do?theme="+theme+"&searchtext="+searchtext)
		}
	})
	</script>
	<!-------------------------------------------->
</body>
</html>