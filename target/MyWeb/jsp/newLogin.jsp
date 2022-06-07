<!DOCTYPE html>
<html>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@ page language ="java" %>
<%-- <%@ page errorPage="error.jsp" %> --%>
<%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Login</title><link rel="icon" type="image/gif/png" href="images/favicon.png">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    /* Body Background Images (Logo, Background and Infographics) */

    body {
      background: url(https://www.vyomlabs.com/wp-content/uploads/2017/03/vyomlabs-Logo.png) 50px 10px no-repeat, url(images/Login-screen-info.png) 100px 300px no-repeat, url(images/bg.jpg)left center no-repeat;
      background-size: 200px 72px, 601px, 100% 800px;

    }

    /* Body Typography */

    body h1 {
      padding-top: 50px;
      font-family: 'Roboto', sans-serif;
      line-height: 40px;
      font-size: 40px;
      color: #333;
    }

    body h2 {
      font-family: 'Roboto', sans-serif;
      text-align: center;
      font-size: 30px;
      color: #626262;
    }

    /* Sub-Heading */

    #small-title {
      font-family: 'Roboto', sans-serif;
      font-size: 25px;
      font-weight: lighter;
      color: #333;
    }

    #info-text {
      font-family: 'Roboto', sans-serif;
      font-size: 15px;
      font-weight: lighter;
      color: #333;
      text-align: center;
      padding-bottom: 0px
    }

    /* Main Heading */

    .heading {
      float: left;
      padding: 40px;
      width: 60%;
    }

    /* Form CSS */

    .form-container {
      /* float: left; */
      /* width: 30%; */
      margin: auto;
      margin-top: 100px;
      margin-right: 0px;
      padding: 40px 60px;
      padding-top: 100px;
      display: inline-block;
      background-image: url(images/men.png);
      background-position: 115px 20px;
      background-size: 150px;
      background-repeat: no-repeat;
      border-radius: 15px
      
      
    }

    form {
      padding: 50px 10px;
      background-color: #ffffff;
      box-shadow: 5px 5px 8px rgba(0, 0, 0, 0.3);
      /* display: block; */
    }

    input[type="text" i],
    input[type="password" i] {
      margin-bottom: 10px;
      padding: 20px 40px;
      width: 100%;
      box-sizing: border-box;
      border: solid 1px #EBEBEB;
      border-radius: 5px;
      background-color: #EBEBEB;
      font-size: large;
    }

    button {
      background-color: #000034;
      color: #fff;
      padding: 15px 15px;
      border: none;
      width: 100%;
      box-sizing: border-box;
      font-size: 16px;
      text-transform: uppercase;
      border-radius: 8px
    }

    /* Media Queries */

    @media (max-width: 500px) {
      .form-container {
        width: 100%;
        float: none;
        padding: 10px 10px;
        margin: auto;
      }
    }
  </style>
</head>

<body>

<% Date date = new Date();
long milliSec = date.getTime();
String nsec = String.valueOf(milliSec);
%>

  <!-- Main Heading -->
  <div class="heading">
    <h1>vControl-M Dashboard</h1>
    <p id="small-title">Reducing Operational Latency, Gaining Operational Efficiency...
      <br>Effective Business View</p>
  </div>
  <div>
    <!-- Login Form -->
    <form class="form-container" method="POST" action="validateUser.do?pType=new&nsec=<%=nsec%>">
      <h2>Member Login</h2>
      <input id="userID" name="userID" type="text" placeholder="Username">
     
      <br>
      <input id="password" name="password" type="password" placeholder="Password">
      <br>
      <button type="submit" class="pure-button pure-button-primary">Sign in</button>
      <p id="info-text">Forgot Password ?
        <a href="#">Click Here</a>        
      </p>
    <div align="center" style="color: red;"><h5>${validationFail}</h5></div>
    </form>
  </div>
   
</body>

</html>