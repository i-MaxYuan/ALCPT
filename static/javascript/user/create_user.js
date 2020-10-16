var passRegId = false;
var passIdentity = false;
var passPrivilege = true;
var passStuID = false;

function valid_ID(input) {
	var invalid_id = document.getElementById("invalid_id");

	if (input.value === "") {
		invalid_id.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
		invalid_id.style.display = "block";
		passRegId = false;
	} else if (input.value.length <= 8) {
		invalid_id.innerHTML =
			"<span style='color: red; font-size: 14px'>ID is too short.</span>";
		invalid_id.style.display = "block";
		passRegId = false;
	} else {
		invalid_id.innerHTML = "";
		invalid_id.style.display = "none";
		passRegId = true;
	}
	data_valid();
}

function valid_stuID(input) {
	var invalid_stu_id = document.getElementById("invalid_stu_id");

	if (input.value === "") {
		invalid_stu_id.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
		invalid_stu_id.style.display = "block";
		passStuID = false;
	} else if (input.value.length <= 8) {
		invalid_stu_id.innerHTML =
			"<span style='color: red; font-size: 14px'>ID is too short.</span>";
		invalid_stu_id.style.display = "block";
		passStuID = false;
	} else {
		invalid_stu_id.innerHTML = "";
		invalid_stu_id.style.display = "none";
		passStuID = true;
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

	if (
		system.checked === false &&
		testM.checked === false &&
		tbM.checked === false &&
		tbO.checked === false &&
		viewer.checked === false &&
		testee.checked === false
	) {
		privilegeInvalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Choose one privilege at least.</span>";
		privilegeInvalid.style.display = "block";
		passPrivilege = false;
	} else {
		privilegeInvalid.innerHTML = "";
		privilegeInvalid.style.display = "none";
		passPrivilege = true;
	}
	data_valid();
}

function is_student() {
	var stuID = document.getElementById("stu_id");
	var department = document.getElementById("department");
	var squadron = document.getElementById("squadron");
	var grade = document.getElementById("grade");
	var identity = document.getElementById("identity");

	if (identity.value === "2") {
		stuID.disabled = false;
		department.disabled = false;
		squadron.disabled = false;
		grade.disabled = false;
		passIdentity = true;
	} else {
		stuID.disabled = true;
		stuID.value = "";
		department.disabled = true;
		department.value = "";
		squadron.disabled = true;
		squadron.value = "";
		grade.disabled = true;
		grade.value = "";
		passIdentity = true;
		document.getElementById("invalid_stu_id").innerHTML = "";
		document.getElementById("invalid_stu_id").style.display = "none";
	}
	data_valid();
}

function data_valid() {
	var submit = document.getElementById("submit");
	var identity = document.getElementById("identity");

	if (identity.value === "2") {
		if (
			passRegId === true &&
			passIdentity === true &&
			passPrivilege === true &&
			passStuID === true
		) {
			submit.disabled = false;
		} else {
			submit.disabled = true;
		}
	} else if (identity.value === "1" || identity.value === "3") {
		if (
			passRegId === true &&
			passIdentity === true &&
			passPrivilege === true
		) {
			submit.disabled = false;
		} else {
			submit.disabled = true;
		}
	} else {
		submit.disabled = true;
	}
}