

function inputCheck(){
	const ch_ID = document.getElementById("userID").value;
	const ch_Password = document.getElementById("inputPassword").value;
	const ch_PasswordCh = document.getElementById("inputPasswordCheck").value;
	const ch_Name = document.getElementById("userName").value;
	const ch_Email = document.getElementById("eMail").value;
	const reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	
	if((ch_ID =="")|(ch_ID =="ID중복확인을 해주세요")){
		alert("ID를 확인해주세요");
		document.getElementById("userID").focus();
		return;
	}
	if(ch_Password ==""){
		alert("check password");
		document.getElementById("inputPassword").focus();
		return;
	}
	if(ch_PasswordCh ==""){
		alert("check password");
		document.getElementById("inputPasswordCheck").focus();
		return;
	}
	if(ch_Name ==""){
		alert("check name");
		document.getElementById("userName").focus();
		return;
	}
	if(ch_Email ==""){
		alert("check e-mail adress");
		document.getElementById("eMail").focus();
		return;
	}else if (!(reg_email.test(ch_Email))){
		alert("error e-mail adress");
		document.getElementById("eMail").focus();
		return;
	}	
	
	if(ch_PasswordCh !== ch_Password){
		alert("입력하신 패스워드가 다릅니다.");
		document.getElementById("ch_PasswordCh").focus();
		return;
	}
	document.join.submit();
}



function checkID(userID){
	url = "checkID.jsp?userID="+userID;
	window.open(url, "chekID", "width=500, height=300" );  
}

function init(){
	console.log("Strat inputCheck.js");
}
init();