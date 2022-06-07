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
	<title>Session Timeout</title>
	<link rel="icon" type="image/gif/png" href="images/cm.png">
	<link href="css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="css/appStyle.css" rel="stylesheet" id="bootstrap-css">
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-1.11.1.min.js"></script>
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
		.container1{
			padding-right: 5px;
			padding-left: 5px;
			margin-right: auto;
			margin-left: auto;
			margin-top: 200px;
			width: 50%;
		}
		
		#sub-right {
		   width: 100%;
		}
		input[type=submit].btn-block,input[type=reset].btn-block,input[type=button].btn-block {
		 width:50%
		}
	</style>
</head>
<body>
    <div class="container1">
   <%--  <div align="center" style="color: red;"><h3>${session}</h3></div> --%>
    	
		<div align="center" id="sub-right">
			<div class="row1">
				<div class="col-sm-61 col-md-41 col-md-offset-41">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3> Session Expires....</h3>
						</div>
						<div class="panel-body">
							<form role="form" action="login.do" method="POST">
								<fieldset>									
									<div class="row">
										<div class="col-sm-12 col-md-10  col-md-offset-1 ">
											<div class="form-group">
												<h3>Please Login Again..</h3>
											</div>
											
											<div class="form-group">
												<input type="submit" class="btn btn-lg btn-primary btn-block" value="Login">
											</div>
										</div>
									</div>
								</fieldset>
							</form>
						</div>						
	                </div>	                
				</div>				
			</div>
		</div>
	</div>
</body>
</html>