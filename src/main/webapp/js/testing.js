function f_validateUser(){
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
		text += "Please Enter valid User Name\n";
	}
	
		
	if ($.trim($("#address").val()) == "") {
		text += "Please Enter Address\n";
	} 	
	if ($.trim($("#pwd").val()) == "") {
		text += "Please Enter Password\n";
	} 
	
	
	if ($.trim($("#role").val()) == "Select" || $.trim($("#role").val()) == "") {
		text += "Please select Role\n";
	}
    /*if (!chkPassport.checked) {
        text += "Please check atleast one Checkbox.";
    }*/
	return text;
}

/*function f_clearUser(){	
	$("#fName").val("");
	$('input:radio[name=gender]:checked').val("Male");
	$("#lName").val("");
	$("#uName").val("");
	$("#address").val("");			  
	$("#pwd").val("");
	$("#role").val("");	  
	
	
}*/

function IsName(name) {
	var regx = /^[a-zA-Z-,]+(\s{0,1}[a-zA-Z-, ])*$/;
	if (!regx.test(name)) {
		return false;
	} else {
		return true;
	}
}