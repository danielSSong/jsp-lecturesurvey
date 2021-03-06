<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="com.user.UserDAO" %>
<%@ page import="com.survey.SurveyDAO" %>
<%@ page import="com.survey.SurveyDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
    
   
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>UTS Lecture Survey</title>

	<!-- bootsrtap css -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- custom css -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>

<% 
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "ALL";
	String searchType = "Latest";
	String search = "";
	int pageNumber = 0; 
	if(request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try { 
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("Search Error");
		}
	}
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
	
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You must check the certification')");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">UTS Lecture Survey</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
	  		<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">Main</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						Manage
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">Login</a>
						<a class="dropdown-item" href="userJoin.jsp">Register</a>
<% 
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">Logout</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="search" />				 
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>

	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="ALL">ALL</option>
				<option value="Major" <% if(lectureDivide.equals("Major")) out.println("selected"); %>>Major</option>
				<option value="Sub" <% if(lectureDivide.equals("Sub")) out.print("selected"); %>>Sub</option>
				<option value="Elective" <% if(lectureDivide.equals("Elective")) out.println("selected"); %>>Elective</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="Latest">Latest</option>
				<option value="Like" <% if(searchType.equals("Like")) out.println("selected"); %>>Like</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="please input the content" />
			<button type="submit" class="btn btn-primary mx-1 mt-2">Search</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Register</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>
		</form>
		
<%
	ArrayList<SurveyDTO> surveyList = new ArrayList<SurveyDTO>();
	surveyList = new SurveyDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(surveyList != null) 
		for(int i = 0; i < surveyList.size(); i++) {
			if(i == 5) break;
			SurveyDTO survey = surveyList.get(i);
%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= survey.getLectureName() %>&nbsp;<small><%= survey.getProfessorName() %></small></div>
					<div class="col-4 text-right">
						Score <span style="color: red;"><%= survey.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= survey.getSurveyTitle() %>&nbsp;<small>(<%= survey.getLectureYear() %>, <%= survey.getSemesterDivide() %>)</small>
				</h5>
				<p class="card-text"><%= survey.getSurveyContent() %></p>
				<div class="row">
					<div class="col-9 text-left">
						Credit <span style="color: red;"><%= survey.getCreditScore() %></span>
						FUN <span style="color: red;"><%= survey.getComfortableScore() %></span>
						Lecture <span style="color: red;"><%= survey.getLectureScore() %></span>
						
						<span style="color: green;">(LIKE: <%= survey.getLikeCount() %>)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('Do you like this content?')" href="./likeyAction.jsp?surveyID=<%= survey.getSurveyID() %>">Like</a>
						<a onclick="return confirm('Do you delete this content?')" href="./deleteAction.jsp?surveyID=<%= survey.getSurveyID() %>">Delete</a>
					</div>
				</div>
			</div>
		</div>
		
<% 
	}
%>

	</section>
	
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 0) {
%>
	<a class="page-link disabled">Before</a>
<%
	} else {
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber - 1 %>">Before</a>
<%
	}
%>
		</li>
		<li>
<%
	if(surveyList.size() < 6) {
%>
	<a class="page-link disabled">Next</a>
<%
	} else {
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber + 1 %>">Next</a>
<%
	}
%>
		
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Survey</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./surveyRegisterAction.jsp" method ="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>Lecture</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20" />
							</div>
							<div class="form-group col-sm-6">
								<label>Professor</label>
								<input type="text" name="professorName" class="form-control" maxlength="20" />		
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>Year</label>
								<Select name="lectureYear" class="form-control">
									<option value="2010">2010</option>
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018" selected>2018</option>
									<option value="2019">2019</option>									
									<option value="2020">2020</option>
									<option value="2021">2021</option>
								</Select>
							</div>
							<div class="form-group col-sm-4">
								<label>Semester</label>
								<select name="semesterDivide" class="form-control">
									<option value="Spring" selected>Spring</option>
									<option value="Summer">Summer</option>
									<option value="Autumn">Autumn</option>
									<option value="Winter">Winter</option>
								</select>
							</div> 
							<div class="form-group col-sm-4">
								<label>Lecture</label>
								<select name="lectureDivide" class="form-control">
									<option value="Major" selected>Major</option>
									<option value="Sub">Sub_Major</option>
									<option value="Elective">Elective</option>
								</select>
							</div> 
						</div>
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="surveyTitle" class="form-control" maxlength="30" />
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="surveyContent" class="form-control" maxlength="2048" style="height: 180px"></textarea>
						</div>
						<div class="form-row">
						<div class="form-group col-sm-3">
								<label>Total</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>Score</label>
								<select name="creditScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>Fun</label>
								<select name="comfortableScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>lecture</label>
								<select name="lectureScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Register</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Report</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method ="post">

						<div class="form-group">
							<label>Report Title</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30" />
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-danger">Report</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
		Copyright &copy; 2018 Daniel Song All Rights Reserved.
	</footer>
	<!-- jQuery js -->
	<script src="./js/jquery.min.js"></script>
	<!-- popper js -->
	<script src="./js/popper.js"></script>
		<!-- bootstrap js -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>