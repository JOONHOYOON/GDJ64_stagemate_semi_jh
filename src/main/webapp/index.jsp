<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp" %>
<link rel="stylesheet" href="<%= contextPath %>/css/jaehun/style_main.css">

<title>STAGEMATE</title>
</head>
<body>
<%@ include file="/views/common/header.jsp" %>
<section class="banners min1280px">
    <div class="banners-wrapper">
        <ul class="banners-container">
            <li>
                <img src="<%= contextPath %>/images/jaehun/main_page/loading_banner.svg">
            </li>
        </ul>
        <ul class="banners-indicator"></ul>
    </div>
</section>

<section class="reservation min1280px">
    <div class="reservation-container max1280px">
        <div class="reservation-title pos-relative">
            <h2 class="fw-bold">곧 예매 오픈!!!</h2>
            <div class="title-absolute">
                <img src="<%= contextPath %>/images/jaehun/main_page/hello.svg" alt="손_흔드는_아이콘">
            </div>
        </div>
        <div class="reservation-calandar">
            <ul class="reservation-calandar-days">
            </ul>
            <div class="calendar_btn_prev">
                <img src="<%= contextPath %>/images/jaehun/main_page/lineup_btn_prev.svg" alt="이전버튼">
            </div>
            <div class="calendar_btn_next">
                <img src="<%= contextPath %>/images/jaehun/main_page/lineup_btn_next.svg" alt="다음버튼">
            </div>
            <article class="reservation-calendar-wrapper">
                <div class="reservation-calendar-lineup animated-smooth">
                </div>
            </article>
        </div>
    </div>
</section>

<section class="goods_and_board min1280px">
    <div class="gb-container max1280px">
        <div class="gb-content">
            <div class="gb-title">
                <h2 class="fw-bold">MATE를 위한 추천 굿즈</h2>
                <div>
                    <img src="<%= contextPath %>/images/jaehun/main_page/goods.svg" alt="굿즈">
                </div>
            </div>
            <div class="goods-lineup">
                <div class="goods-lineup_unit" 
                    style="height: 219px; display: flex; justify-content: center; align-items: center;">
                    <img src='<%= contextPath %>/images/jaehun/main_page/loading_poster.gif' style='width: 64px;'>
                </div>
                <div class="goods-lineup_unit" 
                    style="height: 219px; display: flex; justify-content: center; align-items: center;">
                    <img src='<%= contextPath %>/images/jaehun/main_page/loading_poster.gif' style='width: 64px;'>
                </div>
                <div class="goods-lineup_unit" 
                    style="height: 219px; display: flex; justify-content: center; align-items: center;">
                    <img src='<%= contextPath %>/images/jaehun/main_page/loading_poster.gif' style='width: 64px;'>
                </div>
            </div>
        </div>

        <div class="gb-content">
            <div class="gb-title">
                <h2 class="fw-bold">추천 게시글</h2>
                <div>
                    <img src="<%= contextPath %>/images/jaehun/main_page/star.svg" alt="인기게시글">
                </div>
            </div>
            <table class="board-articles">
                <thead>
                    <tr>
                        <th>제목</th>
                        <th>조회수</th>
                        <th>추천수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="board-title">INSERT TITLE HERE</td>
                        <td class="board-view_count">98</td>
                        <td class="board-like_count">40</td>
                    </tr>
                    <tr>
                        <td class="board-title">INSERT TITLE HERE</td>
                        <td class="board-view_count">87</td>
                        <td class="board-like_count">34</td>
                    </tr>
                    <tr>
                        <td class="board-title">INSERT TITLE HERE</td>
                        <td class="board-view_count">84</td>
                        <td class="board-like_count">33</td>
                    </tr>
                    <tr>
                        <td class="board-title">INSERT TITLE HERE</td>
                        <td class="board-view_count">80</td>
                        <td class="board-like_count">29</td>
                    </tr>
                    <tr>
                        <td class="board-title">INSERT TITLE HERE</td>
                        <td class="board-view_count">64</td>
                        <td class="board-like_count">28</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</section>
<%@ include file="/views/common/footer.jsp" %>
<script src="<%= contextPath %>/js/jquery-3.7.0.min.js"></script>
<script src="<%= contextPath %>/js/script_common.js"></script>
<script src="<%= contextPath %>/js/jaehun/script_main.js"></script>
</body>
</html>