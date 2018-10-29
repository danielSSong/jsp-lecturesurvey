<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 

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
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-warning mt-4" role="alert">
			You must get the certifiaction. Did you get the email?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">re-send Email</a>
	</section>
	
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