<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <%@ page errorPage="error.jsp" %> --%>
<%
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<%@ include file="header2.jsp"%>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>User Creation</title>
	
	<link href="css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
	<script src="js/bootstrap-select.min.js"></script>
	
	<link href="css/smoothness/bootstrap.min.css" type="text/css">
	<link href="css/responsive.bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
	<script type="text/JavaScript" src="js/jquery-3.3.1.js"></script>
	<script type="text/JavaScript" src="js/jquery.dataTables.min.js"></script>
	<!-- <script type="text/JavaScript" src="js/bootstrap.min.js"></script> -->
	<script type="text/JavaScript" src="js/dataTables.bootstrap.min.js"></script>
	<script type="text/JavaScript" src="js/dataTables.responsive.min.js"></script>
	<script type="text/JavaScript" src="js/responsive.bootstrap.min.js"></script>
	
	<script type="text/JavaScript" src="js/commonScript.js"></script>
	<script type="text/JavaScript" src="js/testing.js"></script>
	<script type="text/javascript">		
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
		
	<script>
		  var model=[];
		  model.firstName="${userData.getFirstName()}";		
		  model.lastName="${userData.getLastName()}";
		  model.userName="${userData.getUserName()}";
		  model.gender="${userData.getGender()}";
		  model.address="${userData.getAddress()}";
		  model.pwd="${userData.getPassword()}";
		  model.role="${userData.getRole()}";
		</script>
	<style type="text/css">
	.form-contro {
		display: block;
		width: 50%;
		height: 34px;
		margin-bottom: 10px;
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.42857143;
		color: #555;
		background-color: #fff;
		background-image: none;
		border: 1px solid #ccc;
		border-radius: 4px;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
			ease-in-out .15s;
		-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
			.15s;
		transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s
	}
	table.dataTable thead .sorting_desc:after {
    /* content: "\e156"; */
	}
	
	.dataTables_paginate {
	/* 	float: left; */
		text-align: right;
		margin-left: 5px;
		margin-top: 10px;
	}
	
	.dataTables_filter {
		float: left;
		text-align: right;
		margin-left: 110px;
	}
	
	.dataTables_info {
		clear: both;
		float: left;
	}
	
	.sub-left {
		float: left;
		width: 50%;
		margin-right: 20px;
	}
	
	.sub-right {
		float: left;
		width: 45%;
	}
	
	.col-sm-6 {
		width: 40%;
		height: 100%;
	}
	</style>
	<script type="text/javascript">	
	


		function f_Save(dbprocessList){
					
			var text = f_validateUser();
			
			if(text == ""){
				
				var letters = /^[A-Za-z]+$/;
				
				var checkboxs=document.getElementsByName("pName");
					
				var fName=document.getElementsByName("fName")[0].value;
			
				var lName=document.getElementsByName("lName")[0].value;			
			
				var uName=document.getElementsByName("uName1")[0].value;				
				
				var gender=document.getElementsByName("gender")[0].value;	
				
				var address=document.getElementsByName("address")[0].value;
			
				var pwd=document.getElementsByName("pwd")[0].value;
				
				var role=document.getElementsByName("role")[0].value;
								
				var update=false;				
				
			 	if(fName!=model.firstName){	update=true;}			
			 	
			 	if(lName!=model.lastName){update=true;}		
			 	if(uName!=model.userName){update=true;}		
				if(gender!=model.gender){update=true;}
				if(address!=model.address){update=true;}			
				if(pwd!=model.pwd){update=true;}				
				if(role!=model.role){update=true;} 
				
			    var okay=false;
			    var processName=null;
			    var processList1=document.getElementsByName("processList");
				var processList2=processList1[0].value;
				
				var test1=processList2.replace(/[\[\]]+/g, "");						
				var processNames=test1.split(",");
				var flag=0;
		
		
				for(var i=0,l=checkboxs.length;i<l;i++)
			    {			 
					
			   	   if(checkboxs[i].checked)
			        {	   
			   		   flag++;
			   		   for(j=0;j<processNames.length;j++){
			   			  
			   			   	var	processName=checkboxs[i].value;					      
					        var	processDbName=processNames[j];
					        var dbName=processDbName.replace(/\s/g,'');					     					        
				         
			   		   }			    
			        } 
			    }
								    
			    if(!(processNames.length==flag) || update){
			    	
			    	if(confirm("Are you sure you want to update?")){					
						document.userUpdateForm.action = "updateUserData.do?nsec=<%=nsec%>&msg=";
						document.userUpdateForm.submit();
			
			 		}
			    }else{
			
			    	alert("No Change Found");			
		    	}
			    
			}else{
				alert(text);
			}
		}
		
		function f_Process(){
			var uName = document.getElementById('list1').value;	
			
			if(uName!="Select"){		
			document.userUpdateForm.action = "updateUser.do?userName="+uName+"&nsec=<%=nsec%>&msg";		
			document.userUpdateForm.submit();
			}else{
				
				f_clearInfo();
			}
			
		}
		
	</script>
		
	<script type="text/javascript">
	$(function(){
	
		// add multiple select / deselect functionality
		$("#selectall").click(function () {
			  $('.case').attr('checked', this.checked);
		});
	
		// if all checkbox are selected, check the selectall checkbox
		// and viceversa
		$(".case").click(function(){
	
			if($(".case").length == $(".case:checked").length) {
				$("#selectall").attr("checked", "checked");
			} else {
				$("#selectall").removeAttr("checked");
			}
	
		});
	});
	</script>

</head>
<body>
	
	<div class="container" >
	
		<div align="left">
				<table>
				<tr>
					<td class="pageHeader">
						UserName :   &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
					</td>
					<td><select class="form-control" id="list1" name="list1"
						autocomplete="on" onchange="f_Process()">
							<option value="Select" >Select</option>
							<c:forEach var="lstUserNameData" items="${lstUserNameData}">
								<c:choose>
									<c:when test="${uName eq lstUserNameData}">
										<option value="${lstUserNameData}" selected="selected">${lstUserNameData}</option>
									</c:when>
									<c:otherwise>

										<option value="${lstUserNameData}">${lstUserNameData}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
					<td>
						<div align="center" style="color: red; margin-left: 150px">
							<h4>${msg}</h4>
						</div>
					</td>
				</tr>
				</table>
		</div> <br><br>
		          
	
		<form name="userUpdateForm" id="userUpdateForm" method="post">
			<div class="sub-left">
				
				
				<div style="width: 100%">
					<table width="100%" cellpadding="5px">
						<tr>
							<td>
								<table width="100%" cellpadding="10px" cellspacing="10px">
									<tr>
										<th width="25%" align="left">FIRST NAME <span
											class="mandetoryField">*</span></th>
										<td style=""><input class="form-contro" type="text"
											name="fName" id="fName" place size="20" value="${userData.getFirstName()}" maxlength="50"
											autocomplete="off" autofocus /></td>
									</tr>
									<tr>
										<th width="25%" align="left">LAST NAME <span
											class="mandetoryField">*</span></th>
										<td><input class="form-contro" type="text" name="lName"
											id="lName" size="20" maxlength="50" value="${userData.getLastName()}"  autocomplete="off" /></td>
									</tr>
									<tr>
										<th width="25%" align="left">USER NAME <span
											class="mandetoryField">*</span></th>
										<td><input class="form-contro" type="text" name="uName1"
											id="uName1" size="20" maxlength="50" value="${userData.getUserName()}" autocomplete="off" /></td>
									</tr>
									<tr>
										<th width="25%" align="left">GENDER <span
											class="mandetoryField">*</span></th>
										<td colspan="5px">
										<label> <input name="gender" id="${userData.getGender() }" value="${userData.getGender() }" type="radio" checked="checked" > Male</label>
										 <label> <input name="gender" id="female" value="Female" type="radio" ${userDto.gender == 'Male' ? 'checked' : ''}> Female	</label></td> 
									</tr>
									<tr>
										<th width="25%" align="left">ADDRESS <span class="mandetoryField">*</span></th>
										<td style="padding-bottom: 5px;">
										<textarea style="border-radius: 5px;" rows="3" cols="25" id="address" name="address" >${userData.getAddress() }</textarea></td>
									</tr>
									<tr>
										<th width="25%" align="left">PASSWORD <span
											class="mandetoryField">*</span></th>
										<td><input class="form-contro" type="password" name="pwd"
											id="pwd" size="20" maxlength="50" value="${userData.getPassword() }" autocomplete="off" /></td>
									</tr>
									<tr>
										<th width="25%" align="left">ROLE <span
											class="mandetoryField">*</span></th>
										<!-- <td><input class="form-contro" type="text" name="role" id="role" size="20" maxlength="50" autocomplete="off"/></td> -->
										<td><select class="form-contro" id="role"
											value="${userData.getRole() }" name="role" onchange="f_SelectAll()">
												<option value="Select" >Select</option>
												<c:choose>
													<c:when test="${userData.getRole() eq 'Admin' }">
														<option value="Admin" selected="selected">Admin</option>
													</c:when>
													<c:otherwise>
														<option value="Admin">Admin</option>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${userData.getRole() eq 'User' }">
														<option value="User" selected="selected">User</option>
													</c:when>
													<c:otherwise>
														<option value="User">User</option>
													</c:otherwise>
												</c:choose>


										</select></td>
									</tr>
									<tr>
										<td style="padding-top: 130px;" colspan="2" align="right">
											<input type="button" class="btn btn-info" value="Update"
											onclick="f_Save('${lstProcessNames}')">&nbsp;&nbsp;&nbsp; <input
											type="button" class="btn btn-info" value="Clear"
											onclick="f_clearInfo()">
										</td>
									</tr>

								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div class="sub-right" ">
				<div id="empGrid">
					<c:if test="${empty lstProMetaData}">
						<h3 style="color: #b71c1c">Data not found.....</h3>
					</c:if>
					<c:if test="${not empty lstProMetaData}">
						<table id="example"
							class="table table-striped table-bordered nowrap"
							style="width: 100%">
							<thead>
								<tr>
									<th><input type="checkbox"  id="All" name="All" onclick="f_SelectAllProcess()" /></th>
									<th>Process Name</th>
								</tr>
							</thead>
							<tbody>
							
								<c:set var="startLoop" scope="page" value="0"/> 
								<c:forEach items="${lstProMetaData}" var="maps">
								
									<c:forEach items="${lstProcessNames}" var="name">
									
									<c:if test="${name eq (maps.pName)}">
										<tr>
										<td><input type="checkbox" id="pName" name="pName" value="${name}" onclick="f_selectAllCheckbox()" checked="checked"></td>
										<td>${maps.pName}</td>
										</tr>
										<c:set var="startLoop" scope="page" value="1"/> 
									
									</c:if>
									
																
									</c:forEach> 
									
									<c:if test="${startLoop==0}">
									<tr>
										<td><input type="checkbox" id="pName" name="pName" value="${maps.pName}" onclick="f_selectAllCheckbox()"></td>
										<td>${maps.pName}</td>
									
									</tr>
										
									</c:if>
									<c:set var="startLoop" scope="page" value="0"/> 
								</c:forEach>
								
							</tbody>
						</table>
					</c:if>
				</div>
			</div>
		
			<input type="hidden" id="UserID" name="UserID" value="${userData.getUserID()}"/> 
			<input type="hidden" id="processList" name="processList" value="${lstProcessNames}"/> 
				
		</form>
	</div>
</body>
</html>