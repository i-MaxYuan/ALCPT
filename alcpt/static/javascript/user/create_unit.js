function is_selected() {
	var unitName = document.getElementById("unit_name");
	var unit = document.getElementById("unit");

	if (unit.value === "department" || unit.value === "squadron") {
		unitName.disabled = false;
	} else {
		unitName.disabled = true;
	}
}

function valid_name(input_unit) {
	var invalid = document.getElementById("invalid");
	var submit = document.getElementById("submit");

	if (input_unit.value === "") {
		invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Require</span>";
		submit.disabled = true;
	} else {
		invalid.innerHTML = "";
		submit.disabled = false;
	}
}