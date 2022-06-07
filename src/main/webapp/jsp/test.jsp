<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<title>User Creation</title>
	<link href="//cdn.datatables.net/1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="//cdn.datatables.net/fixedheader/3.1.4/css/fixedHeader.bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="//cdn.datatables.net/responsive/2.2.2/css/responsive.bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- <link href="css/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css"> -->
	
	<script type="text/JavaScript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/JavaScript" src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
	<script type="text/JavaScript" src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap.min.js"></script>
	<script type="text/JavaScript" src="https://cdn.datatables.net/fixedheader/3.1.4/js/dataTables.fixedHeader.min.js"></script>
	<script type="text/JavaScript" src="https://cdn.datatables.net/responsive/2.2.2/js/dataTables.responsive.min.js"></script>
	<script type="text/JavaScript" src="https://cdn.datatables.net/responsive/2.2.2/js/responsive.bootstrap.min.js"></script>
	
	<!-- <script type="text/JavaScript" src="js/jquery.dataTables.min.js"></script> -->
	<script type="text/JavaScript" src="js/testing.js"></script>
	<script type="text/javascript">
		/*  $(document).ready(function() {
			$('#example').dataTable( {
				/* "bJQueryUI":true, */
				/*"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				scrollY: 300,
		        paging: false
		    } );
		} );  */
		
		$(document).ready(function() {
		    var table = $('#example').DataTable( {
		        responsive: true
		    } );
		 
		    new $.fn.dataTable.FixedHeader( table );
		} );
	</script>
	<style type="text/css">
		.form-contro {
			 display:block;
			 width:50%;
			 height:34px;
			 margin-bottom: 10px;
			 padding:6px 12px;
			 font-size:14px;
			 line-height:1.42857143;
			 color:#555;
			 background-color:#fff;
			 background-image:none;
			 border:1px solid #ccc;
			 border-radius:4px;
			 -webkit-box-shadow:inset 0 1px 1px rgba(0,0,0,.075);
			 box-shadow:inset 0 1px 1px rgba(0,0,0,.075);
			 -webkit-transition:border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
			 -o-transition:border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			 transition:border-color ease-in-out .15s,box-shadow ease-in-out .15s
		}
		
		.dataTables_paginate {
			float: left;
			text-align: right;
			margin-left: 5px;
			margin-top: 10px;
		}
		
		.dataTables_filter {
			float: left;
			text-align: right;
			margin-left: 10px;
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
		   width: 40%;
		}
		
		.col-sm-6 {
		    width: 40%;
		    height: 100%;
		}
	</style>
	<script type="text/javascript">
		<%-- function f_Save() {
			var text = f_validateUser();
		  	var fName = $("#fName").val();
		  	var lName = $("#lName").val();			  
		  	var address = $("#address").val();
		  	var gender = $('input:radio[name=gender]:checked').val();		    
			var pwd = $("#pwd").val();
			var role = $("#role").val();
			
			var favorite = new Array();
            $.each($("input[name='pName']:checked"), function(){            
                favorite.push($(this).val());
            });
            alert(favorite);
			
			data = {'fName' : fName, 'lName' : lName, 'address' : address, 
				'gender' : gender, 'pwd' : pwd, 'role' : role, 'pName' : favorite};
			if(text == ""){  
				if(confirm("Are you sure you want to Save?")){
					$.ajax({
		         		  url: "./saveUser.do?nsec=<%=nsec%>",
		         		  type: "POST",
		         		  data : data,
		         		  success: function(data){
			         		alert("Data Save Successfully..");
		         			document.userForm.action = "createUser.do?nsec=<%=nsec%>";
		  				    document.userForm.submit();
						  },
		         		  error: function(e) {
		         			 alert(e);
		         			 confirm("Data Not Save Successfully..");
		         		  }
		         	});	 
				}
			}else{
				alert(text);
				return;
			}
		} --%>
		
		function f_Save(){
			var text = f_validateUser();
			if(text == ""){
				var checkboxs=document.getElementsByName("pName");
			    var okay=false;
			    for(var i=0,l=checkboxs.length;i<l;i++)
			    {
			        if(checkboxs[i].checked)
			        {
			            okay=true;
			            break;
			        }
			    }
			    if(okay){
			    	if(confirm("Are you sure you want to Save?")){					
						document.userForm.action = "saveUser.do?nsec=<%=nsec%>";
						document.userForm.submit();
			    	}
			    }
			    else 
			    	alert("Please check a checkbox");
			}else{
				alert(text);
			}
		}
	</script>
</head>
<body>
	<div class="container">
	<div align="center" style="color: red;"><h5>${msg}</h5></div>
	<form name="userForm" id="userForm">
		<div class="sub-left">
			<div><h4 style="color: #0099CC;">New User Creation</h4></div>
			<div style="width: 100%">	
				<table width="100%" cellpadding="5px">
					<tr>
						<td>
							
							
							<table width="100%" cellpadding="10px" cellspacing="10px">														
								<tr>
									<th width="25%" align="left">FIRST NAME <span class="mandetoryField">*</span></th>
									<td style=""><input class="form-contro" type="text" name="fName" id="fName" place size="20" maxlength="50" autocomplete="off" autofocus/></td>
								</tr>
								<tr>
									<th width="25%" align="left">LAST NAME <span class="mandetoryField">*</span></th>
									<td><input class="form-contro" type="text" name="lName" id="lName" size="20" maxlength="50" autocomplete="off"/></td>
								</tr>					
								<tr>
									<th  width="25%" align="left">GENDER <span class="mandetoryField">*</span></th>   
				            		<td colspan="5px">  <label  >   
					            			<input name="gender"  id="male" value="Male"  type="radio" checked="checked"  ${userDto.gender == 'Male' ? 'checked' : ''}>
					            			Male
					          			</label>
					           			<label >
					            			<input name="gender" id="female" value="Female" type="radio"  ${userDto.gender == 'Male' ? 'checked' : ''}>
					            			Female
					          			</label>
					            	</td>
					            </tr>				            
					            <tr> 
									<th  width="25%" align="left">ADDRESS <span class="mandetoryField">*</span></th>
									<td style="padding-bottom: 5px;"><textarea style="border-radius: 5px;"  rows="3" cols="25" id="address" name="address"></textarea></td>
								</tr>	
								<tr> 
									<th  width="25%" align="left">PASSWORD <span class="mandetoryField">*</span></th>
									<td><input class="form-contro" type="text" name="pwd" id="pwd" size="20" maxlength="50" autocomplete="off"/></td>
								</tr>
								<tr> 
									<th  width="25%" align="left">ROLE <span class="mandetoryField">*</span></th>
									<!-- <td><input class="form-contro" type="text" name="role" id="role" size="20" maxlength="50" autocomplete="off"/></td> -->
									<td>
									<select class="form-contro" id="role" name="role">
										<option value="Admin">Admin</option>
										<option value="End User">End User</option>
									</select>
								</td>
								</tr>
								<tr>
									<td style="padding-top: 50px;" colspan="2" align="right">
										<input type="button" class="btn btn-info" value="Save" onclick="f_Save()">&nbsp;&nbsp;&nbsp;
										<input type="button" class="btn btn-info" value="Clear" onclick="f_Clear()">									
									</td>
								</tr>
								
							</table>
						</td>
					</tr>	
				</table>
			</div>
		</div>
		<br>
		<div class="sub-right" style="margin-top: 25px;">	
			<div id="empGrid">
				<c:if test="${empty lstProMetaData}">
					<h3 style="color: #b71c1c">Data not found.....</h3>
				</c:if>
				<c:if test="${not empty lstProMetaData}">
					<%-- <table align="left" width="30%" cellpadding="0" cellspacing="0" border="1" class="display" id="example">
						<thead>
							<tr>
								<th> </th>
								<th> Process Name</th>																		
							</tr>
						</thead>
						<tbody>	
							<c:forEach items="${lstProMetaData}" var="maps" >
								<tr>
									<td><input type="checkbox" id="pName" name="pName" value="${maps.pName}"></td>
									<td>${maps.pName}</td>
								</tr>
				   			</c:forEach>			   			
						</tbody>
					</table> --%>
					
					<table  id="example" class="table table-striped table-bordered nowrap" style="width:100%">
				        <thead>
							<tr>
								<th> </th>
								<th> Process Name</th>																		
							</tr>
						</thead>
				       <tbody>	
							<c:forEach items="${lstProMetaData}" var="maps" >
								<tr>
									<td><input type="checkbox" id="pName" name="pName" value="${maps.pName}"></td>
									<td>${maps.pName}</td>
								</tr>
				   			</c:forEach>
						</tbody>
				    </table>				
				</c:if>
			</div>
		</div>
		<input type="hidden" id="nsec" name="nsec" value="${nsec}">
		</form>
	</div>
</body>
</html>