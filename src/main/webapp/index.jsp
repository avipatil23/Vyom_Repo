<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="Refresh" CONTENT="3; URL=login.do">
<title>MyApp</title>
<link rel="icon" type="image/gif/png" href="images/cm.png">
	<link href='https://fonts.googleapis.com/css?family=Actor' rel='stylesheet' type='text/css'>
	<style type="text/css">	
		body{
			background:#333;
			background: -webkit-gradient(radial, center center, 120, center center, 900, from(#33495E), to(#2E2329));
			background:-moz-radial-gradient(circle, #33495E, #2E2329);
		
		}
		.loader{
			margin:200px auto;
		}
		h1{
			font-family: 'Actor', sans-serif;
			color:#FFF;
			font-size:16px;
			letter-spacing:1px;
			font-weight:200;
			text-align:center;
		}
		.loader span{
			width:16px;
			height:16px;
			border-radius:50%;
			display:inline-block;
			position:absolute;
			left:50%;
			margin-left:-10px;
			-webkit-animation:3s infinite linear;
			-moz-animation:3s infinite linear;
			-o-animation:3s infinite linear;
			
		}
		
		
		.loader span:nth-child(2){
			background:#E84C3D;
			-webkit-animation:kiri 1.2s infinite linear;
			-moz-animation:kiri 1.2s infinite linear;
			-o-animation:kiri 1.2s infinite linear;
			
		}
		.loader span:nth-child(3){
			background:#F1C40F;
			z-index:100;
		}
		.loader span:nth-child(4){
			background:#2FCC71;
			-webkit-animation:kanan 1.2s infinite linear;
			-moz-animation:kanan 1.2s infinite linear;
			-o-animation:kanan 1.2s infinite linear;
		}
		
		
		@-webkit-keyframes kanan {
		    0% {-webkit-transform:translateX(20px);
		    }
		   
			50%{-webkit-transform:translateX(-20px);
			}
			
			100%{-webkit-transform:translateX(20px);
			z-index:200;
			}
		}
		@-moz-keyframes kanan {
		    0% {-moz-transform:translateX(20px);
		    }
		   
			50%{-moz-transform:translateX(-20px);
			}
			
			100%{-moz-transform:translateX(20px);
			z-index:200;
			}
		}
		@-o-keyframes kanan {
		    0% {-o-transform:translateX(20px);
		    }
		   
			50%{-o-transform:translateX(-20px);
			}
			
			100%{-o-transform:translateX(20px);
			z-index:200;
			}
		}
		
		
		
		
		@-webkit-keyframes kiri {
		     0% {-webkit-transform:translateX(-20px);
			z-index:200;
		    }
			50%{-webkit-transform:translateX(20px);
			}
			100%{-webkit-transform:translateX(-20px);
			}
		}
		
		@-moz-keyframes kiri {
		     0% {-moz-transform:translateX(-20px);
			z-index:200;
		    }
			50%{-moz-transform:translateX(20px);
			}
			100%{-moz-transform:translateX(-20px);
			}
		}
		@-o-keyframes kiri {
		     0% {-o-transform:translateX(-20px);
			z-index:200;
		    }
			50%{-o-transform:translateX(20px);
			}
			100%{-o-transform:translateX(-20px);
			}
		}
	</style>
	
	<style type="text/css">
		body {
		  background:#000;
		}
		
		#load {
		  position:absolute;
		  width:600px;
		  height:36px;
		  left:50%;
		  top:40%;
		  margin-left:-300px;
		  overflow:visible;
		  -webkit-user-select:none;
		  -moz-user-select:none;
		  -ms-user-select:none;
		  user-select:none;
		  cursor:default;
		}
		
		#load div {
		  position:absolute;
		  width:20px;
		  height:36px;
		  opacity:0;
		  font-family:Helvetica, Arial, sans-serif;
		  animation:move 2s linear infinite;
		  -o-animation:move 2s linear infinite;
		  -moz-animation:move 2s linear infinite;
		  -webkit-animation:move 2s linear infinite;
		  transform:rotate(180deg);
		  -o-transform:rotate(180deg);
		  -moz-transform:rotate(180deg);
		  -webkit-transform:rotate(180deg);
		  color:#35C4F0;
		}
		
		#load div:nth-child(2) {
		  animation-delay:0.2s;
		  -o-animation-delay:0.2s;
		  -moz-animation-delay:0.2s;
		  -webkit-animation-delay:0.2s;
		}
		#load div:nth-child(3) {
		  animation-delay:0.4s;
		  -o-animation-delay:0.4s;
		  -webkit-animation-delay:0.4s;
		  -webkit-animation-delay:0.4s;
		}
		#load div:nth-child(4) {
		  animation-delay:0.6s;
		  -o-animation-delay:0.6s;
		  -moz-animation-delay:0.6s;
		  -webkit-animation-delay:0.6s;
		}
		#load div:nth-child(5) {
		  animation-delay:0.8s;
		  -o-animation-delay:0.8s;
		  -moz-animation-delay:0.8s;
		  -webkit-animation-delay:0.8s;
		}
		#load div:nth-child(6) {
		  animation-delay:1s;
		  -o-animation-delay:1s;
		  -moz-animation-delay:1s;
		  -webkit-animation-delay:1s;
		}
		#load div:nth-child(7) {
		  animation-delay:1.2s;
		  -o-animation-delay:1.2s;
		  -moz-animation-delay:1.2s;
		  -webkit-animation-delay:1.2s;
		}
		
		@keyframes move {
		  0% {
		    left:0;
		    opacity:0;
		  }
			35% {
				left: 41%; 
				-moz-transform:rotate(0deg);
				-webkit-transform:rotate(0deg);
				-o-transform:rotate(0deg);
				transform:rotate(0deg);
				opacity:1;
			}
			65% {
				left:59%; 
				-moz-transform:rotate(0deg); 
				-webkit-transform:rotate(0deg); 
				-o-transform:rotate(0deg);
				transform:rotate(0deg); 
				opacity:1;
			}
			100% {
				left:100%; 
				-moz-transform:rotate(-180deg); 
				-webkit-transform:rotate(-180deg); 
				-o-transform:rotate(-180deg); 
				transform:rotate(-180deg);
				opacity:0;
			}
		}
		
		@-moz-keyframes move {
			0% {
				left:0; 
				opacity:0;
			}
			35% {
				left:41%; 
				-moz-transform:rotate(0deg); 
				transform:rotate(0deg);
				opacity:1;
			}
			65% {
				left:59%; 
				-moz-transform:rotate(0deg); 
				transform:rotate(0deg);
				opacity:1;
			}
			100% {
				left:100%; 
				-moz-transform:rotate(-180deg); 
				transform:rotate(-180deg);
				opacity:0;
			}
		}
		
		@-webkit-keyframes move {
			0% {
				left:0; 
				opacity:0;
			}
			35% {
				left:41%; 
				-webkit-transform:rotate(0deg); 
				transform:rotate(0deg); 
				opacity:1;
			}
			65% {
				left:59%; 
				-webkit-transform:rotate(0deg); 
				transform:rotate(0deg); 
				opacity:1;
			}
			100% {
				left:100%;
				-webkit-transform:rotate(-180deg); 
				transform:rotate(-180deg); 
				opacity:0;
			}
		}
		
		@-o-keyframes move {
			0% {
				left:0; 
				opacity:0;
			}
			35% {
				left:41%; 
				-o-transform:rotate(0deg); 
				transform:rotate(0deg); 
				opacity:1;
			}
			65% {
				left:59%; 
				-o-transform:rotate(0deg); 
				transform:rotate(0deg); 
				opacity:1;
			}
			100% {
				left:100%; 
				-o-transform:rotate(-180deg); 
				transform:rotate(-180deg); 
				opacity:0;
			}
		}
	</style>
</head>
<body>
	<!-- <div class="loader">
    <h1>LOADING</h1>
    <span></span>
    <span></span>
    <span></span>
	</div> -->
	<div id="load">
  <div>G</div>
	  <div>N</div>
	  <div>I</div>
	  <div>D</div>
	  <div>A</div>
	  <div>O</div>
	  <div>L</div>
	</div>
</body>
</html>