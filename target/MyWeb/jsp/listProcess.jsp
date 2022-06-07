<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<title>Process List</title>
	<link href="css/jquery.dataTables.css" rel="stylesheet" type="text/css">
	<link href="css/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css">
	<script type="text/JavaScript" src="js/jquery.dataTables.min.js"></script>
	
	<!-- <script type = "text/javascript" >
		function preventBack(){window.history.forward();}	
		setTimeout("preventBack()", 0);	
		window.onunload=function(){null;};
    </script> -->
	<script type="text/javascript">
		 $(document).ready(function() {
			$('#example').dataTable( {
				"bJQueryUI":true,
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"aoColumnDefs":[{
					'bSortable':false,'aTargets':[5,6]
				}],
				 
				"sScrollX": "100%",
		        "sScrollXInner": "110%",
		        "bScrollCollapse": true
		       
   
		       
		    } );
		} ); 
		
		function f_Process(pType){
			var sel = document.getElementById('list').value;
			document.listProcess.action = "listProcess.do?pType="+pType+"&status="+sel+"&nsec=<%=nsec%>";
			document.listProcess.submit();
		}
		
		function f_Back(){
			document.listProcess.action = "dashboard.do?pType=new&nsec=<%=nsec%>";
			document.listProcess.submit();
		}
		function f_Back1(pType){
			document.listProcess.action = "dashboard.do?pType="+pType+"&nsec=<%=nsec%>";
			document.listProcess.submit();
		}
	</script>
	<style type="text/css">
		.container1 {
		    width: 98%;
		    margin-left: 5px;
		}
		.header{
			color: #0d47a1;/*#e65100;*/
			font-size: 20px;
			font-weight: bold;
		}
		.custom{
		  color:#337ab7;
		  opacity:0.7;
		}
		
		.custom:active{
		  color: #337ab7;
		}
	</style>
</head>
<body>
<form name="listProcess" id="listProcess" method="post">	
	<div style="width: 90%; float: left; margin-left: 5px">
		<div style="width: 35%; float: left;">
			<label style="color: #0099CC;font-size: 18px;font-weight: bold;">Process Name <span class="mandetoryField" >:</span></label>
			<label style="color: #e65100;font-size: 15px;font-weight: bold;">${pType}</label>
		</div>
		<div style="width: 50%; float: left;">
			<label style="color: #0099CC;font-size: 18px;font-weight: bold;">Status <span class="mandetoryField" >:</span></label>
				<div style="width: 80%; float: right;">
					<select class="form-control3" style="color: #e65100;font-size: 15px;font-weight: bold;" id="list" name="list" autocomplete="on" onchange="f_Process('${pType}')">
						<option value="Processed"${"Processed" eq status ? 'selected' : ''}>Processed</option>
						<option value="Error"${"Error" eq status ? 'selected' : ''}>Error</option>
						<option value="Both"${"Both" eq status ? 'selected' : ''}>Both</option>					
					</select>
				</div>
		</div>
		<div style="width: 10%; float: left;">
			<button type="submit" class="btn btn-info" value="Back" onclick="f_Back1('${pType}')">Back</button>
		</div>
	</div>
	<!-- <hr style="color: red"> --><br>
	<div id="sub-title" class="container1">		      
    	<hr style="color: red">	
		<div id="empGrid" style="overflow: auto;height: 600px;overflow-x: hidden">
			<c:if test="${empty processData}">
				<h3 style="color: #b71c1c">Data not found.....</h3>
				<!-- <button type="submit" class="btn btn-info" value="Back" onclick="f_Back()">Back</button> -->
			</c:if>
			<c:if test="${not empty processData}">
				<table  cellpadding="0" cellspacing="0" border="1" class="display" id="example">
					<thead>
						<tr >
							<th> </th>
							<c:set var="startLoop" scope="page" value="0"/> 
							<c:forEach items="${processData}" var="maps" >
							 
							 	<c:if test="${startLoop == 0 }">
						      	  <c:forEach items="${maps}" var="mapItem" varStatus="mapsIndex">
							            
							 	      	<th> ${mapItem.key}</th>
							 	      							      		
							      		<c:set var="startLoop" scope="page" value="1"/>							      		
							    </c:forEach>
						   		</c:if>
						   	</c:forEach>											
						</tr>
					</thead>
					<tbody>													
						<c:forEach items="${processData}" var="maps" >
							<c:set var="startLoop" scope="page" value="0"/>	
							<c:set var="loop" scope="page" value="0"/>							
							<tr>								
								<c:forEach items="${maps}" var="mapItem" varStatus="mapsIndex">
									<c:set var="index" scope="page" value="0"/>								
									<c:if test="${startLoop==0}">										
										<c:if test="${loop==0}">										
											<c:forEach items="${maps}" var="map">
												<c:if test="${fn:contains(map.value,'Error')}">
													<c:set var="index" scope="page" value="1"/>
													<td style="background-color: #ccff90;" align="center"><a href="editProcess.do?pType=${pType}&status=${status}&ID=${mapItem.value}&nsec=<%=nsec%>"><span class="glyphicon glyphicon-edit custom"></span></a></td>
												</c:if>
												
												<c:if test="${(index==0) && (map.key eq 'Status')}">
													<c:if test="${!fn:contains(map.value,'Error')}">
														<td></td>
													</c:if>	
												</c:if>				
												
												<c:set var="loop" scope="page" value="1"/>												
											</c:forEach>									
										</c:if>										
										<c:set var="startLoop" scope="page" value="1"/>
									</c:if>	
									<c:if test="${fn:contains(mapItem.value,'Error')}">
										<td><span style="color: red">${mapItem.value}</span></td>
									</c:if>	
									<c:if test="${!fn:contains(mapItem.value,'Error')}">
										<td> ${mapItem.value}</td>
									</c:if>	  							            
						      		<c:set var="startLoop" scope="page" value="1"/>							      		
						    	</c:forEach>
					    	</tr>
				   		</c:forEach>				   		
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
</form>
</body>
</html>