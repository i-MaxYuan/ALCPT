var validRegId = false;
var validName = false;
var validEmail = false;
var validGender = false;
var validIdentity = false;
var validPrivilege = false;
var validStuId = false;
var validGrade = false;
var validSquadron = false;
var validDepartment = false;

var originSystem = false;
var originTestM = false;
var originTBM = false;
var originTBO = false;
var originViewer = false;
var originTestee = false;

// Get original privilege
window.onload = function() {
	var system = document.getElementById("SystemManager");
	var testM = document.getElementById("TestManager");
	var tbM = document.getElementById("TBManager");
	var tbO = document.getElementById("TBOperator");
	var viewer = document.getElementById("Viewer");
	var testee = document.getElementById("Testee");

	if (system.checked === true) originSystem = true;
	if (testM.checked === true) originTestM = true;
	if (tbM.checked === true) originTBM = true;
	if (tbO.checked === true) originTBO = true;
	if (viewer.checked === true) originViewer = true;
	if (testee.checked === true) originTestee = true;
};

// Checkout whether privilege change and privilege can't be empty.
function privilege_valid() {
	var privilegeInvalid = document.getElementById("privilege_invalid");
	var system = document.getElementById("SystemManager");
	var testM = document.getElementById("TestManager");
	var tbM = document.getElementById("TBManager");
	var tbO = document.getElementById("TBOperator");
	var viewer = document.getElementById("Viewer");
	var testee = document.getElementById("Testee");

	// Checkout whether privilege is changed.
	if (
		system.checked === originSystem &&
		testM.checked === originTestM &&
		tbM.checked === originTBM &&
		tbO.checked === originTBO &&
		viewer.checked === originViewer &&
		testee.checked === originTestee
	) {
		privilegeInvalid.innerHTML = "";
		validPrivilege = false;
	}
	// Checkout whether privilege isn't null.
	else if (
		system.checked === false &&
		testM.checked === false &&
		tbM.checked === false &&
		tbO.checked === false &&
		viewer.checked === false &&
		testee.checked === false
	) {
		privilegeInvalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Choose one privilege at least.</span>";
		validPrivilege = false;
	} else {
		privilegeInvalid.innerHTML = "";
		validPrivilege = true;
	}
	data_valid();
}

// Checkout whether name change and name can't be empty.
function reg_id_valid(origin, input) {
	var invalid_id = document.getElementById("reg_id_invalid");

	if (input.value === "") {
		invalid_id.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
		validRegId = false;
	} else if (input.value.length < 8) {
		invalid_id.innerHTML =
			"<span style='color: red; font-size: 14px'>ID is too short.</span>";
		validRegId = false;
	} else if (origin === input.value) {
		invalid_id.innerHTML = "";
		validRegId = false;
	} else {
		invalid_id.innerHTML = "";
		validRegId = true;
	}
	data_valid();
}

// Checkout whether name change.
function name_valid(origin, input) {
	var name_invalid = document.getElementById("name_invalid");

	if (origin === input.value) {
		validName = false;
		name_invalid.innerHTML = "";
	} else if (input.value === "") {
		validName = false;
		name_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validName = true;
		name_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether email change.
function email_valid(origin, input) {
	var email_invalid = document.getElementById("email_invalid");

	if (origin === input.value) {
		validEmail = false;
		email_invalid.innerHTML = "";
	} else if (input.value === "") {
		validEmail = false;
		email_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validEmail = true;
		email_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether gender change.
function gender_valid(origin, input) {
	var gender_invalid = document.getElementById("gender_invalid");

	if (origin === input.value) {
		validGender = false;
		gender_invalid.innerHTML = "";
	} else if (input.value === "") {
		validGender = false;
		gender_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validGender = true;
		gender_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether identity change.
function identity_valid(origin, input) {
	if (origin === input.value) {
		validIdentity = false;
		document.getElementById("identity_invalid").innerHTML = "";
	} else if (input.value === "") {
		validIdentity = false;
		document.getElementById("identity_invalid").innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validIdentity = true;
		document.getElementById("identity_invalid").innerHTML = "";
	}
	data_valid();
}

// Checkout whether name change and name can't be empty.
function stu_id_valid(origin, stu_ids, input) {
	var arr = stu_ids;
	var invalid_id = document.getElementById("stu_id_invalid");

	if (input.value === "") {
		invalid_id.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
		validStuId = false;
	} else if (origin === input.value) {
		invalid_id.innerHTML = "";
		validStuId = false;
	} else {
		invalid_id.innerHTML = "";
		validStuId = true;
	}
	data_valid();
}

// Checkout whether grade change and not null.
function grade_valid(origin, input) {
	var grade_invalid = document.getElementById("grade_invalid");

	if (origin === input.value) {
		validGrade = false;
		grade_invalid.innerHTML = "";
	} else if (input.value === "") {
		validGrade = false;
		grade_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validGrade = true;
		grade_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether department change.
function department_valid(origin, input) {
	var department_invalid = document.getElementById("department_invalid");

	if (origin === input.value) {
		validDepartment = false;
		department_invalid.innerHTML = "";
	} else if (input.value === "") {
		validDepartment = false;
		department_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validDepartment = true;
		department_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether squadron change.
function squadron_valid(origin, input) {
	var squadron_invalid = document.getElementById("squadron_invalid");

	if (origin === input.value) {
		validSquadron = false;
		squadron_invalid.innerHTML = "";
	} else if (input.value === "") {
		validSquadron = false;
		squadron_invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Required</span>";
	} else {
		validSquadron = true;
		squadron_invalid.innerHTML = "";
	}
	data_valid();
}

// Checkout whether all of data is valid.
function data_valid() {
	var identity = document.getElementById("identity");
	var submit = document.getElementById("submit");

	if (identity.value === "2") {
		if (
			validRegId === true ||
			validName === true ||
			validEmail === true ||
			validGender === true ||
			validIdentity === true ||
			validPrivilege === true ||
			validStuId === true ||
			validGrade === true ||
			validSquadron === true ||
			validDepartment === true
		) {
			submit.disabled = false;
		} else {
			submit.disabled = true;
		}
	} else {
		if (
			validRegId === true ||
			validName === true ||
			validEmail === true ||
			validGender === true ||
			validIdentity === true ||
			validPrivilege === true
		) {
			submit.disabled = false;
		} else {
			submit.disabled = true;
		}
	}
}