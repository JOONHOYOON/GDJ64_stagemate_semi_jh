<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp"%>
<%@ page
	import="java.util.List,com.stagemate.event.model.vo.Event,com.stagemate.event.model.vo.EventUpfile,com.stagemate.event.model.vo.EventSchedule,com.stagemate.event.model.vo.Seat,com.stagemate.event.model.vo.EventWish,com.stagemate.review.model.vo.EventReviewTBJH"%>
<%
	List<Seat> seats = (List) request.getAttribute("seats");
	Event event = (Event) request.getAttribute("event");
	List<EventUpfile> files = (List) request.getAttribute("files");
	List<EventSchedule> es = (List) request.getAttribute("es");
	List<EventWish> ew = (List) request.getAttribute("ew");
	List<EventReviewTBJH> ertb = (List) request.getAttribute("ertb");
%>
<!-- 본인이 따로 적용할 CSS 파일 및 style 태그 -->
<link rel="stylesheet"
	href="<%=contextPath%>/css/joonho/style_event.css">
<style>
#review_event>div:first-child {
	display:flex;
	color:var(--jh-red);
}
#review_event>div:nth-child(2) {
	display:flex;
	justify-content: flex-end;
	align-items: center;
	margin-right: 2%;
	height:95px;
}
#review_event>div:nth-child(2)> *{
	margin-left:2%; 
}
#review_event>div:nth-child(2)>div{
	display:flex;
	align-items: center;
}
#review_event>div:nth-child(2)>div>img{
	margin-right: 14%;
}
#review_event>div:nth-child(2)>h4{
	font-weight: bolder;
	font-size: 22px;
}iv:last-child>div>div:last-child{
	display:flex;
    justify-content: flex-end;
}
#review_event>div:last-child>div>div:last-child>*{
	margin-left: 1%;
}
#review_event>div:last-child>div>div:first-child {
	font-weight: bolder;
	font-size: 25px;
    margin-bottom: 0.6%;
}
#review_event>div:last-child>div>div:nth-child(2) {
	margin-bottom: 0.6%;
}
#review_event>div:last-child>div>div:last-child{
	display:flex;
    justify-content: flex-end;
}
</style>
<!---------------------------------------->
<title>STAGEMATE/<%=event.getEventNm()%></title>
</head>
<body>
	<%@ include file="/views/common/header.jsp"%>
	<!-----------   아래에서 HTML 작업  ----------->
	<section class="min1280px">
		<div class="max1280px">
			<div id="gold_maincontainer">
				<!-- 제목장소등 -->
				<div id="gold_title">
					<h1><%=event.getEventNm()%></h1>
					<div>
						<h4><%=event.getEventStartDt()%>~<%=event.getEventEndDt()%></h4>
						<h3>|</h3>
						<h4><%=event.getLocation()%></h4>
						<img id="movemap" src="<%=contextPath%>/images/joonho/map.png"
							width="24" height="24">
					</div>
				</div>
				<hr>
				<!-- 포스터 간단한 내용 -->
				<div id="gold_poster">
					<!-- 포스터 -->
					<div>
						<%
						for (EventUpfile f : files) {
										if ((f.getPurposeNo().equals("PUR1"))) {
						%>
						<img src="<%=contextPath%>/upload/joonho/<%=f.getEuRename()%>"
							width="320" height="450">
						<%
						}}
						%>
					</div>
					<!-- 간단내용 -->
					<div id="gold_content">
						<!-- 등급 -->
						<div>
							<div>
								<h3>등급</h3>
							</div>
							<div>
								<h3><%=event.getEventAge()%>세 이상 관람가
								</h3>
							</div>
						</div>
						<!-- 관람시간 -->
						<div>
							<div>
								<h3>관람시간</h3>
							</div>
							<div>
								<h3><%=event.getEventDuration()%>분<%
								if(event.getEventInter()>0){
								%>(인터미션
									<%=event.getEventInter()%>분 포함)<%
								}
								%>
								</h3>
							</div>
						</div>
						<!-- 가격 -->
						<div>
							<div>
								<h3>가격</h3>
							</div>
							<%
							if(event.getEvcNo().equals("EVC1")){
							%>
							<div id="money" class="money">
								<div>
									<h3>VIP석</h3>
									<h3>150,000원</h3>
								</div>
								<div>
									<h3>R석</h3>
									<h3>120,000원</h3>
								</div>
								<div>
									<h3>S석</h3>
									<h3>90,000원</h3>
								</div>
								<div>
									<h3>A석</h3>
									<h3>70,000원</h3>
								</div>
							</div>
							<%
							}else if(event.getEvcNo().equals("EVC2")){
							%>
							<div id="money" class="money">
								<div>
									<h3>스탠딩석</h3>
									<h3>80,000원</h3>
								</div>
								<div>
									<h3>지정석</h3>
									<h3>80,000원</h3>
								</div>
							</div>
							<%
							}else if(event.getEvcNo().equals("EVC3")){
							%>
							<div id="money" class="money">
								<div>
									<h3>전석</h3>
									<h3>50,000원</h3>
								</div>
							</div>
							<%
							}
							%>
						</div>
					</div>
					<!-- 아이콘 -->
					<div id="gold_icon">
						<div>
							<button >
							<%String hearthave="blackheart";String classheart="empty";int ewsize=0;
									if(ew.size()!=0){
									for(EventWish ews : ew){ %> 
										<%
										if(loginMember!=null&&event.getEventNo().equals(ews.getEventNo())&&loginMember.getMemberId().equals(ews.getMemberId())){ 
											hearthave="fillheart"; classheart="fill";
										}
										%>
									<%
										if(event.getEventNo().equals(ews.getEventNo()))
										{ewsize++;}%>
									<%}}%>
								<img onclick="switchheart(event,'<%=event.getEventNo() %>');" src="<%=contextPath%>/images/joonho/<%=hearthave %>.svg" class="<%=classheart%>">
								<p><%=ewsize %></p>
							</button>
							<img id="urlcopy"
								src="<%=contextPath%>/images/joonho/urlcopy.png"
								onclick="urlcopy();">
						</div>
					</div>
				</div>
				<hr>
				<div id="gold_choice">
					<!-- 달력예매칸 -->
					<div id="reservation">
						<!-- 달력 -->
						<div>
							<div>
								<h2 class="gold_h2">날짜/시간선택</h2>
								<hr>
							</div>
							<div id="reservation_calendar">
								<div id=gold_calender>
									<table class="Calendar">
										<thead>
											<tr>
												<td onClick="prevCalendar();" style="cursor: pointer;">&#60;</td>
												<td colspan="5"><span id="calYear"></span>년 <span
													id="calMonth"></span>월</td>
												<td onClick="nextCalendar();" style="cursor: pointer;">&#62;</td>
											</tr>
											<tr>
												<td>일</td>
												<td>월</td>
												<td>화</td>
												<td>수</td>
												<td>목</td>
												<td>금</td>
												<td>토</td>
											</tr>
										</thead>

										<tbody>
										</tbody>
									</table>
								</div>
								<div id="gold_bar"></div>
								<div>
									<div id="gold_button"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- 예매 -->
					<div id="gold_seat">
						<div>
							<h2 class="gold_h2">예매 가능좌석</h2>
						</div>
						<hr>
						<%
							if(event.getEvcNo().equals("EVC1")){
						%>
						<div id="seat_money" class="chiocemoney">
							<div>
								<h3>VIP석 150,000원</h3>
								<h3></h3>
							</div>
							<div>
								<h3>R석 120,000원</h3>
								<h3>
									
								</h3>
							</div>
							<div>
								<h3>S석 90,000원</h3>
								<h3>
									
								</h3>
							</div>
							<div>
								<h3>A석 70,000원</h3>
								<h3>
									
								</h3>
							</div>
						</div>
						<%
							}else if(event.getEvcNo().equals("EVC2")){
						%>
						<div id="seat_money" class="chiocemoney">
							<div>
								<h3>스탠딩석 : 80,000원</h3>
								<h3></h3>
							</div>
							<div>
								<h3>지정석 : 80,000원</h3>
								<h3></h3>
							</div>
						</div>
						<%
							}else if(event.getEvcNo().equals("EVC3")){
						%>
						<div id="seat_money" class="chiocemoney">
							<div>
								<h3>전석 : 80,000원</h3>
								<h3></h3>
							</div>
						</div>
						<%} %>
						<div>
							<button
								onclick="toReservationMusical('<%=event.getEvcNo()%>','<%=event.getEventNo()%>');"
								id="res_cho" style="pointer-events: none">예매 하기</button>
						</div>
						<div id="pointmark">
							<img src="<%=contextPath%>/images/joonho/pointmark.png">
							<h4>회차를 선택해야 예매할 수 있습니다.</h4>
						</div>
					</div>
				</div>
				<!-- 상세내용 -->
				<div>
					<div id="gold_details">
						<div id="detail_information"
							style="border-bottom: 14px solid black; font-weight: bolder">
							<a>상세정보</a>

						</div>
						<div id="reservation_cancel">
							<a>예매/취소 안내</a>
						</div>
						<div id="gold_review">
							<a>리뷰</a>
						</div>
						<div id="gold_location">
							<a>장소</a>
						</div>
					</div>
					<hr>
					<div class="gold_info">
						<%
					for (EventUpfile f : files) {
									if ((f.getPurposeNo().equals("PUR2"))) {
					%>
						<div id="detail_information_img"
							style="display: inline-flex; flex-direction: column; align-items: center;">
							<img src="<%=contextPath%>/upload/joonho/<%=f.getEuRename()%>">
						</div>
						<%
						}}
						%>
						<div id="reservation_cancel_info" style="display: none">
							<img src="<%=contextPath%>/images/joonho/cancel1.PNG">
							<img src="<%=contextPath%>/images/joonho/cancel2.PNG">
							<img src="<%=contextPath%>/images/joonho/cancel3.PNG">
						</div>
						<div id="review_event" style="display: none">
							<div>
								<img src="<%=contextPath%>/images/joonho/safety.png">
								<div>
								<p>리뷰는 해당 공연을 관람한 MATE에 한해서만 작성할 수 있습니다.</p>
								<p>매매,욕설 증 운영 규정에 위반되는 글은 사전 통보없이 삭제될 수 있습니다.</p>
								</div>
							</div>
							<div>
								<%int fun=0;int wow=0;int sad=0;int umm=0;int none=0;
								if(ertb==null||ertb.isEmpty()){
								}else{ for(EventReviewTBJH er:ertb){
									if(er.getImojiNo()==1){
										fun++;
									}else if(er.getImojiNo()==2){
										wow++;
									}else if(er.getImojiNo()==3){
										sad++;
									}else if(er.getImojiNo()==4){
										umm++;
									}else{
										none++;
									}
								}}%>
								<h4>반응</h4>
								<div>
									<img src="<%=contextPath%>/images/yoonjin/emoji/fun.png">
									<p><%=fun %></p>
								</div>
								<div>
									<img src="<%=contextPath%>/images/yoonjin/emoji/wow.png">
									<p><%=wow %></p>
								</div>
								<div>
									<img src="<%=contextPath%>/images/yoonjin/emoji/sad.png">
									<p><%=sad %></p>
								</div>
								<div>
									<img src="<%=contextPath%>/images/yoonjin/emoji/umm.png">
									<p><%=umm %></p>
								</div>
								<div>
									<img src="<%=contextPath%>/images/yoonjin/emoji/none.png">
									<p><%=none %></p>
								</div>
							</div>
							<div>
							<%String emoji=null;
							if(ertb==null||ertb.isEmpty()){%>
								<a>행사에 대한 리뷰가 없습니다.</a>
							<% }else{
							for(EventReviewTBJH er:ertb){ 
								if(er.getImojiNo()==1){
									emoji="/images/yoonjin/emoji/fun.png";
								}else if(er.getImojiNo()==2){
									emoji="/images/yoonjin/emoji/wow.png";
								}else if(er.getImojiNo()==3){
									emoji="/images/yoonjin/emoji/sad.png";
								}else if(er.getImojiNo()==4){
									emoji="/images/yoonjin/emoji/umm.png";
								}else{
									emoji="/images/yoonjin/emoji/none.png";
								}
							
							%>
							
								<div>
									<div>
									<%=er.getMemberId() %>
									</div>
									<div>
									<%=er.getErvContent() %>
									</div>
									<div>
										<img src="<%=contextPath%><%=emoji%>">
										<p>작성일 <%=er.getErvDate() %></p>
									</div>
								</div>
							<%}} %>
							</div>
							
						</div>
						<div id="gold_details_map" style="display: none">
							<div>
								<h1><%=event.getLocation()%></h1>
							</div>
							<div id="map" style="width: 80%; height: 650px;"></div>
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
	<script id="script" type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51321917c05ca5a38fbce7ed8b6a981c"></script>
	<script src="<%=contextPath%>/js/joonho/script_event.js"></script>
	<script>
	const switchheart=(e,eventNo)=>{
		if(<%=loginMember==null%>){
			alert("로그인 후 관심등록이 가능합니다.")
		}else{
			let countheart=parseInt($(e.target).next().text())
			if ($(e.target).hasClass("empty")) {
		      $(e.target)
		        .attr("src", "<%=contextPath%>/images/joonho/fillheart.svg")
		        .addClass("fill")
		        .removeClass("empty");
		      $(e.target).next().text(countheart + 1);
		      
		      $.ajax({
		        url: "<%=contextPath%>/event/addHeart.do", 
		        method: "POST",
		        data: {eventNo:eventNo , memberId:'<%=loginMember!=null?loginMember.getMemberId():""%>' }, 
		        success: function(response) {
		          alert("관심목록에 등록하였습니다!")
		        },
		        error: function(xhr, status, error) {
		          alert("관심목록에 등록에 실패하셨습니다. 다시시도해주세요")
		          console.error("데이터 등록 실패: " + error);
		        }
		      });
		
		    } else {
		      $(e.target)
		        .attr("src", "<%=contextPath%>/images/joonho/blackheart.svg")
		        .addClass("empty")
		        .removeClass("fill");
		      $(e.target).next().text(countheart - 1);
		
		      $.ajax({
		        url: "<%=contextPath%>/event/removeHeart.do", 
		        method: "POST", 
		        data: { eventNo:eventNo , memberId:'<%=loginMember!=null?loginMember.getMemberId():""%>' }, 
		        success: function(response) {
		        	alert("관심목록에서 삭제하였습니다!")
		        },
		        error: function(xhr, status, error) {
		          // 요청이 실패한 경우의 처리
		          alert("관심목록 삭제에 실패하였습니다. 다시시도해주세요")
		          console.error("데이터 삭제 실패: " + error);
		        }
		      });
		    } 
		}
	}
	/* 지도 위치 지정 */
	let jsonMap ={
			"광림아트센터 BBCH홀" : ["37.523898", "127.025587"],
			"예스24스테이지 3관" : ["37.582705", "127.003203"],
			"예스24스테이지 2관" : ["37.582705", "127.003203"],
			"예스24스테이지 1관" : ["37.582705", "127.003203"],
			"샤롯데씨어터" : ["37.510693", "127.099874"],
			"대학로 해피씨어터" : ["37.581846", "127.002567"],
			"홍대 제이엘씨어터" : ["37.553111", "126.922218"],
			"예그린 씨어터" : ["37.583870", "127.003045"],
			"대학로 틴틴홀" : ["37.581561", "127.003548"],
			"올림픽공원 올림픽홀" : ["37.514626", "127.127601"],
			"KBS 울산홀" : ["35.544506", "129.326446"],
			"KBS아레나" : ["37.556730", "126.847916"],
			"대학로 드림아트센터 3관" : ["37.583289", "127.003272"],
			"대학로 드림아트센터 2관" : ["37.583289", "127.003272"],
			"예술의전당 오페라극장" : ["37.479288", "127.013810"],
			"대학로 유니플렉스 2관" : ["37.581166", "127.003695"],
			"대학로 TOM 1관" : ["37.582263", "127.003670"],
			"대학로 바탕골 소극장" : ["37.581843", "127.002533"],
			"대학로 아트원씨어터 3관" : ["37.580214", "127.003946"],
			"BNK부산은행조은극장 2관" : ["35.098347", "129.032324"],
			"상명아트센터 계당홀" : ["37.602973", "126.956398"],
			"YES24 LIVE HALL" : ["37.545808", "127.107898"],
			"대구 엑스코 5층 컨벤션홀" : ["35.906782", "128.613267"],
			"전주종합경기장" : ["35.838898", "127.126406"],
			"국립극장 해오름극장" : ["37.552585", "126.999725"],
			"플러스씨어터" : ["37.580823", "127.003980"],
			"대구 수성아트피아 용지홀" : ["35.829468", "128.628376"],
			"드림씨어터" : ["35.148331", "129.065423"],
			"대전시립연정국악원 큰마당" : ["36.366006", "127.389830"],
			"북촌나래홀" : ["37.578905", "126.988956"],
			"잠실실내체육관" : ["37.516292", "127.075931"],
			"KSPO DOME(올림픽체조경기장)" : ["37.519297", "127.127329"],
			"인천문화예술회관 대공연장" : ["37.447846", "126.700134"],
			
	}
	var GPSX=jsonMap["<%=event.getLocation()%>"][0]
	var GPSY=jsonMap["<%=event.getLocation()%>"][1]
	/* 달력 */
	var startDay=new Date('<%=event.getEventStartDt()%>');
	var endDay=new Date('<%=event.getEventEndDt()%>');
	startDay.setDate(startDay.getDate()-1);
	var monday=[];
	var tuesday=[];
	var wednesday=[];
	var thursday=[];
	var friday=[];
	var saturday=[];
	var sunday=[];
	var arrowday=[]
	<%for(EventSchedule e:es){%>
	switch('<%=e.getEsDay()%>'){
		case '월' : monday.push('<%=e.getEsStartTime() %>'); break;
		case '화' : tuesday.push('<%=e.getEsStartTime() %>'); break;
		case '수' : wednesday.push('<%=e.getEsStartTime() %>'); break;
		case '목' : thursday.push('<%=e.getEsStartTime() %>'); break;
		case '금' : friday.push('<%=e.getEsStartTime() %>'); break;
		case '토' : if(saturday[0]==null){ 
						saturday.push('<%=e.getEsStartTime() %>'); break;
					 }else if(saturday[0]!=null&&saturday[0]!='<%=e.getEsStartTime() %>'){
						saturday.push('<%=e.getEsStartTime() %>'); break;
					} 
		case '일' : if(sunday[0]==null){ 
						sunday.push('<%=e.getEsStartTime() %>');break;
					}else if(saturday[0]!=null&&sunday[0]!='<%=e.getEsStartTime() %>'){
						sunday.push('<%=e.getEsStartTime() %>'); break;
					} 
		
	}
	arrowday.push('<%=e.getEsDay()%>')
	<%}%>
	var daysgo=new Set(arrowday);
	/* 버튼 로그인 후 선택 가능 */
	let flag=true;
	const roundchoice=(e)=>{
	<%if (loginMember == null) {%>
		alert("로그인 후 사용 가능합니다.")
	<%} else {%> 
			if(flag==true){
				$(e.target).css({ "backgroundColor": "var(--sm-brown)", "color": "white" });
				$("#pointmark").css({"visibility":"hidden"});
				$("#gold_seat").css({"color":"black"});
				$("#res_cho").css({"border":"none","backgroundColor":"var(--sm-yellow)","color":"black","cursor":"pointer","pointer-events":"auto"});
				$("#seat_money>div>h3:odd").css({"color":"#bc0000"});
				flag=false;
			}else{
				$(e.target).css({ "backgroundColor": "white", "color": "black" })
				$("#pointmark").css({"visibility":"visible"});
				$("#gold_seat").css({"color":"rgb(0,0,0,0.3)"});
				$("#res_cho").css({"border":"1px solid rgb(0,0,0,0.3)","backgroundColor":"white","color":"rgb(0,0,0,0.3)","pointer-events":"none"});
				$("#seat_money>div>h3:odd").css({"color":"rgb(0,0,0,0.3)"});
				flag=true;
			}
	 <% } %> 
	}
	var todays=new Date();
	var openday=new Date('<%=event.getRsvOpenDt()%>');
	var opendays=openday.getFullYear()+'년'+(openday.getMonth() + 1)+'월'+openday.getDate()+'일';
	
	let esdatecheck=new Date();
	var esNo="";
	let vip=0;
	let r=0;
	let s=0;
	let a=0;
	let f1=0;
	let f2=0;
	let allseat=0;
	$(document).on("click","#schedule",function(e){
		vip=0,r=0,s=0,a=0,f1=0,f2=0,allseat=0;
		<%for(Seat seat:seats){%>
			esdatecheck=new Date('<%=seat.getEsDate()%>')
			if('<%=event.getEvcNo()%>'=="EVC1"){
				if(esdatecheck.getDate()==$(".choiceDay").text()){
					esNo='<%=seat.getEsNo()%>'
					switch('<%=seat.getSeatRow()%>'){
					case 'A' : if('<%=seat.getIsReserved()%>'=='N'){
									vip++;break;
								}
					case 'B' : if('<%=seat.getIsReserved()%>'=='N'){
									vip++;break;
								}
					case 'C' : if('<%=seat.getIsReserved()%>'=='N'){
									r++;break;
								}
					case 'D' : if('<%=seat.getIsReserved()%>'=='N'){
									r++;break;
								}
					case 'E' : if('<%=seat.getIsReserved()%>'=='N'){
									s++;break;
								}
					case 'F' : if('<%=seat.getIsReserved()%>'=='N'){
									s++;break;
								}
					case 'G' : if('<%=seat.getIsReserved()%>'=='N'){
									s++;break;
								}
					case 'H' : if('<%=seat.getIsReserved()%>'=='N'){
									a++;break;
								}
					case 'I' : if('<%=seat.getIsReserved()%>'=='N'){
									a++;break;
								}
					case 'J' : if('<%=seat.getIsReserved()%>'=='N'){
									a++;break;
								}
					case 'K' : if('<%=seat.getIsReserved()%>'=='N'){
									a++;break;
								}
					case 'L' : if('<%=seat.getIsReserved()%>'=='N'){
									a++;break;
								}
				}
						
				}
				$("#seat_money>div:first-child>h3:last-child").text('(잔여 : '+((vip-4) ==0?"매진":(vip-4)+"석)"))
				$("#seat_money>div:nth-child(2)>h3:last-child").text('(잔여 : '+((r-4) ==0?"매진":(r-4)+"석)"))
				$("#seat_money>div:nth-child(3)>h3:last-child").text('(잔여 : '+((s-6) ==0?"매진":(s-6)+"석)"))
				$("#seat_money>div:last-child>h3:last-child").text('(잔여 : '+((a-10) ==0?"매진":(a-10)+"석)"))
			}else if('<%=event.getEvcNo()%>'=="EVC2"){
				if(esdatecheck.getDate()==$(".choiceDay").text()){
					esNo='<%=seat.getEsNo()%>'
					switch('<%=seat.getSeatRow()%>'){
						case 'A' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'B' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'C' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'D' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'E' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'F' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'G' : if('<%=seat.getIsReserved()%>'=='N'){
										f1++;break;
									}
						case 'H' : if('<%=seat.getIsReserved()%>'=='N'){
										f2++;break;
									}
						case 'I' : if('<%=seat.getIsReserved()%>'=='N'){
										f2++;break;
									}
						case 'J' : if('<%=seat.getIsReserved()%>'=='N'){
										f2++;break;
									}
						case 'K' : if('<%=seat.getIsReserved()%>'=='N'){
										f2++;break;
									}
						case 'L' : if('<%=seat.getIsReserved()%>'=='N'){
										f2++;break;
									}
					}
						
				}
				$("#seat_money>div:first-child>h3:last-child").text('(잔여 : '+((f1-14) ==0?"매진":(f1-14)+"석)"))
				$("#seat_money>div:last-child>h3:last-child").text('(잔여 : '+((f2-10) ==0?"매진":(f2-10)+"석)"))
			}else{
				if(esdatecheck.getDate()==$(".choiceDay").text()&&'<%=seat.getIsReserved()%>'=='N'){
					esNo='<%=seat.getEsNo()%>'
					allseat++;
				}
				$("#seat_money>div:first-child>h3:last-child").text('(잔여 : '+((allseat-18) ==0?"매진":(allseat-18)+"석)"))
			}
		<%}%>
		roundchoice(e);
	});
	
</script>
	<!-------------------------------------------->
</body>
</html>