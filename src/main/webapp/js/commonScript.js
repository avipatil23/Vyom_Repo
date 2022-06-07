/*function f_validateUser(){
	var text = "";
	var chkPassport = document.getElementById("pName");
	if ($.trim($("#fName").val()) == "") {
		text += "Please Enter First Name\n";
	} else if (!IsName($("#fName").val())) {
		text = "Please Enter valid First Name\n";
	}	
	if ($.trim($("#lName").val()) == "") {
		text += "Please Enter Last Name\n";
	} else if (!IsName($("#lName").val())) {
		text = "Please Enter valid Last Name\n";
	}
	
	if ($.trim($("#uName1").val()) == "") {
	
		text += "Please Enter User Name\n";
	} else if (!IsName($("#uName1").val())) {
		text = "Please Enter valid User Name\n";
	}
	
		
	if ($.trim($("#address").val()) == "") {
		text += "Please Enter Address\n";
	} 	
	if ($.trim($("#pwd").val()) == "") {
		text += "Please Enter Password\n";
	} 
	if ($.trim($("#role").val()) == "") {
		text += "Please Enter Role\n";
	} else if (!IsName($("#role").val())) {
		text = "Please Enter valid Role\n";
	}	 
    if (!chkPassport.checked) {
        text += "Please check atleast one Checkbox.";
    }
	return text;
}*/
	
	function validateInfo() {
		
	}
	
	/*
	function alphanumeric(inputtxt)
	{
	 var letterNumber = /^[0-9a-zA-Z]+$/;
	 if((inputtxt.value.match(letterNumber)) 
	  {
	   return true;
	  }
	else
	  { 
	   alert("message"); 
	   return false; 
	  }
	  }*/
	
	function f_clearInfo(){	
		
		$("#fName").val("");
		$('input:radio[name=gender]:checked').val("Male");
		$("#uName1").val("");
		$("#lName").val("");
		$("#address").val("");			  
		$("#pwd").val("");
		$("#role").val("");	  	
		
		
		var checkboxs=document.getElementsByName("pName");
		var checkboxsAll=document.getElementsByName("All");		
	
	    for(var i=0,l=checkboxs.length;i<l;i++)
	    {
	    	
	        if(checkboxs[i].checked)
	        {
	        	checkboxs[i].checked=false;
	        }
	    }
	    checkboxsAll[0].checked=false;
	
	}
	
	
	function IsName(name) {
		var regx = /^[a-zA-Z. ]+$/;
		
		alter(name);
		if (!regx.test(name)) {
			return false;
		} else {
			return true;
		}
	}
	
	function f_SelectAll(){
		
		var role = document.getElementById('role').value;	
				
		if(role=="Admin"){		
			
			var checkboxsAll=document.getElementsByName("All");		
			checkboxsAll[0].checked=true;			
			f_SelectAllProcess();
			
		}else{
			
			var checkboxsAll=document.getElementsByName("All");
			checkboxsAll[0].checked=false;
			f_SelectAllProcess();
		
		}
		
	}
	
		function f_SelectAllProcess(){
			
			var checkboxsAll=document.getElementsByName("All");
				
			
			if(checkboxsAll[0].checked){
							
				var checkboxs=document.getElementsByName("pName");
			 
			    for(var i=0,l=checkboxs.length;i<l;i++)
			    {
			    	
			       checkboxs[i].checked=true;
			   
			    }
			}else{
					var checkboxs=document.getElementsByName("pName");
					checkboxsAll[0].checked=false;
					for(var i=0,l=checkboxs.length;i<l;i++)
				    {
						
				       checkboxs[i].checked=false;
				   
				    }
			}
			
		}
		
		function f_selectAllCheckbox(){
			
			var checkboxs=document.getElementsByName("pName");
			var j=0;
			for(var i=0,l=checkboxs.length;i<l;i++)
		    {
		    	
		       if(checkboxs[i].checked)
		    	   j++;
		   
		    }
			var checkboxsAll=document.getElementsByName("All");
			
			if (j==checkboxs.length)
				checkboxsAll[0].checked=true;

		}
	
	