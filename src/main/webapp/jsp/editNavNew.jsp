
<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <%@ page errorPage="error.jsp" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="header2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edit Data</title>
<style type="text/css">
table {
	width: 60%;
	margin: 20px 0;
	border-collapse: collapse;
}


table, th, td {
	border: 0px solid #cdcdcd;
}

table th, table td {
	padding: 2px;
}

table th {
	text-align: left;
}

rButton {
	color: #fff;
	background-color: #286090;
	border-color: #204d74
}

.contain1 {
	height: 420px;
	width: 100%;
	overflow-y: auto;
	padding-top: 15px;
	/* background-color: #C0D7EF; */
}

.contain2 {
	height: auto;
	width: 100%;
	overflow-y: auto;
	padding-top: 15px;
	/* background-color: #C0D7EF; */
}

#container {
	width: 100%;
	text-align: center;
	margin-left: 17px;
	margin-bottom: 25px;
	padding-top: 25px;
}

#left {
	float: left;
	width: 33%;
	min-height: 1Px;
	margin-right: 10px
}

#center {
	display: inline-block;
	margin: 0 auto;
	width: 33%;
}

#right {
	float: right;
	width: 33%;
}

.buttonDiv {
	text-align: center;
	padding-top: 10px;
}
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	
	
	function validateData() {
		
		var text="";
		<c:forEach items="${processColsDetails}" var="maps">
		
			<c:forEach items="${maps}" var="listItem">
				
				<c:if test="${listItem.key eq 'FieldName'}">
				var fieldName="${listItem.value}";
				/* alert("fieldName:"+fieldName); */
				</c:if>
				
				<c:if test="${listItem.key eq 'DataType'}">
				var dataType="${listItem.value}";
				/* alert("dataType:"+dataType); */
				</c:if>
				
				<c:if test="${listItem.key eq 'length'}">
				var length="${listItem.value}";
				/* alert("length:"+length); */
				</c:if>
						
			</c:forEach>
				
				
			fieldName1 = document.getElementById(fieldName); 
			var letters="";
			if (dataType=="String"){
				 letters = /^[0-9a-zA-Z" "/]+$/;				
			}
			if (dataType=="Integer"){
				 letters = /^[0-9]+$/;				
			}
			
			if(!(fieldName1.value.match(letters)))
			{		
				text +="Please enter valid characters for "+fieldName+"\n";
			
			}
		</c:forEach>
		
		return text;
	}
	
function updateInfo() {
	
	var updateData=false;

	<c:forEach items="${processRecord}" var="maps">
	
	var uiValue=document.getElementById("${maps.key}").value;
	
	var dbValue="${maps.value}";
	
	
	
	
	if(!(dbValue==uiValue)){
		updateData=true;	
	}
	
	</c:forEach>
	
	return updateData;
	
}
	
	function  f_Update(pType) {
		
		
		var update=updateInfo();
		var text=validateData();
		
		if(update){
	
		 if(text == ""){
			var inputs = document.getElementById("editNAVNew").getElementsByTagName("input");
			var length;
			var value1 = new Array();
	
			for (var i = 0, length = inputs.length; i < length; i++) {
			     // Check we have [type='text']
			     if (inputs[i].type != "hidden") {
			         continue;
			     }
			     value1.push(inputs[i].value);
			}
			//alert(value1);
			
			if(confirm("Are you sure you want to update?")){		
			document.editNAVNew.action = "updateProcess.do?pType="+pType+"&nsec=<%=nsec%>";
			document.editNAVNew.submit();
			}
		}else{
			
			alert(text);
		}
	  }else{
		  
		  alert("No change found");
	  }
	}
	
	function f_Cancel(pType,status){
		document.editNAVNew.action = "listProcess.do?pType="+pType+"&status="+status+"&nsec=<%=nsec%>";
		document.editNAVNew.submit();
	}
	</script>


</head>
<body>
	<%-- <form  method="post" id="editNAVNew" name="editNAVNew" action="updateProcess.do?pType=${pType}&nsec=<%=nsec%>"> --%>
	<form method="post" id="editNAVNew" name="editNAVNew">
		<%
			Map<String, Object> processRecord = (Map<String, Object>) request.getAttribute("processRecord");
			System.out.println("processRecord:" + processRecord.keySet().size());

			System.out.println("processRecord:" + processRecord);
			Iterator<Entry<String, Object>> iterator = processRecord.entrySet().iterator();
			int j = 1;
			String idValue = null;
			String alignValue = null;
			int flag = 0;

		%>
		<div class="form-area">
			<div class="pageHeader" align="center" 	style="padding-top: 10px;"> Edit Process Details:
				${pType}</div>

			<div class="pageHeader5" align="center">
				Error Message: <span style="color: Red"> <%=processRecord.get("Error_Msg") %>
			</div>
			
			<%
			

			if (processRecord.keySet().size() <= 15) {
				flag = 1; %>
				<div class="contain2">				
				<%
			} else {
				
				flag = processRecord.keySet().size() / 15;
				
				flag++;
				%>
				<div class="contain1">	
				
				<%
			}
			int divIdProperty = 1;
		
					for (int i = 0; i < flag; i++) {

						j = 0;

						if (divIdProperty > 3)
							divIdProperty = 1;

						if (processRecord.keySet().size() < 15) {
				%>
				<div id="left" align="center"></div>
				<%
					idValue = "center";
						} else {

							if (divIdProperty == 1)
								idValue = "left";
							if (divIdProperty == 2)
								idValue = "center";
							if (divIdProperty == 3)
								idValue = "right";
						}

						divIdProperty++;

						
				%>

				<div id="<%=idValue%>" align="center">
					<table cellpadding="0px" cellspacing="0px">


						<%
							while (iterator.hasNext()) {
									System.out.println("j:"+j);
									
									if (j == 15)
										break;
									Entry<String, Object> entry = iterator.next();
									String key = entry.getKey();

								 	if (entry.getValue() == null) {
										entry.setValue(" ");
									} 

									String value = entry.getValue().toString();	
									System.out.println("value:"+value);
						%>
						<tr>

							<th style="width: 40%"><label class="pageHeader4"
								for="textinput"><%=key%> <span class="mandetoryField"></span></label></th>

							<%
							if (key.equals("Status")) {
							%>

							<td style="width: 60%"><input type="text"
								class="form-control2" id="<%=key%>" name="<%=key%>"
								value="<%=value%>" autocomplete="off" readonly="readonly"></td>
							<%
							}else if (key.equals("Error_Msg")) {
									%>

							<td style="width: 60%"><input type="text"
								class="form-control2" id="<%=key%>" name="<%=key%>"
								value="<%=value%>" autocomplete="off" readonly="readonly"></td>
							<%
									
							}else if (key.equals("ReqID")) {
								%>

							<td style="width: 60%"><input type="text"
								class="form-control2" id="<%=key%>" name="<%=key%>"
								value="<%=value%>" autocomplete="off" readonly="readonly"></td>
							<%
							}else {
								System.out.println("Key:"+entry.getKey()+"Value:"+value);
							%>
							<td style="width: 60%"><input type="text"
								class="form-control2" id="<%=entry.getKey()%>"
								name="<%=entry.getKey()%>" value="<%=value%>" autocomplete="off"></td>
							<%
								}
							%>

						</tr>



						<%
							j++;

								}
						%>



					</table>
				</div>


				<%
					}
				%>


			</div>

			<div align="center" class="buttonDiv">
				<button type="submit" class="btn btn-info" value="Update"
					onclick="f_Update('${pType}')">Update</button>
				<button type="submit" class="btn btn-info" value="Cancel"
					onclick="f_Cancel('${pType}','${status}')">Cancel</button>
				</td>

			</div>
		</div>
		<%-- <input type="hidden" id="processColsDetails" name="processColsDetails" value="${processColsDetails}"/> --%>
</div>
	</form>
</body>
</html>

