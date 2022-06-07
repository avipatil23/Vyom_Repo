<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%-- <%@ page errorPage="error.jsp" %> --%>
<%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="header.jsp" %>
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
	<link rel="stylesheet" href="css/dashboard.css">
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
	
	<link rel="stylesheet" href="css/style.css">
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script> -->
	<script src="js/choosen.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/i18n/defaults-*.min.js"></script>
	<title>Dashboard</title>
	
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable( {
	    	"sPaginationType": "full_numbers",
	    	/* "iDisplayLength": 11, */
	       responsive: {
	            details: {
	                display: $.fn.dataTable.Responsive.display.modal( {
	                    header: function ( row ) {
	                        var data = row.data();
	                        return 'Details for '+data[1]+' '+data[2];
	                    }
	                } ),
	                renderer: $.fn.dataTable.Responsive.renderer.tableAll( {
	                    tableClass: 'table'
	                } )
	            }
	        }
	    } );
	} ); 
	</script>
	<script type="text/javascript">
		$(function() {
		    $( "#date1" ).datepicker({
		      showOn: "button",
		      dateFormat: "dd-mm-yy",
		      maxDate: 0,
		      buttonImage: "images/calendar_icon.gif",
		      buttonImageOnly: true,
		      changeMonth: true,
		      changeYear: true
		    });
		  });
	
		function f_Process(){
			var sel = document.getElementById('list').value;	
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
<body onload="javascript:back_block();">
<form id="dashboard" name="dashboard" method="post">
<div id="sub-title" class="container1">
	<div class="sub-up"  style="background-image: url('images/bg2.png');background-attachment: fixed;background-position: center;background-repeat: no-repeat;background-size: cover;">
	<div class="sub-left">
	   <div>	   
			<div>
				<select class="chosen" id="list" name="list" autocomplete="on" onchange="f_Process()">
			 		 <c:forEach var="lstMetaDataDto" items="${lstMetaDataDto}">
						<c:if test="${pType == 'new' }">
							<option value="${lstMetaDataDto.pName}">${lstMetaDataDto.pName}</option>
						</c:if>
						<c:if test="${pType != 'new' }">
							<option value="${lstMetaDataDto.pName }" ${lstMetaDataDto.pName eq pType ? 'selected' : ''}>${lstMetaDataDto.pName }</option>
						</c:if>
					</c:forEach>
	          </select>
			</div>
			<script type="text/javascript">
				$(".chosen").chosen();
			</script>
	   </div>
	   </div>
	   <!-- ************************************************************* -->
	   <div class="sub-right">
	   <div>	   	
	   		<div class="sub-left1">
	   			<table>
	   				<tr>
	   					<td align="center"><h3 style="color: white;font-size: 25px;font-weight: bold;"><span> Control-M Dashboard</span> </h3></td>
	   				</tr>
	   			</table>         	
        	</div>
        	<div class="sub-right1">
        		<div  style="background-color: #fff;background-image:url('images/vyomlabs5.png'); width:100%; height:55px; background-repeat:no-repeat; background-size:cover;">
        			
        		</div>
        	</div>
        	<div class="dash">
        	<!-- <div class="dash"> -->
        		<div class="threeCol">	   		
		   		<div class="smallCol" onclick="f_Data('Processed','${pType}')"> 	   		  	   
					<div align="center" style="color: #007E33;font-size: 15px;font-weight: bold;">Processed Data</div>					
					<div align="center" class="page" style="float: left;">			
			            <div class="clearfix">	
			                <div  align="center" id="test" class="c100 ${aProcess} big">
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
					<div align="center" style="color: #f44336;font-size: 15px;font-weight: bold;">Error Data</div>					
					<div align="center" class="page">			
			            <div class="clearfix">				            	
		                	<div align="center" class="c1000 ${aErr} big">
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
					<div align="center" style="color: #448aff ;font-size: 15px;font-weight: bold;">Unprocessed Data</div>					
					<div align="center" class="page">			
			            <div class="clearfix">	
			                <div  align="left" id="test" class="c10 ${aUnprocess} big">
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
	   				<div align="center" style="color: #e65100;font-size: 15px;font-weight: bold;">Summary</div>					
					<div  align="center" id="tab1" class="tab active">	
						<div align="left" style="color: grey;font-size: 14px;font-weight: bold;">Total Count : ${totalCount}</div>
						<div align="left" style="color: grey;font-size: 14px;font-weight: bold;">Process Count : ${pCount}</div>
						<div align="left" style="color: grey;font-size: 14px;font-weight: bold;">Error Count : ${eCount}</div>
						<div align="left" style="color: grey;font-size: 14px;font-weight: bold;">UnProcess Count : ${unPCount}</div>
					</div>
				</div>	 
			</div>
			<!-- ************************************************************** -->  	
   			
   			<!-- ************************************************************** -->
	   	</div>
	   </div>
	   </div>
	</div>
	<div style="margin-left: 5px;" id="empGrid" class="sub-down">
				<table id="example" class="table table-striped table-bordered nowrap" style="width: 100%">
					<%-- <%if(userDto.getRole().equalsIgnoreCase("End User")){ %>	 --%>
						<thead>
							<tr>
								<th>Sr. No.</th>
								<th>User Name</th>
								<th>Process Name</th>
								<th>Total Record</th>
								<th>Processed Record</th>
								<th>Error Record</th>
								<th>Unprocessed Record</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>Vishal Patole</td>
								<td>Claims</td>
								<td>0</td>
								<td>0</td>
								<td>0</td>
								<td>0</td>
							</tr>
							<tr>
								<td>2</td>
								<td>Vishal Patole</td>
								<td>NAV</td>
								<td>27</td>
								<td>19</td>
								<td>8</td>
								<td>0</td>
							</tr>
							<tr>
								<td>3</td>
								<td>Vishal Patole</td>
								<td>Termclaim</td>
								<td>27</td>
								<td>14</td>
								<td>6</td>
								<td>7</td>
							</tr>
							<tr>
								<td>4</td>
								<td>Avinash Patil</td>
								<td>NAV</td>
								<td>27</td>
								<td>19</td>
								<td>8</td>
								<td>0</td>
							</tr>
							<tr>
								<td>5</td>
								<td>Vishal Patole</td>
								<td>Termclaim</td>
								<td>27</td>
								<td>14</td>
								<td>6</td>
								<td>7</td>
							</tr>
						</tbody>
					<%-- <%} %> --%>
				</table>
	</div>	  
</div>
</form>
</body>
</html>