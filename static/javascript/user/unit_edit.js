function valid_name(origin, input) {
	var invalid = document.getElementById("invalid");
	var submit = document.getElementById("submit");

	if (input.value === "") {
		invalid.innerHTML =
			"<span style='color: red; font-size: 14px'>Require</span>";
		submit.disabled = true;
	} else if (origin === input.value) {
		invalid.innerHTML = "";
		submit.disabled = true;
	} else {
		invalid.innerHTML = "";
		submit.disabled = false;
	}
}