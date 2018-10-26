<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.survey.SurveyDTO" %>
<%@ page import="com.survey.SurveyDAO" %>
<%@ page import="com.util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please login')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String lectureDivide = null;
	String surveyTitle = null;
	String surveyContent = null;
	String totalScore = null;
	String creditScore = null;
	String comfortableScore = null;
	String lectureScore = null;

	if(request.getParameter("lectureName") != null) {
		lectureName = request.getParameter("lectureName");
	}
	if(request.getParameter("professorName") != null) {
		professorName = request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear") != null) {
		try {
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	if(request.getParameter("semesterDivide") != null) {
		semesterDivide = request.getParameter("semesterDivide");
	}
	if(request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("surveyTitle") != null) {
		surveyTitle = request.getParameter("surveyTitle");
	}
	if(request.getParameter("surveyContent") != null) {
		surveyContent = request.getParameter("surveyContent");
	}
	if(request.getParameter("totalScore") != null) {
		totalScore = request.getParameter("totalScore");
	}
	if(request.getParameter("creditScore") != null) {
		creditScore = request.getParameter("creditScore");
	}
	if(request.getParameter("comfortableScore") != null) {
		comfortableScore = request.getParameter("comfortableScore");
	}
	if(request.getParameter("lectureScore") != null) {
		lectureScore = request.getParameter("lectureScore");
	}

	
	if(lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null
			 || lectureDivide == null || surveyTitle == null || surveyContent == null || totalScore == null
			 || creditScore == null || comfortableScore == null || lectureScore == null || surveyTitle.equals("") || surveyContent.equals(""))  {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There is a blank on fields')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	SurveyDAO surveyDAO = new SurveyDAO();
	int result = surveyDAO.write(new SurveyDTO(0, userID, lectureName, professorName, lectureYear, semesterDivide, 
			lectureDivide, surveyTitle, surveyContent, totalScore, creditScore, comfortableScore, lectureScore, 0));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You failed the survey')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>