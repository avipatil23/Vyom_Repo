<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="header2.jsp" %>
	<meta http-equiv="Pragma" content="no-cache">
 	<meta http-equiv="Cache-Control" content="no-cache">
 	<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/circle2.css">
	<link rel="stylesheet" href="css/circle1.css">
	<link rel="stylesheet" href="css/circle.css">
	<link rel="stylesheet" href="css/tab.css">
	<link href="css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
	<script src="js/bootstrap-select.min.js"></script>
	
	<link href="css/smoothness/bootstrap.min.css" type="text/css">
	<link href="css/responsive.bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- <link href="css/jquery.dataTables.css" rel="stylesheet" type="text/css"> -->
  
	<script type="text/JavaScript" src="js/jquery-3.3.1.js"></script>
	<script type="text/JavaScript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/JavaScript" src="js/bootstrap.min.js"></script>
	<script type="text/JavaScript" src="js/dataTables.bootstrap.min.js"></script>
	<script type="text/JavaScript" src="js/dataTables.responsive.min.js"></script>
	<script type="text/JavaScript" src="js/responsive.bootstrap.min.js"></script>
	<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	
	<!-- 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/i18n/defaults-*.min.js"></script> -->
	<title>Dashboard</title>
	<script type="text/javascript">		
/* 		$(document).ready(function() {
		    var table = $('#example').DataTable( {
		        responsive: true,
		    	"sPaginationType": "full_numbers",
		    	"paging":   false,
		        "ordering": false,
		        "info":     false
		    } );
		 
		    new $.fn.dataTable.FixedHeader( table );
		} );	
		 */
		 $(document).ready(function() {
			    var table = $('#example').DataTable( {
			        /* responsive: true, */
			    	"sPaginationType": "full_numbers",
			    	"sScrollX": "100%",
			        "sScrollXInner": "100%",
			        "bScrollCollapse": true
			        
			    } );
			 
			    new $.fn.dataTable.FixedHeader( table );
			} );
	</script>	
	<style type="text/css">
		.container1 {
		    width: 96%;
		    margin-left: 17px;
		}
		.twoSection .leftSection {
		    width: 100%;
		    float: left;
		    padding-top: 5px;
		}
		
		.rightSection {
			border-top : 1px solid #C7D3DE;
		    border-left: 1px solid #C7D3DE;
		    float: left;
		    margin-left: 10px;
		    /* padding: 5px 0 0; */
		    width: 100%;
		    height: auto;
		    font-family: arial;
		    font-size: 10px;
		    min-height: 70%;
		    
		    
		}
		
		.rightSection .title {
		    text-transform: capitalize;
		    font-weight: 400;
		    padding: 0 0 5px 10px;
		}
		
		.dash {
		    background: none repeat scroll 0 0 #EEF3F8;
		    border-top: 1px solid #dbd9d9;
		    float: left;
		    padding: 10px 0 10px 10px;
		    width: 100%;
		    min-height: 491px;
		    height: auto;
		}
		
		.threeCol {
		    float: left;
		    width: 100%;
		    margin-bottom: 15px;
		}
		
		.smallCol {
		    background: none repeat scroll 0 0 #f5f5f5 ;
		    border: 1px solid #CCC;
		    height: 220px;
		    min-height: 100%;
		    padding: 5px 33px 5px;
		    width: 24%;
		    float: left;
		    margin-right: 5px;		
		     
		}
		
		.footWrapper1 {
		    float: left;
		    width: 100%;
		    background: #e77817;
		}
		
		.footWrapper {
		    float: left;
		    width: 100%;
		    background: #053c6d;
		}
		
		.sub-left {
		   float: left;
		   width: 14%;
		}
		.sub-right {
		   float: right;
		   width: 84%;
		}			
	</style>
	<style>
	
		* {
		  box-sizing: border-box;
		}
		
		#myInput {
		  background-image: url('images/search.png');
		  background-position: 10px 10px;
		  background-repeat: no-repeat;
		  width: 100%;
		  font-size: 10px;
		  padding: 12px 20px 12px 40px;
		  border: 1px solid #ddd;
		  margin-bottom: 12px;
		}
		
		#myTable {
		  border-collapse: collapse;
		  width: 100%;
		  border: 1px solid #ddd;
		  font-size: 12px;
		 
		}
		
		#myTable th, #myTable td {
		  text-align: left;
		  padding: 10px;
		}
		
		#myTable tr {
		  border-bottom: 1px solid #ddd;
		}
		
		#myTable tr.header, #myTable tr:hover {
		  background-color: #f1f1f1;
		  cursor: pointer;
		  visibility: visible;
		  
		}
		
		/* Tooltip container */
		.tooltip {
		    position: relative;
		    display: inline-block;
		    border-bottom: 1px dotted black; /* If you want dots under the hoverable text */
		}
				
		.tooltip .tooltiptext {
		    visibility: hidden;
		    width: 120px;
		    background-color: black;
		    color: #fff;
		    text-align: center;
		    padding: 5px 0;
		    border-radius: 6px;
		 
		    /* Position the tooltip text - see examples below! */
		    position: absolute;
		    z-index: 1;
		}
		
		/* Show the tooltip text when you mouse over the tooltip container */
		.tooltip:hover .tooltiptext {
		    visibility: visible;
		}
		
	</style>
	
	
	<script>
		function myFunction() {
		  var input, filter, table, tr, td, i;
		  input = document.getElementById("myInput");
		  filter = input.value.toUpperCase();
		  table = document.getElementById("myTable");
		  tr = table.getElementsByTagName("tr");
		  for (i = 0; i < tr.length; i++) {
		    td = tr[i].getElementsByTagName("td")[0];
		    if (td) {
		      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
		        tr[i].style.display = "";
		      } else {
		        tr[i].style.display = "none";
		      }
		    }       
		  }
		}
	</script>
	
	
	<script type="text/javascript">
		function f_Process(sel){
			//var sel = document.getElementById('list').value;
			//var sel = document.getElementById('pName').value;
			//var sel = document.getElementById('pName').innerHTML;
			//alert(sel);
			document.dashboard.action = "dashboard.do?pType="+sel+"&nsec=<%=nsec%>";
			document.dashboard.submit();
		}
		
		function f_Data(status,pType){
			document.dashboard.action = "listProcess.do?pType="+pType+"&status="+status+"&nsec=<%=nsec%>";
			document.dashboard.submit();
		}
		
		$('.selectpicker').selectpicker({
		  style: 'btn-info',
		  size: 10
		});
	</script>
</head>

<c:set var="nsec" value="${nsec}"></c:set>
	<%userDto = (UserDto)session.getAttribute("userDto"+nsec+"");%>


<body onload="javascript:back_block();">
<form id="dashboard" name="dashboard" method="post">
<div id="sub-title" class="container1">
	<div style="background-color: #fff">
	<div class="sub-left">
	   <div class="leftSection" >	   
			<div  align="center">
				<%-- <select class="form-control" id="list" name="list" autocomplete="on" onchange="f_Process()">
			 		 <c:forEach var="lstMetaDataDto" items="${lstMetaDataDto}">
						<c:if test="${pType == 'new' }">
							<option value="${lstMetaDataDto.pName}">${lstMetaDataDto.pName}</option>
						</c:if>
						<c:if test="${pType != 'new' }">
							<option value="${lstMetaDataDto.pName}" ${lstMetaDataDto.pName eq pType ? 'selected' : ''}>${lstMetaDataDto.pName }</option>
						</c:if>
					</c:forEach>							
	          </select> --%>
	        <input type="text" id="myInput" class="form-control" onkeyup="myFunction()" placeholder="Search for Process.." title="Type in a name">
	        	<div  style="overflow: auto;height: 600px;overflow-x: hidden;">
					<table id="myTable"	style="width: 100%;">
						<thead>
							<tr>
								<th style="background-color: #cfd8dc;"><img src="images/process-name.png">&nbsp;&nbsp;Process Name</th>
							</tr>
						</thead>
						<tbody >
							<c:forEach items="${lstMetaDataDto}" var="lstMetaDataDto">
								<tr >
									<td onclick="f_Process('${lstMetaDataDto.pName}')"> <span>${lstMetaDataDto.pName}</span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
	   </div>
	   </div>
	   <!-- ************************************************************* -->
	   <div class="sub-right">
	   <div class="rightSection">	   	
	   		<div>
	   			<table style="width: 100%">
	   				<tr>
	   					<td align="center" style="width: 50%;background-color: #130D3D;"><h4  style="color: #C9C7C6;font-size: 19px;"><span> vControl-M Dashboard</span> </h4></td> 		
	   				</tr>
	   				<tr>
	   					<td align="left" style="width: 50%;"><label style="color: #1a237e;font-size: 14px;">&nbsp;&nbsp;&nbsp;Process Name&nbsp;: &nbsp;&nbsp;</label>
	   					<label style="color: #e65100;font-size: 15px;">${pType}</label> </td>
	   				</tr>
	   			</table>         	
        	</div>
        	<div class="dash">
        		<div class="threeCol">	   		
		   		<div class="smallCol" onclick="f_Data('Processed','${pType}')"> 	   		  	   
					<div align="center" style="color: #007E33;font-size: 17px;font-weight: bold;"><img src="images/Processed.png">&nbsp;&nbsp;  Processed</div>					
					<div align="right" class="page" >			
			            <div class="clearfix">	
			                <div style="cursor: pointer;" align="center" id="test" class="c100 ${aProcess} big">
			                    <span>${Processed}%</span>
			                    <div class="slice">
			                        <div class="bar"></div>
			                        <div class="fill"></div>
		                    	</div>				                    	
		                	</div>		                
		        		</div>			        		
					</div>
				</div>
				<!-- ********************************************************* -->
				
				<div class="smallCol"  onclick="f_Data('Error','${pType}')">
					<div align="center" style="color: #f44336;font-size: 17px;font-weight: bold; "><img src="images/Error.png">&nbsp;&nbsp;  Error</div>					
					<div align="right" class="page">			
			            <div class="clearfix">				            	
		                	<div style="cursor: pointer;" align="center" class="c1000 ${aErr} big">
		                    	<span>${Error}%</span>
		                    	<div class="slice">
		                        	<div class="bar"></div>
		                        	<div class="fill"></div>
		                    	</div>
		                	</div>				                	
		        		</div>			        		
					</div>
				</div>
				<!-- ******************************************************* --> 
				
				<div align="center" class="smallCol" onclick="f_Data('Unprocessed','${pType}')"> 	   		  	   
					<div align="center" style="color: #448aff ;font-size: 17px;font-weight: bold;"><img src="images/Unprocessed.png">&nbsp;&nbsp; Unprocessed</div>					
					<div align="right" class="page">			
			            <div class="clearfix">	
			                <div style="cursor: pointer;" align="left" id="test" class="c10 ${aUnprocess} big">
			                    <span>${Unprocessed}%</span>
			                    <div class="slice">
			                        <div class="bar"></div>
			                        <div class="fill"></div>
		                    	</div>				                    	
		                	</div>		                
		        		</div>			        		
					</div>
				</div>
				<!-- ********************************************************** -->
				<div class="smallCol">
	   				<div align="center" style="color: #e65100;font-size: 15px;font-weight: bold; margin-bottom: 10px;"><img src="images/Summary.png">&nbsp;&nbsp; Summary</div>					
					<br><br><div  align="center" id="tab1" class="tab active">	
						<div align="left" style="color: grey;font-size: 13px;font-weight: bold;">Total #       : ${totalCount}</div>
						<div align="left" style="color: grey;font-size: 13px;font-weight: bold;">Processed #     : ${pCount}</div>
						<div align="left" style="color: grey;font-size: 13px;font-weight: bold;">Error #       : ${eCount}</div>
						<div align="left" style="color: grey;font-size: 13px;font-weight: bold;">Unprocessed # : ${unPCount}</div>
					</div>
				</div>	 
			</div>
			<!-- ************************************************************** -->  	
   			<div class="threeCol">
				<table id="example" class="table table-striped table-bordered nowrap" style="width:100%">
				<c:set var="role" scope="page" value="<%=userDto.getRole()%>"/>
					<thead>
						<tr>
							<th>Sr. No.</th>
							
							<c:if test="${role eq 'Admin'}">
								<th>User Name</th>
							</c:if>
							
							<th>Process Name</th>
							<th>Total Record</th>
							<th>Processed Record</th>
							<th>Error Record</th>
							<th>Unprocessed Record</th>
						</tr>
					</thead>
					<c:set var="counter" value="1" />
					<tbody>
					<c:forEach  var="listOfProcess" items="${listOfProcess}"  varStatus="mapsIndex">
					
					
						<tr>
						
							<td> ${counter} </td>
							
							
							<c:if test="${role eq 'Admin'}">
								<td>${listOfProcess.firstName} ${listOfProcess.lastName}</td>
							</c:if>
						
							<td>${listOfProcess.ProcessName}</td>
							
										
							<c:forEach items="${statusCount}"  var="maps" >							
								<c:if test="${(maps.key) eq (listOfProcess.ProcessName)}">						 
								 	<td>${ maps.value.Processed+maps.value.Error+maps.value.unProcessed} </td>
									<td> ${ maps.value.Processed} </td>
									<td> ${ maps.value.Error} </td>
									<td> ${ maps.value.unProcessed} </td>
																
								</c:if>
								
							</c:forEach>	
							
							
						</tr>
						
					
					<c:set var="counter" value="${counter+1}" />
					</c:forEach>	
					</tbody>
					
					
				</table>
			</div>
   			<!-- ************************************************************** -->
	   	</div>
	   </div>
	   </div>
	</div>	  
</div>
</form>
</body>
</html>