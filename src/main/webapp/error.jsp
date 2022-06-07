<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.Enumeration"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
	/* function preventBack() {
		window.history.forward();
	}
	setTimeout("preventBack()", 0);
	window.onunload = function() {
		null;
	}; */
</script>

</head>
<body>
	
	<!-- <H1>Page Not Found</H1> -->

	<%@ page isErrorPage="true"%>
	<H1>Resource Not Found Error Occurred, Please Contact Support.</H1>
	<hr style="color: red;">
	<H2>Please Login Again</H2>
	<h3>
		<a href="login.do">Login</a>
	</h3>
	<h3>Exception is: ${exception }</h3>
</body>
</html>