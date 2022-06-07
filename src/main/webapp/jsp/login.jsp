<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@ page language ="java" %>
<%-- <%@ page errorPage="error.jsp" %> --%>
<%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<html>
<head>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Login</title>
	<link rel="icon" type="image/gif/png" href="images/cm.png">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="css/appStyle.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<!------ Include the above in your HEAD tag ---------->
	<style type="text/css">
		.panel-heading {
	    padding: 5px 15px;
		}
		
		.panel-footer {
			padding: 1px 15px;
			color: #A0A0A0;
		}
		
		.profile-img {
			width: 96px;
			height: 96px;
			margin: 0 auto 10px;
			display: block;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
		}
		
		#sub-left {
		   float: left;
		   width: 60%;
		}
		#sub-right {
		   float: right;
		   width: 20%;
		   padding-top: 230px;
		   padding-right: 15px;
		}
		#sub-center {
		   float: right;
		   width: 15%;
		}
		
		#sub-left1 {
		   float: left;
		   width: 100%;
		}
		#sub-right1 {
		   float: right;
		   width: 50%;
		}
		
		.container1{
		/* 	padding-right: 5px;
			padding-left: 5px;
			margin-right: 10px;
			margin-left: auto;
			 */
		
			width: 100%;
		}
	</style>
</head>
<body>
<% Date date = new Date();
long milliSec = date.getTime();
String nsec = String.valueOf(milliSec);
%>
	<!-- <div id="sub-right1">
		<div style="margin-right: 100px;" align="right"><img src="images/vyomlabs6.png" alt="Avatar" class="avatar"></div><br><br>
	</div>
	<div id="sub-left1">
		<div align="center" class="pageHeader2">BMC Control-M Active Dashboard</div><br>
	    <div align="center" class="pageHeader3">Reducing Operational Latency, Gaining Operational Efficency....</div>
		<div align="center" class="pageHeader3">Effective Business View </div><br><br>
	</div> -->
    <div class="container1">
   <%--  <div align="center" style="color: red;"><h3>${session}</h3></div> --%>
    	<div id="sub-left">
    		<!-- <div align="center" class="pageHeader2">vControl-M Dashboard</div><br>
	    	<div align="center" class="pageHeader3">Reducing Operational Latency, Gaining Operational Efficency....</div>
			<div align="center" class="pageHeader3">Effective Business View </div><br><br><br><br> -->
    		<div ><img src="images/login-screen_final_2.png" alt="Avatar" class="avatar"></div>
		</div>
		<div id="sub-right" >
			<!-- <div style="margin-right: 10px;" align="right"><img src="images/vyomlabs6.png" alt="Avatar" class="avatar"></div><br><br><br><br> -->
			<div class="row1"><br><br>
				<div class="col-sm-61 col-md-41 col-md-offset-41">
					<div class="panel panel-default">
						<div align="center" class="panel-heading">
							<strong style="font-size: 15px;"> Sign in to continue</strong>
						</div>
						<div class="panel-body">
							<form role="form" action="validateUser.do?pType=new&nsec=<%=nsec%>" method="POST">
								<fieldset>
									<div class="row">
										<div class="center-block">
											<img class="profile-img"
												src="images/user.png" alt="">
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-md-10  col-md-offset-1 ">
											<div class="form-group">
												<div class="input-group">
													<span class="input-group-addon">
														<i class="glyphicon glyphicon-user"></i>
													</span> 
													<input class="form-control" placeholder="Username" id="UserID" name="userID" type="text" autofocus>
												</div>
											</div>
											<div class="form-group">
												<div class="input-group">
													<span class="input-group-addon">
														<i class="glyphicon glyphicon-lock"></i>
													</span>
													<input class="form-control" placeholder="Password" id="password" name="password" type="password" value="">
												</div>
											</div>
											<div class="form-group">
												<input type="submit" class="btn btn-lg btn-primary btn-block" value="Sign in">
											</div>
										</div>
									</div>
								</fieldset>
							</form>
						</div>						
	                </div>	                
				</div>
				<div align="center" style="color: red;"><h5>${validationFail}</h5></div>
				
			</div>
		</div>
	</div>
</body>
</html>