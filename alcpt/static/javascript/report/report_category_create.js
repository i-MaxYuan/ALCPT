var passName = false;
var passPrivilege = true;

// Checkout whether privilege is unique.
function unique_name(input) {
	var invalid = document.getElementById("name_invalid");

	if (input.value === "") {
		invalid.innerHTML = "<span style='color: red'>Required</span>";
		passName = false;
	} else {
		invalid.innerHTML = "";
		passName = true;
	}

	data_valid();
}

// Checkout whether privilege is empty.
function privilege_not_empty() {
	var privilegeInvalid = document.getElementById("privilege_invalid");
	var system = document.getElementById("SystemManager");
	var testM = document.getElementById("TestManager");
	var tbM = document.getElementById("TBManager");
	var tbO = document.getElementById("TBOperator");
	var viewer = document.getElementById("Viewer");
	var testee = document.getElementById("Testee");

	if (system.checked === false && testM.checked === false && tbM.checked === false && tbO.checked === false && viewer.checked === false && testee.checked === false) {
		privilegeInvalid.innerHTML = "<span style='color: red; font-size: 14px'>Choose one privilege at least.</span>";
		passPrivilege = false;
	} else {
		privilegeInvalid.innerHTML = "";
		passPrivilege = true;
	}

	data_valid();
}

// Checkout whether all data is valid.
function data_valid() {
	if (passName === true && passPrivilege === true) {
		submit.disabled = false;
	} else {
		submit.disabled = true;
	}
}