<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/top.jsp"%>
<%@ include file="/views/common/header.jsp"%>
<link rel = "stylesheet" href = "<%=contextPath %>/css/nabin/notice_insert.css">
<link rel = "stylesheet" href = "<%=contextPath %>/css/nabin/notice.css">
<link rel = "stylesheet" href = "<%=contextPath %>/css/nabin/media.css">
	

<section class="min1280px">
	<div id="sectionContainer" class="max1280px">

	
			<div class="notice_wrap">
				<div class="notice_title">
					<span><strong>스테이지메이트 공지사항</strong></span>
				</div>
				<div class="notice_insert_wrap">
					<div class="notice_insert">
						<form action="<%=request.getContextPath() %>/notice/insertNotice.do" method="post" enctype="multipart/form-data">
							<table id="tbl-notice">
								<tr>
									<th>제 목</th>
									<td><input type="text" name="noticeTitle" required></td>
								</tr>
								<tr>
									<th>작성자</th>
									<td><input type="text" name="noticeWriter"
									value="<%=loginMember.getMemberId()%>" readonly></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><input type="file" name="upFile"></td>
								</tr>
								<tr>
									<th>내 용</th>
									<td><textarea cols="80" rows="20" name="noticeContent"></textarea></td>
								</tr>
								<tr>
								<th colspan="2"><input type="submit" value="등록" onclick="if(!confirm('글이 등록됩니다.\ 글을 등록하시겠습니까?')){return false;}"/>
								</th>
								</tr>
								<!-- <tr>
									<th colspan="2"><input type="submit" value="등록하기"
										onclick=""></th>
										<tr>
										
										]
								</tr> -->
							</table>
							
							<!-- <input type="submit" value="등록하기" onclick -->
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>


		<%@ include file="/views/common/footer.jsp"%>
		<script src="<%= contextPath %>/js/jquery-3.7.0.min.js"></script>
		<script src="<%= contextPath %>/js/script_common.js"></script>