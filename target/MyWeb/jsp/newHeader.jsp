<%@page import="com.company.myapp.dto.UserDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%
int timeout = session.getMaxInactiveInterval();
response.setHeader("Refresh", timeout + "; URL = session.do?");
%>

<!DOCTYPE html>
<html>

<head>

  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Page Title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    ul {
      list-style-type: none !important;
      width: 100% !important;
      margin: 0px !important;
      padding: 5px !important;
      overflow: hidden !important;
      background: url(images/bg.jpg) no-repeat;
      font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif
    }

    li {
      float: left !important;
    }

    li a {
      display: inline !important; 
      color: #333 !important; 
      font-weight: 600 !important; 
      /* text-align: center; */
      padding: 5px;
      /* margin-top: 10px; */
      text-decoration: none;
    }

    li.logo img {
      height: 45px !important;
      padding: 0px !important;
    }

    li.icon img {
      height: 20px !important;

      margin: 15px 10px -5px 15px !important;
      /* padding: 5px; */
    }

    li.icon1 img {
      height: 20px !important;
      float: left !important;
      margin: 0px 2px -5px 15px !important;
      /* padding: 5px; */
    }

    li.icon1 {
      float: right !important;
      margin: 15px 15px -5px 15px !important;

    }
  </style>
</head>
	<c:set var="nsec" value="${nsec}"></c:set>
	<%
	String nsec = (String)pageContext.getAttribute("nsec");	
	
	UserDto userDto = (UserDto)session.getAttribute("userDto"+nsec+"");
	 
	%>
<body>
  <div class="nav">
    <ul class="left-nav">
      <li class="logo">
        <a href="#">
          <img src="https://www.vyomlabs.com/wp-content/uploads/2017/03/vyomlabs-Logo.png"></a>
      </li>
      <li class="icon">
        <a href="#">
          <img src="images/1.png">Dashboard</a>
      </li>
      <li class="icon">
        <a href="#">
          <img src="images/2.png">Register Process</a>
      </li>
      <li class="icon">
        <a href="#">
          <img src="images/3.png">User Creation</a>
      </li>
      <li class="icon1">
        <a href="#">
          <img src="images/5.png">Log Out</a>
      </li>
      <li class="icon1">
        <a href="#">
          <img src="images/4.png">Admin</a>

    </ul>

    </ul>

  </div>
</body>

</html>