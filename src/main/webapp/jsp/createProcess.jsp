<%@page import="com.company.myapp.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="header2.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Create process</title> 
  
     <link rel="stylesheet" href="css/jquery.dataTables.css">	
	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/jquery-1.12.4.min.js"></script>	
	
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable( {
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
    <style type="text/css">
	    table{
	        width: 100%;
	        margin: 20px 0;
	        border-collapse: collapse;
	    }
	
	    table, th, td{
	        border: 0px solid #cdcdcd;
	    }
	
	    table th, table td{
	        padding: 5px;
	        text-align: left;
	    } 
	    
	    .table > thead > tr > td.warning, .table > tbody > tr > td.warning, .table > tfoot > tr > td.warning, .table > thead > tr > th.warning, .table > tbody > tr > th.warning, .table > tfoot > tr > th.warning, .table > thead > tr.warning > td, .table > tbody > tr.warning > td, .table > tfoot > tr.warning > td, .table > thead > tr.warning > th, .table > tbody > tr.warning > th, .table > tfoot > tr.warning > th{
	    background-color: #eee;
	    }
	    
	    .rButton{
	    	display:inline-block;
			 margin-bottom:0;
			 font-size:14px;
			 font-weight:400;
			 line-height:1.42857143;
			 text-align:center;
			 white-space:nowrap;
			 vertical-align:middle;
			 -ms-touch-action:manipulation;
			 touch-action:manipulation;
			 cursor:pointer;
			 -webkit-user-select:none;
			 -moz-user-select:none;
			 -ms-user-select:none;
			 user-select:none;
			 background-image:none;
			 border:1px solid transparent;
			 border-radius:4px;
			 color:#fff;
			 background-color:#0d47a1;
			 border-color:#0d47a1;
	    }
	    
	    .form-contro {
			 display:block;
			 width:30%;
			 height:30px;
			 /* margin-bottom: 10px; */
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
		.form-contro1 {
			 display:block;
			 width:40%;
			 font-size:14px;
			 line-height:1.42857143;
			 color:#555;
			 text-align: left;
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
		.form-contro2 {
			 display:block;
			 width:40%;
			 font-size:14px;
			 line-height:1.42857143;
			 color:#555;
			 text-align: center;
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
	</style>
	
	
	<script type="text/javascript">
		function IsName(name) {
			var regx = /^[a-zA-Z-,]+$/;
			
			/* to allow space after character /^[a-zA-Z-,]+(\s{0,1}[a-zA-Z-, ])*$/ */
			
			if (!regx.test(name)) {
				return false;
			} else {
				return true;
			}
		}
		
		function IsNum(len) {
			
			var intRegex = /^[0-9]+$/;
			if (!intRegex.test(len)) {
			
				return false;
			} else {
			
				return true;
			}
		}
		
		<%-- function MyTest(){
			//alert("Test");
			document.createProcess.action = "validateProcessName.do?nsec=<%=nsec%>";
			document.createProcess.submit();
		} --%>
		
		function validate(){
			var text = "";
		/* 	if ($.trim($("#processName").val()) == "") {
				text = "Please Enter Process Name\n";
			} else if (!IsName($("#processName").val())) {
				text = "Please Enter valid Process Name\n";
			}
		 	 */
			$("input[type='text']").each(function() {				
				if ($( this ).val() == "") {
					$( this ).css("border-color", "red");					
					 text +=$( this ).attr("name")+" cannot be blank \n";
				}else
					
					if (!IsName($("#ProcessName").val()) && $( this ).attr("name")=="ProcessName") {
					 
					
						 $( this ).css("border-color", "red");
						text += "Please enter valid Process Name\n";
				}
				else 
					
					if (!IsName($("#FieldName").val()) && $( this ).attr("name")=="FieldName") {
					 
					
					 $( this ).css("border-color", "red");
					text += "Please enter valid Field Name\n";
					
				} else 
					
					if (!IsNum($("#length").val()) && $( this ).attr("name")=="length") {
 				 	
					/*  alert("Name:"+$( this ).val()+"valid:"+IsNum($("#Length").val()));  */
					 
					 $( this ).css("border-color", "red");
					text += "Please enter valid length\n"; 
				} 
				
			}); 
		 	 
		 	/*  if (!IsName($("#ProcessName").val())) {
				text += "Please Enter valid Process Name\n";
			}				  	 */
				return text;
		}
		
		function f_Check() {
			var text = validate();	
		
			var fieldName = $("#fieldName").val();
		
			var length = $("#length").val();
			
			var rowCount = document.getElementById('example').rows.length;
						
			if(text == ""){
				if(rowCount == 3){
					alert("Please add atleast one row");	
				}else{	
					if(confirm("Are you sure you want to Save?")){					
						document.createProcess.action = "saveProcess.do?nsec=<%=nsec%>";
						document.createProcess.submit();
					}
				}
			}else{
				alert(text);
			}			
		}
		
	</script>
</head>
<body>	
     <script>     	
		function arrangeSno(){
		    var i=-1;
		    $('#example tr').each(function() {
		     $(this).find(".sNo").html(i);
		     i++;
		    }); 
	    }
		$(document).ready(function(){
		$('#addButId').click(function(){
			
		    var sno=$('#example tr').length-1;
		        trow=  "<tr class='warning'><td class='sNo'>"+sno+"</td>"+
		            "<td id='name'><input class='form-contro1' id='FieldName' name='FieldName' type='text' size='20' maxlength='30' autocomplete='off'></td>"+	             
		            "<td><select class='form-contro1' id='dataType' name='dataType'><option value='Integer'>Integer</option>"+
		            "<option value='String'>String</option>"+
		            "</select></td>"+
		            "<td id='len'><input class='form-contro2' id='Length' name='Length' type='text' size='2' maxlength='2' autocomplete='off'></td>"+
		           "<td><button type='button' class='rButton'>Remove</button></td></tr>";
		       $('#example').append(trow);
		     });
			 trow1 = "<tr class='warning'><td class='sNo'>1</td>"+
		            "<td><input class='form-contro1' id='status' name='status' type='text' value='Status' autocomplete='off' readonly='readonly' required></td>"+	             
		            "<td><input class='form-contro1' id='data' name='data' type='text' value='String' readonly='readonly' required></td>"+
		            "<td><input class='form-contro2' id='Length' name='Length' type='text' value='25' autocomplete='off' readonly='readonly' required></td>"+
		            "<td><button type='button' class='rButton'  disabled='disabled'>Remove</button></td></tr>";
			$('#example').append(trow1);
		});
	 
		$(document).on('click', 'button.rButton', function () {
		       $(this).closest('tr').remove();
		       arrangeSno();
		     return false;
		});		
	 </script> 
	<form id="createProcess" name="createProcess" method="post">
		<div class="container">
			<div align="center" style="color: red;">
				<h4>${msg}</h4>
				<h4>${str}</h4>
			</div>
			<div class="pageHeader">Process Details</div> 
			<table width="40%" cellpadding="2px" cellspacing="5px" >
				<tr>
					<th width="20%" align="left" class="pageHeader1">PROCESS NAME <span class="mandetoryField">*</span></th>
						<td><input class="form-contro" type="text" name="ProcessName" id="ProcessName" size="20" maxlength="30" value="${processName}" autocomplete="off" autofocus onblur="MyTest()"/></td>			
				
			</table>
		    <table id="example" class="table table-striped table-bordered nowrap">
		        <thead>
			        <tr>
			            <th class="pageHeader1">S.No</th>
			            <th class="pageHeader1">Field Name</th>
			             <th class="pageHeader1">Data Type</th>
			             <th class="pageHeader1">Length</th>
			             <th class="pageHeader1">Remove</th>
			        </tr>				 		
		    	</thead>
		    	<tbody>
		    		<tr>
		    		</tr>
		    	</tbody>
		    </table>
		    <!-- <table border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2"
								style="display: none;">1</div></td>
						<td class="code"><div class="container"
								style="display: none;">
								<div class="line number1 index0 alt2" style="display: none;">&nbsp;</div>
							</div></td>
					</tr>
				</tbody>
			</table> -->
		    <br/>
		    <input id="addButId" type="button" class="btn btn-primary" value="Add Values">
		 <div align="center">
		    <br><input type="button" class="btn btn-info" value="Save" onclick="f_Check()"></div>
		</div>
	</form>  
</body>
</html>