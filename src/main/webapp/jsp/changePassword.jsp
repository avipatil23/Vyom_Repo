<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ include file="header.jsp"%>
<%
UserDto user = (UserDto)session.getAttribute("userDto");
//System.out.println("userDto in password="+user);
%>
 <script>
		 function  f_changePassword(){
			//alert("hello");
			if(document.empForm.oldPassword.value=="")
			{
			alert("Please input Old password");
			document.empForm.oldPassword.focus();
			return false;
			} 

			if(document.empForm.newPassword.value=="")
			{
			alert("Please input New Password");
			document.empForm.newPassword.focus(); 
			return false;
			} 

			if(document.empForm.conPassword.value=="")
			{
			alert("Please input Confirm Password");
			document.empForm.conPassword.focus(); 
			return false;
			} 

			if(document.empForm.newPassword.value != document.empForm.conPassword.value)
			{
			alert("Confirm Password Not Match");
			document.empForm.conPassword.focus(); 
			return false;
			} 

			if(document.empForm.oldPassword.value != "" && 
			document.empForm.newPassword.value != "" &&
			document.empForm.conPassword.value != "" &&
			document.empForm.newPassword.value == document.empForm.conPassword.value){
				var form = $('#empForm');
				$.ajax({				
				url: '/updatePassword.do',
				type: 'POST',
				data: $('#empForm').serialize(),
				success: function (result) {
					alert("Password Save Succsessfully");
					document.empForm.action = "registerProcess.do";
					document.empForm.submit();
				},
				 error: function (xhr, ajaxOptions, thrownError) {
			 	   		alert("Old Password Incorrect = "+thrownError);
			 	 }  
				});	
				}
			}  
		 
		function f_clear(){
			$("#oldPassword").val("");
			$("#newPassword").val("");
			$("#conPassword").val("");
		} 
				
		/* $(document).ready(function() {
		    $("input[name$='pass']").click(function() {
		        var test = $(this).val();

		        $("div.desc").hide();
		        $("#pass" + test).show();
		    });
		}); */
		</script> 
		
</head>
<body>
	<table align="center" height="450px" width="50%" cellpadding="5px">
		<tr>
			<td align="left" valign="top">
				<div class="pageHeader">CHANGE PASSWORD</div>
				
				
				<div id="pass2" class="desc">
					<form name="empForm" id="empForm" method="post">
					<table width="100%" cellpadding="2px" cellspacing="10px" class="tableBorder">
						<tr class="tableHeader2" >
							<td colspan="2">Details</td>
						</tr>
						 	<input type="hidden" name="userID" id="userID" value="<%-- <%=userDto.getUserID()%> --%>"/> 							
						<tr> 
							<th align="left">OLD PASSWORD <span class="mandetoryField">*</span></th>
							<td><input type="password" name="oldPassword" id="oldPassword" size="15" maxlength="15"></td>
						</tr>
						<tr> 
							<th align="left">NEW PASSWORD <span class="mandetoryField">*</span></th>
							<td><input type="password" name=newPassword id="newPassword" size="15" maxlength="15"></td>
						</tr>
						<tr> 
							<th align="left">CONFIRM PASSWORD <span class="mandetoryField">*</span></th>
							<td><input type="password" name="conPassword" id="conPassword" size="15" maxlength="15"></td>
						</tr>
						<tr class="tableButtonRow">
							<td colspan="2" align="center">
								<input type="button" value="Change Password" class="button175" onclick="f_changePassword()">&nbsp;
								<input type="button" value="Clear" class="button100" onclick="f_clear()">									
							</td>
						</tr>
					</table>
				</form>
				</div>
			</td>
		</tr>	
	</table>
</body>
</html>
