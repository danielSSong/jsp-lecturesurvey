<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.user.UserDAO" %>
<%@ page import="com.survey.SurveyDAO" %>
<%@ page import="com.likey.LikeyDTO" %>
<%@ page import="java.io.PrintWriter" %>
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
	if(userID.equals(surveyDAO.getUserID(surveyID))) {
		int result = new SurveyDAO().delete(surveyID);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You deleted the survey')");
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
		script.println("alert('You can not delete the survey')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
 	}
	
%>