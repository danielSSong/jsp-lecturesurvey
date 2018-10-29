<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.user.UserDAO"%>
<%@ page import="com.survey.SurveyDAO"%>
<%@ page import="com.likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%! public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
<% 

	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Login')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String surveyID = null;
	if(request.getParameter("surveyID") != null) {
		surveyID = request.getParameter("surveyID");
	}
	SurveyDAO surveyDAO = new SurveyDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, surveyID, getClientIP(request));
	if (result == 1) {
		result = surveyDAO.like(surveyID);
		if(result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You liked the survey')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Database error')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You already liked the survey')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
  
	
%>