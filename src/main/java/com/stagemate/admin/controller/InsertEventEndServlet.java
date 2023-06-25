package com.stagemate.admin.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.stagemate.event.model.vo.Event;
import com.stagemate.event.model.vo.EventUpfile;
import com.stagemate.event.service.EventService;

@WebServlet("/admin/insertEventEnd.do")
public class InsertEventEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertEventEndServlet() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		if (!ServletFileUpload.isMultipartContent(request)) {
			System.out.println("진입 실패");
			return;
		}

		String path = getServletContext().getRealPath("/upload/joonho");
		int maxSize = 1024 * 1024 * 10;
		String encode = "UTF-8";
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encode, dfrp);

		Event eventInfo = Event.builder()
							.eventNm(mr.getParameter("eventTitle"))
							.eventStartDt(Date.valueOf(mr.getParameter("eventStartDt")))
							.eventEndDt(Date.valueOf(mr.getParameter("eventEndDt")))
							.rsvOpenDt(Date.valueOf(mr.getParameter("eventRsvDt")))
							.evcNo(mr.getParameter("eventCategory"))
							.location(mr.getParameter("eventLocation"))
							.eventAge(Integer.parseInt(mr.getParameter("eventAge")))
							.eventDuration(Integer.parseInt(mr.getParameter("eventDuration")))
							.eventInter(Integer.parseInt(mr.getParameter("eventInter")))
							.build();
				
		List<String> casting = Arrays.asList(mr.getParameter("eventCasting").split(","));
		
		List<EventUpfile> upfiles = new ArrayList<>();
		upfiles.add(getUpFileBy(mr.getOriginalFileName("eventMainPoster"),
								mr.getFilesystemName("eventMainPoster"),
								"PUR1"));
		upfiles.add(getUpFileBy(mr.getOriginalFileName("eventImageDetail"),
								mr.getFilesystemName("eventImageDetail"),
								"PUR2"));
		if (mr.getOriginalFileName("eventBanner") != null) {
			upfiles.add(getUpFileBy(mr.getOriginalFileName("eventBanner"),
									mr.getFilesystemName("eventBanner"),
									"PUR3"));
		}
		
		Map<Date, String> eventSchedule = getSchedule(mr.getParameter("eventStartDt"), mr.getParameter("eventEndDt"), mr.getParameterValues("eventDay"), mr.getParameterValues("startTime"));
		
		int result = new EventService().insertEvent(eventInfo, casting, eventSchedule, upfiles);
		
		String msg = "행사가 성공적으로 등록되었습니다.";
		String loc = "/admin/eventlist";
		
		if (result == 0) {
			msg = "행사 등록에 실패했습니다.";
			loc = "/admin/insertEvent.do";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		doGet(request, response);
	}

	private Map<Date, String> getSchedule(String startDate, String EndDate, String[] days, String[] times) {
		Map<Date, String> schedule = new HashMap<>();
		
		LocalDate startDt = LocalDate.parse(startDate);
		LocalDate endDt = LocalDate.parse(EndDate);
		
		for (LocalDate date = startDt; date.isBefore(endDt.plusDays(1)); date = date.plusDays(1)) {
			if (Arrays.asList(days).contains(date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN))) {
				schedule.put(Date.valueOf(date), Arrays.asList(times).get(Arrays.asList(days).indexOf(date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN))));
			}
		}
		return schedule;
	}
	
	private EventUpfile getUpFileBy(String originalFileName, String fileRename, String purposeNo) {
		return EventUpfile.builder()
						.euNameOriginal(originalFileName)
						.euRename(fileRename)
						.purposeNo(purposeNo)
						.build();
	}
}
