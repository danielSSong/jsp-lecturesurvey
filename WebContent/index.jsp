<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="com.user.UserDAO" %>
    
   
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
			
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="search" />				 
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>

	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="ALL">ALL</option>
				<option value="Major">Major</option>
				<option value="Sub">Sub_Major</option>
				<option value="Elective">Elective</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="please input the content" />
			<button type="submit" class="btn btn-primary mx-1 mt-2">Search</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Register</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>
		</form>
		
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">This is Computer&nbsp;<small>Daniel Song</small></div>
					<div class="col-4 text-right">
						Score <span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					It is really good lecture.&nbsp;<small>(2017 Spring)</small>
				</h5>
				<p class="card-text">I got HD on this subject. WOW</p>
				<div class="row">
					<div class="col-9 text-left">
						Total <span style="color: red;">A</span>
						Score <span style="color: red;">A</span>
						Fun <span style="color: red;">A</span>
						
						<span style="color: green;">(Like: 15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('Do you like this content?')" href="./likeAction.jsp?evaluationID=">Like</a>
						<a onclick="return confirm('Do you delete this content?')" href="./deleteAction.jsp?evaluationID=">Cancel</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
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
									<option value="Sub_Major">Sub_Major</option>
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
							<button type="button" class="btn btn-danger" data-dismiss="modal">Report</button>
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