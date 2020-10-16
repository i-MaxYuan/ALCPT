var changeName = false;
var changePrivilege = false;
var passPrivilege = true;
var passName = true;

var originSystem = false;
var originTestM = false;
var originTBM = false;
var originTBO = false;
var originViewer = false;
var originTestee = false;

// Get original privilege
window.onload = function() {
	var system = document.getElementById('SystemManager');
	var testM = document.getElementById('TestManager');
	var tbM = document.getElementById('TBManager');
	var tbO = document.getElementById('TBOperator');
	var viewer = document.getElementById('Viewer');
	var testee = document.getElementById('Testee');

	if (system.checked === true) originSystem = true;
	if (testM.checked === true) originTestM = true;
	if (tbM.checked === true) originTBM = true;
	if (tbO.checked === true) originTBO = true;
	if (viewer.checked === true) originViewer = true;
	if (testee.checked === true) originTestee = true;
};

// Checkout whether privilege change and privilege can't be empty.
function privilege_change() {
	var privilegeInvalid = document.getElementById('privilege_invalid');
	var system = document.getElementById('SystemManager');
	var testM = document.getElementById('TestManager');
	var tbM = document.getElementById('TBManager');
	var tbO = document.getElementById('TBOperator');
	var viewer = document.getElementById('Viewer');
	var testee = document.getElementById('Testee');

	// Checkout wether privilege is changed.
	if (system.checked === originSystem && testM.checked === originTestM && tbM.checked === originTBM &&
		tbO.checked === originTBO && viewer.checked === originViewer && testee.checked === originTestee) {
		privilegeInvalid.innerHTML = '';
		changePrivilege = false;
	}
	// Checkout wether privilege isn't null.
	else if (system.checked === false && testM.checked === false && tbM.checked === false &&
		tbO.checked === false && viewer.checked === false && testee.checked === false) {
		privilegeInvalid.innerHTML = "<span style='color: red; font-size: 14px'>Choose one privilege at least.</span>";
		passPrivilege = false;
	} else {
		privilegeInvalid.innerHTML = '';
		changePrivilege = true;
		passPrivilege = true;
	}
	data_valid();
}

// Checkout whether name change and name can't be empty.
function name_change(origin, input) {
	var invalid = document.getElementById('name_invalid');

	if (input.value === "") {
		invalid.innerHTML = "<span style='color: red; font-size: 14px'>Required</span>";
		passName = false;
	} else if (origin === input.value) {
		invalid.innerHTML = "";
		changeName = false;
	} else {
		invalid.innerHTML = '';
		changeName = true;
		passName = true;
	}
	data_valid();
}


// Checkout whether all of data is valid.
function data_valid() {
	var submit = document.getElementById('submit');

	if (changeName === true || changePrivilege === true) {
		if (passName === true && passPrivilege === true) {
			submit.disabled = false;
		} else {
			submit.disabled = true;
		}
	} else {
		submit.disabled = true;
	}
}