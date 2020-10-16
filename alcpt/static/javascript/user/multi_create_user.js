var passPrivilege = true;
var passFile = false;

function privilege_not_empty() {
	var privilegeInvalid = document.getElementById("privilege_invalid");
	var system = document.getElementById("32");
	var testM = document.getElementById("16");
	var tbM = document.getElementById("8");
	var tbO = document.getElementById("4");
	var viewer = document.getElementById("2");
	var testee = document.getElementById("1");

	if (system.checked === false && testM.checked === false && tbM.checked === false && tbO.checked === false && viewer.checked === false && testee.checked === false) {
		privilegeInvalid.innerHTML = "<span style='color: red; font-size: 14px'>Choose one privilege at least</span>";
		passPrivilege = false;
	} else {
		privilegeInvalid.innerHTML = "";
		privilegeInvalid.style.display = "none";
		passPrivilege = true;
	}

	is_valid();
}

function file_not_empty() {
	if (document.getElementById("users_file")) {
		passFile = true;
	} else {
		passFile = false;
	}

	is_valid();
}

function is_valid() {
	var submit = document.getElementById("submit");

	if (passFile === true && passPrivilege === true) {
		submit.disabled = false;
	} else {
		submit.disabled = true;
	}

	document.getElementById("test").innerHTML = "~";
}